//
// Created by Kamel on 31/05/2023.
//

import XCTest
@testable import App

class HomeVMTests: XCTestCase {
    var subject: HomeVM!

    override func setUp() {
        super.setUp()
        subject = HomeVM()
    }

    override func tearDown() {
        subject = nil
        super.tearDown()
    }

}