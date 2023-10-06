//
//  CryptocurrencyPriceHistory.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 5/10/23.
//

import Foundation

struct CryptocurrencyPriceHistory {
    let prices: [DataPoint]
    
    struct DataPoint {
        let price: Double
        let date: Date
    }
}
    
