//
// Created by Kamel on 30/05/2023.
//

import XCTest
@testable import App
@testable import Cache

class CacheManagerMock: CacheManagerContract {
    var getReturnValue: Codable?
    var arrayReturnValue: [Codable] = []
    var saveCalled = false
    var saveParameters: (object: Codable, key: AppCacheKey, expiry: Expiry?)?
    var removeCalled = false
    var observeCalled = false
    var clearExpiredCalled = false

    func get<T: Codable>(_ key: AppCacheKey) async -> T? {
        getReturnValue as? T
    }

    func array<T: Codable>(_ key: AppCacheKey) async -> [T] {
        arrayReturnValue as? [T] ?? []
    }

    func save<T: Codable>(
            _ object: T,
            _ key: AppCacheKey,
            expiry: Expiry?
    ) async throws {
        saveCalled = true
        saveParameters = (object, key, expiry)
    }

    func remove(_ key: AppCacheKey) async {
        removeCalled = true
    }

    func observe<T: Codable, O: AnyObject>(
            _ observer: O,
            type: T.Type,
            key: AppCacheKey,
            closure: @escaping (T?) -> Void
    ) -> AppCacheObservationToken? {
        observeCalled = true
        return nil
    }

    func clearExpired(completion: @escaping (Error?) -> Void) {
        clearExpiredCalled = true
    }
}