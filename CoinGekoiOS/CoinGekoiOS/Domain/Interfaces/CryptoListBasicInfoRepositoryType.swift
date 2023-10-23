//
//  CryptoListBasicInfoRepositoryType.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 22/10/23.
//

import Foundation

protocol CryptoListBasicInfoRepositoryType {
    func getCryptoList() async -> Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError>
}
