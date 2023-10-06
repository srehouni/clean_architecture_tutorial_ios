//
//  CryptocurrencyGlobalInfoDTO.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 24/9/23.
//

import Foundation

struct CryptocurrencyGlobalInfoDTO: Codable {
    let data: CryptocurrencyGlobalData
    
    struct CryptocurrencyGlobalData: Codable {
        let cryptocurrencies: [String : Double]
        
        enum CodingKeys: String, CodingKey {
            case cryptocurrencies = "market_cap_percentage"
        }
    }
}
