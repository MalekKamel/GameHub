//
// Created by Kamel on 14/03/2023.
//

import Foundation
import Cache

public typealias AppCacheStorage = HybridStorage<AppCacheKey, String>
public typealias AppCacheAsyncStorage = AsyncStorage<AppCacheKey, String>
public typealias AppCacheObservationToken = ObservationToken

public typealias AppCacheManager = CacheManager

public protocol CacheManagerContract {
    func get<T: Codable>(_ key: AppCacheKey) async -> T?

    func array<T: Codable>(_ key: AppCacheKey) async -> [T]

    func save<T: Codable>(
            _ object: T,
            _ key: AppCacheKey,
            expiry: Expiry?
    ) async throws

    func remove(_ key: AppCacheKey) async

    func observe<T: Codable, O: AnyObject>(
            _ observer: O,
            type: T.Type,
            key: AppCacheKey,
            closure: @escaping (T?) -> Void
    ) -> AppCacheObservationToken?

    func clearExpired(completion: @escaping (Error?) -> Void)
}

public class CacheManager: CacheManagerContract {

    public static let shared = CacheManager()

    private lazy var storage: AppCacheAsyncStorage? = {
        let memory = MemoryStorage<AppCacheKey, String>(config: MemoryConfig())
        let disk = try? DiskStorage<AppCacheKey, String>(
                config: DiskConfig(name: "GameHub"),
                transformer: TransformerFactory.forCodable(ofType: String.self)
        )
        guard let disk else {
            return nil
        }
        let hybrid = HybridStorage(memoryStorage: memory, diskStorage: disk)
        let storage: AppCacheAsyncStorage? = AsyncStorage(storage: hybrid, serialQueue: DispatchQueue(label: "com.game.hub.queue.AsyncCache"))
        return storage
    }()

    public func get<T: Codable>(_ key: AppCacheKey) async -> T? {
        await withCheckedContinuation { continuation in
            guard let cache = storage else {
                continuation.resume(returning: nil)
                return
            }
            clearExpired { error in
                guard error == nil else {
                    continuation.resume(returning: nil)
                    return
                }
                cache.object(forKey: key) { (result: Result<String>) in
                    do {
                        switch result {
                        case .value(let obj):
                            let value = try JSONDecoder().decode(T.self, from: Data(obj.utf8))
                            onMainThread {
                                continuation.resume(returning: value)
                            }
                        case .error(let error):
                            error.record()
                            continuation.resume(returning: nil)
                        }
                    } catch {
                        error.record()
                    }
                }
            }


        }
    }

    public func array<T: Codable>(_ key: AppCacheKey) async -> [T] {
        await get(key) ?? []
    }

    public func save<T: Codable>(
            _ object: T,
            _ key: AppCacheKey,
            expiry: Expiry? = nil
    ) async throws {
        guard let cache = storage else {
            return
        }
        let json = try JSONEncoder().encode(object)
        guard let string = String(data: json, encoding: .utf8) else {
            AppCrashlytics.record(description: "Caching Failure", failure: "Couldn't cache \(json)")
            return
        }
        cache.setObject(string, forKey: key, expiry: expiry) { result in
            switch result {
            case .value:
                break
            case .error(let error):
                error.record()
            }
        }
    }

    public func remove(_ key: AppCacheKey) async {
        guard let cache = storage else {
            return
        }
        cache.removeObject(forKey: key) { result in
            switch result {
            case .value:
                break
            case .error(let error):
                error.record()
            }
        }
    }

}

public extension CacheManager {

    func observe<T: Codable, O: AnyObject>(
            _ observer: O,
            type: T.Type,
            key: AppCacheKey,
            closure: @escaping (T?) -> Void
    ) -> AppCacheObservationToken? {
        guard let cache = storage else {
            return nil
        }

        // Send the current value to the closure
        Task {
            if let currentValue: T = await get(key) {
                closure(currentValue)
            }
        }

        return cache.innerStorage.addObserver(observer, forKey: key) { _, _, change in
            do {
                switch change {
                case .edit(_, let after):
                    let value = try JSONDecoder().decode(T.self, from: Data(after.utf8))
                    onMainThread {
                        closure(value)
                    }
                case .remove:
                    onMainThread {
                        closure(nil)
                    }
                }
            } catch {
                error.record()
            }
        }
    }

    func observeChange<T: Codable, O: AnyObject>(
            _ observer: O,
            type: T.Type,
            key: AppCacheKey,
            closure: @escaping (KeyChange<String>) -> Void
    ) -> ObservationToken? {
        guard let cache = storage else {
            return nil
        }
        return cache.innerStorage.addObserver(observer, forKey: key) { _, _, change in
            onMainThread {
                closure(change)
            }
        }
    }

    func observeStorage<T: Codable, O: AnyObject>(
            _ observer: O,
            type: T.Type,
            key: AppCacheKey,
            closure: @escaping (StorageChange<AppCacheKey>) -> Void
    ) -> ObservationToken? {
        guard let cache = storage else {
            return nil
        }
        return cache.innerStorage.addStorageObserver(observer) { _, _, change in
            closure(change)
        }
    }
}

extension CacheManager {

    public func clearExpired(completion: @escaping (Error?) -> Void) {
        guard let cache = storage else {
            return
        }
        cache.removeExpiredObjects { result in
            switch result {
            case .value(let value):
                print(value)
                completion(nil)
                break
            case .error(let error):
                completion(error)
                error.record()
            }
        }
    }
}