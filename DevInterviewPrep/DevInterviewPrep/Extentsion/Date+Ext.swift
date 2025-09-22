//
//  Date+Ext.swift
//  DevInterviewPrep
//
//  Created by Gergő  on 2025. 09. 20..
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: self)
    }
}
