//
//  FakeResponseData.swift
//  HBCVMTests
//
//  Created by arnaud kiefer on 02/02/2022.
//

import Foundation
import Alamofire

class FakeResponseData {

    // MARK: - Data
    static var CorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "matches", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static var CorrectLoadData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "match", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let incorrectData = "error".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://www.apple.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://www.apple.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!

    // MARK: - Error
    static let error = AFError.explicitlyCancelled
}
