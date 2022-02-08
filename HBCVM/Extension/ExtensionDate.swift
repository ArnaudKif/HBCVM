//
//  ExtensionDate.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//

import Foundation

extension Date {
    /// Transforms the date to the desired display format -> String
    func dateToString() -> String {
        let strDate = self.dateToStrDay()
        let strHour = self.dateToStrHour()
        return "\(strDate) à \(strHour)"
    }
    
    /// Convert the time to the desired format HH:mm -> String
    func dateToStrHour() -> String {
        let hourFormatter = DateFormatter()
        hourFormatter.locale = Locale(identifier: "fr_FR")
        hourFormatter.dateStyle = DateFormatter.Style.none
        hourFormatter.timeStyle = DateFormatter.Style.short
        hourFormatter.dateFormat = "HH:mm"
        let strHour = hourFormatter.string(from: self)
        return strHour
    }
    
    /// convert the date to the desired format -> String
    func dateToStrDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = DateFormatter.Style.none
        let strDate = dateFormatter.string(from: self)
        return strDate
    }
}
