//
//  CryptocurrencyPriceHistoryDTO.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 5/10/23.
//

import Foundation

struct CryptocurrencyPriceHistoryDTO: Codable {
    let prices: [[Double]]
    
    enum CodingKeys: String, CodingKey {
        case prices
    }
}
