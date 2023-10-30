//
//  SwiftDataContainerType.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 30/10/23.
//

import Foundation

protocol SwiftDataContainerType {
    func fetchCryptos() -> [CryptocurrencyBasicInfoData]
    func insert(_ cryptoList: [CryptocurrencyBasicInfoData]) async
}
