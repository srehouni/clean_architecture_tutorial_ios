//
//  Cryptocurrency.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 19/9/23.
//

import Foundation

struct Cryptocurrency {
    let id: String
    let name: String
    let symbol: String
    let price: Double
    let price24h: Double?
    let volume24h: Double?
    let marketCap: Double
}
