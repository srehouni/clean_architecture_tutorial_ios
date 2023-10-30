//
//  SwiftDataCacheBasicInfoDataSource.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 30/10/23.
//

import Foundation

class SwiftDataCacheBasicInfoDataSource: CacheCryptocurrencyBasicInfoDataSourceType {
    private let container: SwiftDataContainerType
    
    init(container: SwiftDataContainerType) {
        self.container = container
    }
    
    func getCryptoList() async -> [CryptocurrencyBasicInfo] {
        let cryptoList = container.fetchCryptos()
        return cryptoList.map { CryptocurrencyBasicInfo(id: $0.id, name: $0.name, symbol: $0.symbol) }
    }
    
    func saveCryptoList(_ cryptoList: [CryptocurrencyBasicInfo]) async {
        let cryptoListData = cryptoList.map { CryptocurrencyBasicInfoData(id: $0.id, name: $0.name, symbol: $0.symbol) }
        await container.insert(cryptoListData)
    }
}
