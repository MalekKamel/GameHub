//
// Created by Kamel on 31/05/2023.
//

import XCTest

extension XCTestCase {
    func runAsyncTest(
            named testName: String = #function,
            in file: StaticString = #file,
            at line: UInt = #line,
            withTimeout timeout: TimeInterval = 10,
            test: @escaping () -> Void
    ) {
        let expectation = expectation(description: testName)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            test()
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
