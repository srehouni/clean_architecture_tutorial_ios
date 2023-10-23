//
//  SearchCryptoListBasicInfoRespositoryType.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 22/10/23.
//

import Foundation

protocol SearchCryptoListBasicInfoRepositoryType {
    func search(crypto: String) async -> Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError>
}
