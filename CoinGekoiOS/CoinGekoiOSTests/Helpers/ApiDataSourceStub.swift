//
//  ApiDataSourceStub.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 17/1/24.
//

import Foundation
@testable import CoinGekoiOS

class ApiDataSourceStub {
    private let globalCryptoSymbolList: Result<[String], HTTPClientError>
    private let cryptoList: Result<[CryptocurrencyBasicDTO], HTTPClientError>
    private let priceInfo: Result<[String: CryptocurrencyPriceInfoDTO], HTTPClientError>
    
    init(globalCryptoSymbolList: Result<[String], HTTPClientError>, cryptoList: Result<[CryptocurrencyBasicDTO], HTTPClientError>, priceInfo: Result<[String : CryptocurrencyPriceInfoDTO], HTTPClientError>) {
        self.globalCryptoSymbolList = globalCryptoSymbolList
        self.cryptoList = cryptoList
        self.priceInfo = priceInfo
    }
}

extension ApiDataSourceStub: ApiDataSourceCryptoType {
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError> {
        return cryptoList
    }
}

extension ApiDataSourceStub: ApiDataSourceSymbolType {
    func getGlobalCryptoSymbolList() async -> Result<[String], HTTPClientError> {
        return globalCryptoSymbolList
    }
}

extension ApiDataSourceStub: ApiDataSourcePriceInfoType {
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String: CryptocurrencyPriceInfoDTO], HTTPClientError> {
        return priceInfo
    }
}
