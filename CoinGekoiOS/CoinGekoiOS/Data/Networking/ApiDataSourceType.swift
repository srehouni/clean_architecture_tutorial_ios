//
//  ApiDataSourceType.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 19/9/23.
//

import Foundation

protocol ApiDataSourceType {
    func getGlobalCryptoSymbolList() async -> Result<[String], HTTPClientError>
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError>
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String: CryptocurrencyPriceInfoDTO], HTTPClientError>
}
