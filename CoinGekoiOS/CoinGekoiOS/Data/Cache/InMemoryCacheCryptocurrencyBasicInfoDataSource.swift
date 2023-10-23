//
//  InMemoryCacheCryptocurrencyBasicInfoDataSource.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 22/10/23.
//

import Foundation

actor InMemoryCacheCryptocurrencyBasicInfoDataSource: CacheCryptocurrencyBasicInfoDataSourceType {
    static let shared: InMemoryCacheCryptocurrencyBasicInfoDataSource = InMemoryCacheCryptocurrencyBasicInfoDataSource()
    
    private var cache: [CryptocurrencyBasicInfo] = []
    
    private init() {}
    
    func getCryptoList() async -> [CryptocurrencyBasicInfo] {
        return cache
    }
    
    func saveCryptoList(_ cryptoList: [CryptocurrencyBasicInfo]) async {
        self.cache = cryptoList
    }
}
