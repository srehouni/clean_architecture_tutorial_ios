//
//  Equatable.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 1/11/23.
//

import Foundation
@testable import CoinGekoiOS

extension CryptocurrencyBasicInfo: Equatable {
    public static func == (lhs: CryptocurrencyBasicInfo, rhs: CryptocurrencyBasicInfo) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.symbol == rhs.symbol
    }
}

extension Cryptocurrency: Equatable {
    public static func == (lhs: Cryptocurrency, rhs: Cryptocurrency) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.symbol == rhs.symbol
        && lhs.price == rhs.price
        && lhs.price24h == rhs.price24h
        && lhs.volume24h == rhs.volume24h
        && lhs.marketCap == rhs.marketCap
    }
}

extension CryptocurrencyPriceInfo: Equatable {
    public static func == (lhs: CryptocurrencyPriceInfo, rhs: CryptocurrencyPriceInfo) -> Bool {
        return lhs.price == rhs.price
        && lhs.price24h == rhs.price24h
        && lhs.volume24h == rhs.volume24h
        && lhs.marketCap == rhs.marketCap
    }
}

extension CryptocurrencyPriceHistory: Equatable {
    public static func == (lhs: CoinGekoiOS.CryptocurrencyPriceHistory, rhs: CoinGekoiOS.CryptocurrencyPriceHistory) -> Bool {
        return lhs.prices == rhs.prices
    }
}

extension CryptocurrencyPriceHistory.DataPoint: Equatable {
    public static func == (lhs: CryptocurrencyPriceHistory.DataPoint, rhs: CryptocurrencyPriceHistory.DataPoint) -> Bool {
        return lhs.price == rhs.price && lhs.date == rhs.date
    }
}
