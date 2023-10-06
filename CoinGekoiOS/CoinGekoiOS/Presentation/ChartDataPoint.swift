//
//  ChartDataPoint.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 5/10/23.
//

import Foundation

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}
