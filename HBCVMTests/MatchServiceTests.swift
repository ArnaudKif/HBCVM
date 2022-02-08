//
//  MatchServiceTests.swift
//  HBCVMTests
//
//  Created by arnaud kiefer on 02/02/2022.
//

import XCTest
import Alamofire
@testable import HBCVM

class MatchServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testLoadResponseIfDataOK_ResponseOK_ErrorIsNil() {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.CorrectLoadData,
            response: FakeResponseData.responseOK,
            error: nil)
        fakeMatchService = MatchService(alamSession: MatchSessionFake.init(fakeResponse: fakeResponseData))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        let req = fakeMatchService.createPostRequest(match: match)
        fakeMatchService.load(request: req) { result in
            guard let status = result?.response?.statusCode else {
                XCTFail("Error Status Response Test")
                return
            }
            guard let data = result?.data else {
                XCTFail("Error Data Response Test")
                return
            }
            expectation.fulfill()
            XCTAssertEqual(200, status)
            XCTAssertFalse(data.isEmpty)
            XCTAssertNotNil(result?.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testResponseIfDataOK_ResponseOK_ErrorIsNil() {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.CorrectData,
            response: FakeResponseData.responseOK,
            error: nil)
        fakeMatchService = MatchService(alamSession: MatchSessionFake.init(fakeResponse: fakeResponseData))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        fakeMatchService.getMatchWithTeam(team: "U13") { result in
            guard let status = result?.response?.statusCode else {
                XCTFail("Error Status Response Test")
                return
            }
            guard let data = result?.data else {
                XCTFail("Error Data Response Test")
                return
            }
            let dateFirstMatch = result?.value?.first?.date
            let advFirstMatch = result?.value?.first?.adversaryTeamName
            expectation.fulfill()
            XCTAssertEqual(200, status)
            XCTAssertEqual(dateFirstMatch, "2000-01-01T00:00:00Z")
            XCTAssertEqual(advFirstMatch, "Test1")
            XCTAssertFalse(data.isEmpty)
            XCTAssertNil(result?.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testResponseIfDataKO_ResponseOK_ErrorIsNil() {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil)
        fakeMatchService = MatchService(alamSession: MatchSessionFake.init(fakeResponse: fakeResponseData))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        fakeMatchService.getMatchWithTeam(team: "U13") { result in
            guard let status = result?.response?.statusCode else {
                XCTFail("Error Status Response Test")
                return
            }
            guard let data = result?.data else {
                XCTFail("Error Data Response Test")
                return
            }
            expectation.fulfill()
            XCTAssertEqual(200, status)
            XCTAssertEqual(self.incorrectData, data)
            XCTAssertNotNil(result?.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testResponseIfDataOK_ResponseKO_ErrorIsNil_UrlKO() {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.CorrectData,
            response: FakeResponseData.responseKO,
            error: nil)
        fakeMatchService = MatchService(alamSession: MatchSessionFake.init(fakeResponse: fakeResponseData))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        fakeMatchService.getMatchWithTeam(team: "error 12") { result in
            guard let status = result?.response?.statusCode else {
                XCTFail("Error Status Response Test")
                return
            }
            guard let data = result?.data else {
                XCTFail("Error Data Response Test")
                return
            }
            expectation.fulfill()
            XCTAssertEqual(500, status)
            XCTAssertNotEqual(self.incorrectData, data)
            XCTAssertNil(result?.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testResponseIfDataKO_ResponseKO_ErrorIsNotNil() {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseKO,
            error: FakeResponseData.error)
        fakeMatchService = MatchService(alamSession: MatchSessionFake.init(fakeResponse: fakeResponseData))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        fakeMatchService.getMatchWithTeam(team: "U13") { result in
            guard let status = result?.response?.statusCode else {
                XCTFail("Error Status Response Test")
                return
            }
            guard let data = result?.data else {
                XCTFail("Error Data Response Test")
                return
            }
            expectation.fulfill()
            XCTAssertEqual(500, status)
            XCTAssertEqual(self.incorrectData, data)
            XCTAssertNotNil(result?.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testResponseIfDataOK_ResponseKO_ErrorIsNil() {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.CorrectData,
            response: FakeResponseData.responseKO,
            error: nil)
        fakeMatchService = MatchService(alamSession: MatchSessionFake.init(fakeResponse: fakeResponseData))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        fakeMatchService.getMatchWithTeam(team: "U13") { result in
            guard let status = result?.response?.statusCode else {
                XCTFail("Error Status Response Test")
                return
            }
            guard let data = result?.data else {
                XCTFail("Error Data Response Test")
                return
            }
            expectation.fulfill()
            XCTAssertEqual(500, status)
            XCTAssertNotEqual(self.incorrectData, data)
            XCTAssertNil(result?.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testResponseIfDataOK_ResponseOK_ErrorIsNotNil() {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.CorrectData,
            response: FakeResponseData.responseOK,
            error: FakeResponseData.error)
        fakeMatchService = MatchService(alamSession: MatchSessionFake.init(fakeResponse: fakeResponseData))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        fakeMatchService.getMatchWithTeam(team: "U13") { result in
            guard let status = result?.response?.statusCode else {
                XCTFail("Error Status Response Test")
                return
            }
            guard let data = result?.data else {
                XCTFail("Error Data Response Test")
                return
            }
            expectation.fulfill()
            XCTAssertEqual(200, status)
            XCTAssertNotEqual(self.incorrectData, data)
            XCTAssertNotNil(result?.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    // MARK: - Tools for test : Properties
    var fakeResponseData : FakeAlamoResponse!
    var fakeMatchService: MatchService!
    var urlSession : URLSession!
    let incorrectData = "error".data(using: .utf8)!

    let match = Match(id: UUID(uuidString: "11111111-BBBB-0000-AAAA-999999999999"), teamName: "U13M", adversaryTeamName: "BAVANS", date: "2000-01-01T00:00:00Z", isInHome: true, matchAdress: "Gymnase Courvoisier, Rue Du Breuil 25350 Mandeure", comment: "pensez aux ballons", team1Score: nil, team2Score: nil)
}
