//
//  ApiPriceDataSourceStub.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 17/1/24.
//

import Foundation
@testable import CoinGekoiOS

class ApiPriceDataSourceStub: ApiPriceDataSourceType {
    var getPriceHistory: Result<CryptocurrencyPriceHistoryDTO, HTTPClientError>?
    var getPriceInfoForCryptos: Result<[String : CryptocurrencyPriceInfoDTO], HTTPClientError>?
    
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistoryDTO, HTTPClientError> {
        return getPriceHistory!
    }
    
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String : CryptocurrencyPriceInfoDTO], HTTPClientError> {
        return getPriceInfoForCryptos!
    }
}
