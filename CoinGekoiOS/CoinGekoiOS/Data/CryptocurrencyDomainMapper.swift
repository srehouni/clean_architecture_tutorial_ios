//
//  CryptocurrencyDomainMapper.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 19/9/23.
//

import Foundation

class CryptocurrencyDomainMapper {
    func getCryptocurrencyBuilderList(symbolList: [String], cryptoList: [CryptocurrencyBasicDTO]) -> [CryptocurrencyBuilder] {
        var symbolListDic = [String: Bool]()
        
        symbolList.forEach { symbol in
            symbolListDic[symbol] = true
        }
        
        let globalCryptoList = cryptoList.filter { symbolListDic[$0.symbol] ?? false }
        
        let cryptocurrencyBuilderList = globalCryptoList.map { CryptocurrencyBuilder(id: $0.id, name: $0.name, symbol: $0.symbol) }
        
        return cryptocurrencyBuilderList
    }
    
    func map(cryptocurrencyBuilderList: [CryptocurrencyBuilder], priceInfo: [String: CryptocurrencyPriceInfoDTO]) -> [Cryptocurrency] {
        
        cryptocurrencyBuilderList.forEach { cryptocurrencyBuilder in
            if let priceInfo = priceInfo[cryptocurrencyBuilder.id] {
                cryptocurrencyBuilder.price = priceInfo.price
                cryptocurrencyBuilder.volume24h = priceInfo.volume24h
                cryptocurrencyBuilder.marketCap = priceInfo.marketCap
                cryptocurrencyBuilder.price24h = priceInfo.price24h
            }
        }
        
        return cryptocurrencyBuilderList.compactMap { $0.build() }
    }
}
