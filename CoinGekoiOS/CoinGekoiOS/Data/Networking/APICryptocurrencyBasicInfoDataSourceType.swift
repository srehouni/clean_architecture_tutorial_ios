//
//  APICryptocurrencyBasicInfoDataSourceType.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 22/10/23.
//

import Foundation

protocol APICryptocurrencyBasicInfoDataSourceType {
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError>
}
