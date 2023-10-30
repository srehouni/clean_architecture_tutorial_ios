//
//  StrategyCacheCryptocurrencyBasicInfo.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 30/10/23.
//

import Foundation

class StrategyCacheCryptocurrencyBasicInfo: CacheCryptocurrencyBasicInfoDataSourceType {
    private let temporalCache: CacheCryptocurrencyBasicInfoDataSourceType
    private let persistanceCache: CacheCryptocurrencyBasicInfoDataSourceType
    
    init(temporalCache: CacheCryptocurrencyBasicInfoDataSourceType, persistanceCache: CacheCryptocurrencyBasicInfoDataSourceType) {
        self.temporalCache = temporalCache
        self.persistanceCache = persistanceCache
    }
    
    func getCryptoList() async -> [CryptocurrencyBasicInfo] {
        let temporalCryptoList = await temporalCache.getCryptoList()
        
        if !temporalCryptoList.isEmpty {
            return temporalCryptoList
        }
        
        let persitanceCryptoList = await persistanceCache.getCryptoList()
        await temporalCache.saveCryptoList(persitanceCryptoList)
        
        return persitanceCryptoList
    }
    
    func saveCryptoList(_ cryptoList: [CryptocurrencyBasicInfo]) async {
        await temporalCache.saveCryptoList(cryptoList)
        await persistanceCache.saveCryptoList(cryptoList)
    }
}
