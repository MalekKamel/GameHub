//
// Created by Kamel on 31/05/2023.
//

import XCTest
@testable import App

class HomeVMTests: XCTestCase {
    var homeVM: HomeVM!

    override func setUp() {
        super.setUp()
        homeVM = HomeVM()
    }

    override func tearDown() {
        homeVM = nil
        super.tearDown()
    }

}