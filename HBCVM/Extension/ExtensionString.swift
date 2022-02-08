//
//  ExtensionString.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//

import Foundation

extension String {
    /// Transforms String to the desired date format -> Date
    func strToDate() -> Date {
        let returnedDate: Date
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: self) {
            returnedDate = date
        } else {
            returnedDate = Date()
        }
        return returnedDate
    }

    /// Transforms String to the date format for DB -> Date
    func strDateForDisplay() -> String {
        let returnedStrDate : String
        let formatter = ISO8601DateFormatter()
        if let IsoDate = formatter.date(from: self) {
            returnedStrDate = IsoDate.dateToString()
        } else {
            returnedStrDate = self
        }
        return returnedStrDate
    }
}
