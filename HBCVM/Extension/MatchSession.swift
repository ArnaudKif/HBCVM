//
//  MatchSession.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, method : HTTPMethod, callBack: @escaping(_ result: DataResponse<[Match], AFError>?) -> Void)

    func loadMatch(with request: URLRequest, callBack: @escaping(_ result: DataResponse<Match, AFError>?) -> Void)

    var dbUrl: URL { get }
    var updateUrl: URL { get }

}

final class MatchSession: AlamoSession {

    func loadMatch(with request: URLRequest, callBack: @escaping (DataResponse<Match, AFError>?) -> Void) {
        AF.request(request).responseDecodable(of: Match.self) { (DataResponse) in
            callBack(DataResponse)
        }
    }

    func request(with url: URL, method: HTTPMethod, callBack: @escaping(_ result: DataResponse<[Match], AFError>?) -> Void) {
        AF.request(url).responseDecodable(of: [Match].self) { (DataResponse) in
            callBack(DataResponse)
        }
    }

    let dbUrl = URL(string: "http://13.36.254.41:80/matches")!
    let updateUrl = URL(string: "http://13.36.254.41:80/update")!

}
