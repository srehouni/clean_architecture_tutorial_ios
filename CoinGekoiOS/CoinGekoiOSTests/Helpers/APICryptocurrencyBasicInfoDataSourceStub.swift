//
//  APICryptocurrencyBasicInfoDataSourceStub.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 17/1/24.
//

import Foundation
@testable import CoinGekoiOS

class APICryptocurrencyBasicInfoDataSourceStub: APICryptocurrencyBasicInfoDataSourceType {
    private let getCryptoList: Result<[CryptocurrencyBasicDTO], HTTPClientError>
    
    init(getCryptoList: Result<[CryptocurrencyBasicDTO], HTTPClientError>) {
        self.getCryptoList = getCryptoList
    }
    
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError> {
        return getCryptoList
    }
}
