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

    // MARK: - Tests the response for the load function
    func testLoadResponseIfDataOK_ResponseOK_ErrorIsNotNil() {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.CorrectLoadData,
            response: FakeResponseData.responseOK,
            error: FakeResponseData.error)
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

    func testLoadResponseIfDataOK_ResponseKO_ErrorIsNil() {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.CorrectLoadData,
            response: FakeResponseData.responseKO,
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
            XCTAssertEqual(500, status)
            XCTAssertFalse(data.isEmpty)
            XCTAssertNotNil(result?.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testLoadResponseIfDataKO_ResponseKO_ErrorIsNotNil() {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseKO,
            error: FakeResponseData.error)
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
            XCTAssertEqual(500, status)
            XCTAssertFalse(data.isEmpty)
            XCTAssertNotNil(result?.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testLoadResponseIfDataKO_ResponseKO_ErrorIsNil() {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseKO,
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
            XCTAssertEqual(500, status)
            XCTAssertFalse(data.isEmpty)
            XCTAssertNotNil(result?.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testLoadResponseIfDataKO_ResponseOK_ErrorIsNil() {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.incorrectData,
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

    // MARK: - Tests the response for the getMatch function
    func testGetResponseIfDataOK_ResponseOK_ErrorIsNil() {
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

    func testGetResponseIfDataKO_ResponseOK_ErrorIsNil() {
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

    func testGetResponseIfDataOK_ResponseKO_ErrorIsNil_UrlKO() {
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

    func testGetResponseIfDataKO_ResponseKO_ErrorIsNotNil() {
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

    func testGetResponseIfDataOK_ResponseKO_ErrorIsNil() {
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

    func testGetResponseIfDataOK_ResponseOK_ErrorIsNotNil() {
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
    let incorrectData = "error".data(using: .utf8)!

    let match = Match(id: UUID(uuidString: "11111111-BBBB-0000-AAAA-999999999999"), teamName: "U13M", adversaryTeamName: "BAVANS", date: "2000-01-01T00:00:00Z", isInHome: true, matchAdress: "Gymnase Courvoisier, Rue Du Breuil 25350 Mandeure", comment: "pensez aux ballons", team1Score: nil, team2Score: nil)
}
