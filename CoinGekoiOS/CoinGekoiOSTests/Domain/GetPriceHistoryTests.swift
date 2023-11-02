//
//  GetPriceHistoryTests.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 1/11/23.
//

import XCTest
@testable import CoinGekoiOS

final class GetPriceHistoryTests: XCTestCase {

    func test_execute_returns_succesfully_priceHistory_when_repository_returns_priceHistory() async {
        // GIVEN
        let mockArray = [
            CryptocurrencyPriceHistory.DataPoint(price: 1, date: Date()),
            CryptocurrencyPriceHistory.DataPoint(price: 2, date: Date()),
            CryptocurrencyPriceHistory.DataPoint(price: 3, date: Date())
        ]
        let priceHistory = CryptocurrencyPriceHistory(prices: mockArray)
        let result: Result<CryptocurrencyPriceHistory, CryptocurrecyDomainError> = .success(priceHistory)
        let stub = CryptocurrencyPriceHistoryRepositoryStub(result: result)
        let sut = GetPriceHistory(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute(id: "", days: 0)
        
        // THEN
        XCTAssertEqual(capturedResult, result)
    }
    
    func test_execute_returns_error_when_repository_returns_error() async {
        // GIVEN
        let result: Result<CryptocurrencyPriceInfo, CryptocurrecyDomainError> = .failure(.generic)
        let stub = CryptocurrencyPriceInfoRepositoryStub(result: result)
        let sut = GetPriceInfo(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute(id: "")
        
        // THEN
        XCTAssertEqual(capturedResult, result)
    }
}
