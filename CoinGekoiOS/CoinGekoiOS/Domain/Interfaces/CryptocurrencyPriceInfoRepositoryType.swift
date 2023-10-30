//
//  CryptocurrencyPriceInfoRepositoryType.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 30/10/23.
//

import Foundation

protocol CryptocurrencyPriceInfoRepositoryType {
    func getPriceInfo(id: String) async -> Result<CryptocurrencyPriceInfo, CryptocurrecyDomainError>
}
