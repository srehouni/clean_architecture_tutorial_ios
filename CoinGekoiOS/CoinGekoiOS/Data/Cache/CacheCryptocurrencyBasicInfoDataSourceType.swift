//
//  CacheCryptocurrencyBasicInfoDataSourceType.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 22/10/23.
//

import Foundation

protocol CacheCryptocurrencyBasicInfoDataSourceType {
    func getCryptoList() async -> [CryptocurrencyBasicInfo]
    func saveCryptoList(_ cryptoList: [CryptocurrencyBasicInfo]) async
}
