//
//  ApiDataSourceType.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 19/9/23.
//

import Foundation

protocol ApiDataSourcePriceInfoType {
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String: CryptocurrencyPriceInfoDTO], HTTPClientError>
}

protocol ApiDataSourceSymbolType {
    func getGlobalCryptoSymbolList() async -> Result<[String], HTTPClientError>
}

protocol ApiDataSourceCryptoType {
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError>
}
