//
//  CacheCryptocurrencyBasicInfoDataSourceStub.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 17/1/24.
//

import Foundation
@testable import CoinGekoiOS

class CacheCryptocurrencyBasicInfoDataSourceStub: CacheCryptocurrencyBasicInfoDataSourceType {
    private let getCryptoList: [CryptocurrencyBasicInfo]
    var cachedCryptoList: [CryptocurrencyBasicInfo]?
    
    init(getCryptoList: [CryptocurrencyBasicInfo]) {
        self.getCryptoList = getCryptoList
    }
    
    func getCryptoList() async -> [CryptocurrencyBasicInfo] {
        return getCryptoList
    }
    
    func saveCryptoList(_ cryptoList: [CryptocurrencyBasicInfo]) async {
        cachedCryptoList = cryptoList
    }
}
