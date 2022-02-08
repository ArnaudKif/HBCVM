//
//  FakeSession.swift
//  HBCVMTests
//
//  Created by arnaud kiefer on 02/02/2022.
//

import Foundation
import Alamofire
@testable import HBCVM


struct FakeAlamoResponse {
    var data: Data?
    var response: HTTPURLResponse?
    var error : AFError?
}

class MatchSessionFake: AlamoSession {
    // MARK: - Properties of protocol compliance
    let updateUrl = URL(string: "http://127.0.0.1:8080/update")!
    let dbUrl = URL(string: "http://127.0.0.1:8080/matches")!

    // MARK: - Method of protocol compliance
    func loadMatch(with request: URLRequest, callBack: @escaping (DataResponse<Match, AFError>?) -> Void) {
        guard let httpResponse = fakeAlamoResponse.response else {
            callBack(.init(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0.0, result: .failure(.explicitlyCancelled)))
            return
        }
        guard let requestData = fakeAlamoResponse.data else {
            callBack(.init(request: nil, response: httpResponse, data: nil, metrics: nil, serializationDuration: 0.0, result: .failure(.explicitlyCancelled)))
            return
        }
        let urlRequest = request
        guard let object = try? JSONDecoder().decode(Match.self, from: requestData) else {
            callBack(.init(request: urlRequest, response: httpResponse, data: requestData, metrics: nil, serializationDuration: 0.0, result: .failure(.explicitlyCancelled)))
            return
        }
        let result: Result<Match,AFError> = fakeAlamoResponse.error == nil ? .success(object as Match) : .failure(fakeAlamoResponse.error ?? AFError.explicitlyCancelled)
        let dataResponse = AFDataResponse(request: urlRequest, response: httpResponse, data: requestData, metrics: nil, serializationDuration: 0.0, result: result)
        callBack(dataResponse)
    }

    func request(with url: URL, method: HTTPMethod, callBack: @escaping (DataResponse<[Match], AFError>?) -> Void) {
        guard let httpResponse = fakeAlamoResponse.response else {
            callBack(.init(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0.0, result: .failure(.explicitlyCancelled)))
            return
        }
        guard let requestData = fakeAlamoResponse.data else {
            callBack(.init(request: nil, response: httpResponse, data: nil, metrics: nil, serializationDuration: 0.0, result: .failure(.explicitlyCancelled)))
            return
        }
        let urlRequest = URLRequest(url: url)
        guard let object = try? JSONDecoder().decode([Match].self, from: requestData) else {
            callBack(.init(request: urlRequest, response: httpResponse, data: requestData, metrics: nil, serializationDuration: 0.0, result: .failure(.explicitlyCancelled)))
            return
        }
        let result: Result<[Match],AFError> = fakeAlamoResponse.error == nil ? .success(object as [Match]) : .failure(fakeAlamoResponse.error ?? AFError.explicitlyCancelled)
        let dataResponse = AFDataResponse(request: urlRequest, response: httpResponse, data: requestData, metrics: nil, serializationDuration: 0.0, result: result)
        callBack(dataResponse)
    }

    // MARK: - Properties
    private let fakeAlamoResponse: FakeAlamoResponse

    // MARK: - Initializer
    init(fakeResponse: FakeAlamoResponse) {
        self.fakeAlamoResponse = fakeResponse
    }



}
