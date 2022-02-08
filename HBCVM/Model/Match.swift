//
//  Match.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//

import Foundation

struct Match: Decodable {
    let id: UUID?
    let teamName: String
    let adversaryTeamName: String
    let date: String
    let isInHome : Bool
    let matchAdress: String
    let comment : String
    let team1Score: Int?
    let team2Score: Int?
}
