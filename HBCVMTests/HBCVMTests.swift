//
//  HBCVMTests.swift
//  HBCVMTests
//
//  Created by arnaud kiefer on 02/02/2022.
//
import XCTest
@testable import HBCVM

class HBCVMTests: XCTestCase {

    // MARK: - Tests the creation of a request
    func testDeleteUrlCreation() {
        let testRequest =  MatchService.matchService.createDeleteRequest(withMatch: match)
        XCTAssertEqual(testRequest.httpMethod, "DELETE")
        XCTAssertEqual(testRequest.description, deleteUrlDescription)
    }

    func testDeleteBadMatchUrlCreation() {
        let urlDescription = "http://13.36.254.41:80/matches/6EB94141-FBEB-450B-AAA1-6E9B00914D98"
        let testRequest =  MatchService.matchService.createDeleteRequest(withMatch: newMatch)
        XCTAssertEqual(testRequest.httpMethod, "DELETE")
        XCTAssertEqual(testRequest.description, urlDescription)
    }

    func testUpdateRequestCreation() {
        let testRequest = MatchService.matchService.createUpdateRequest(match: match)
        XCTAssertEqual(testRequest.httpMethod, "POST")
        XCTAssertEqual(testRequest.description, updateUrlDescription)
    }

    func testPostRequestCreation() {
        let testRequest = MatchService.matchService.createPostRequest(match: match)
        XCTAssertEqual(testRequest.httpMethod, "POST")
        XCTAssertEqual(testRequest.description, postUrlDescription)
    }

    // MARK: - Tools for test : Properties
    let match = Match(id: UUID(uuidString: "11111111-BBBB-0000-AAAA-999999999999"), teamName: "U13M", adversaryTeamName: "BAVANS", date: "Samedi 05 Janvier 2022 à 15:00", isInHome: true, matchAdress: "Gymnase Courvoisier, Rue Du Breuil 25350 Mandeure", comment: "pensez aux ballons", team1Score: nil, team2Score: nil)
    let newMatch = Match(id: nil, teamName: "U13M", adversaryTeamName: "BAVANS", date: "Samedi 05 Janvier 2022 à 15:00", isInHome: true, matchAdress: "Gymnase Courvoisier, Rue Du Breuil 25350 Mandeure", comment: "pensez aux ballons", team1Score: nil, team2Score: nil)
    let deleteUrlDescription = "http://13.36.254.41:80/matches/11111111-BBBB-0000-AAAA-999999999999"
    let updateUrlDescription = "http://13.36.254.41:80/update/11111111-BBBB-0000-AAAA-999999999999"
    let postUrlDescription = "http://13.36.254.41:80/matches"
}
