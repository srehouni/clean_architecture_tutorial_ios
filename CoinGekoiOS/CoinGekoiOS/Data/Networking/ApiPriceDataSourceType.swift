//
//  ApiPriceDataSourceType.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 5/10/23.
//

import Foundation

protocol ApiPriceDataSourceType {
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistoryDTO, HTTPClientError>
}
