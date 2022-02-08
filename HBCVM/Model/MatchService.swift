//
//  MatchService.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.

import Foundation
import Alamofire

class MatchService {
    // MARK: - Pattern Singleton
    public static let matchService = MatchService()

    public init(alamSession: AlamoSession = MatchSession()) {
        self.alamoSession = alamSession
    }

    // MARK: - Methods
    private let alamoSession: AlamoSession

    // MARK: - AlamoSession Methods
    /// Launch the alamofire.request with Get method -> callback
    func getMatchWithTeam(team: String, callback: @escaping(_ result: DataResponse<[Match], AFError>?) -> Void) {
        let url: URL
        if let urlTeam = URL(string: "http://13.36.254.41:80/matches/\(team)/") {
            url = urlTeam
        } else {
            url = alamoSession.dbUrl
        }
        alamoSession.request(with: url, method: .get) { result in
            callback(result)
        }
    }

    ///Launch the alamofire.request with the method included in the request parameter -> callback
    func load(request: URLRequest, callback: @escaping(_ result: DataResponse<Match, AFError>?) -> Void) {
        alamoSession.loadMatch(with: request) { result in
            callback(result)
        }
    }

    // MARK: - Methods for creation of Request
    /// Creation of a query that adds the match
    func createPostRequest(match: Match) -> URLRequest {
        let parameters = "{\n    \"team2Score\": null,\n    \"comment\": \"\(match.comment)\",\n    \"adversaryTeamName\": \"\(match.adversaryTeamName)\",\n    \"isInHome\": \(match.isInHome),\n    \"date\": \"\(match.date)\",\n    \"team1Score\": null,\n    \"teamName\": \"\(match.teamName)\",\n    \"matchAdress\": \"\(match.matchAdress)\"\n}"
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: alamoSession.dbUrl,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        return request
    }

    /// Creation of a query that delete the match
    func createDeleteRequest(withMatch: Match) -> URLRequest {
        var idToDelete: String
        guard let matchID = withMatch.id else {
            idToDelete = "6EB94141-FBEB-450B-AAA1-6E9B00914D98"
            var badRequest = URLRequest(url: URL(string: "\(alamoSession.dbUrl)/\(idToDelete)")!,timeoutInterval: Double.infinity)
            badRequest.httpMethod = "DELETE"
            return badRequest
        }
        idToDelete = matchID.uuidString
        var request = URLRequest(url: URL(string: "\(alamoSession.dbUrl)/\(idToDelete)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "DELETE"
        return request
    }

    /// Creation of a query that update the match
    func createUpdateRequest(match: Match) -> URLRequest {
        let idToDelete = match.id!.uuidString
        let parameters = "{\n    \"team2Score\": \(match.team2Score ?? 0),\n    \"comment\": \"\(match.comment)\",\n    \"adversaryTeamName\": \"\(match.adversaryTeamName)\",\n    \"isInHome\": \(match.isInHome),\n    \"date\": \"\(match.date)\",\n    \"team1Score\": \(match.team1Score ?? 0),\n    \"teamName\": \"\(match.teamName)\",\n    \"matchAdress\": \"\(match.matchAdress)\"\n}"
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "\(alamoSession.updateUrl)/\(idToDelete)")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        return request
    }

}
