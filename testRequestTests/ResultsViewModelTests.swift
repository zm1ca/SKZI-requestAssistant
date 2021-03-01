//
//  ResultsViewModelTests.swift
//  testRequestTests
//
//  Created by Źmicier Fiedčanka on 26.02.21.
//

import XCTest
@testable import testRequest

class ResultsViewModelTests: XCTestCase {
    
    var request: Request?

    //MARK: - Request Testing
    func testUnusedMechanisms1() {
        request = Request(
            named: "Test",
            by: "TestOrg",
            with: [.software, .brng, .beltModes, .bignKeyt, .beltMac, .belsShare, .bignCurves]
        )
        
        let viewModel = ResultsViewModel(request: request!)
        let expectedUnusedMechanisms: [Mechanism] = [.belsShare, .bignCurves]
        
        XCTAssertEqual(viewModel.unusedMechanisms, expectedUnusedMechanisms)
    }
}
