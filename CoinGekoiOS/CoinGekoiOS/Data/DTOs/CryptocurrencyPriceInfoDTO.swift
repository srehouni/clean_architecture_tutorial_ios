//
//  CryptocurrencyPriceInfoDTO.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 19/9/23.
//

import Foundation

struct CryptocurrencyPriceInfoDTO: Codable {
    let price: Double
    let marketCap: Double
    let volume24h: Double?
    let price24h: Double?
    
    enum CodingKeys: String, CodingKey {
        case price = "usd"
        case marketCap = "usd_market_cap"
        case volume24h = "usd_24h_vol"
        case price24h = "usd_24h_change"
    }
}
