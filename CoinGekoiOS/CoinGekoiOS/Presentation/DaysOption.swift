//
//  DaysOption.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 5/10/23.
//

import Foundation

enum DaysOption: String, CaseIterable, Equatable {
    case month = "30d"
    case ninty = "90d"
    case hundredeighty = "180d"
    case year = "1a"
    
    func toInt() -> Int {
        switch self {
            case .month:
                return 30
            case .ninty:
                return 90
            case .hundredeighty:
                return 180
            case .year:
                return 365
        }
    }
}
