//
//  GetPriceInfoTests.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 1/11/23.
//

import XCTest
@testable import CoinGekoiOS

final class GetPriceInfoTests: XCTestCase {

    func test_execute_returns_succesfully_price_when_repository_returns_price() async {
        // GIVEN
        let mockPrice = CryptocurrencyPriceInfo(price: 1, price24h: 3, volume24h: 2, marketCap: 4)
        let result: Result<CryptocurrencyPriceInfo, CryptocurrecyDomainError> = .success(mockPrice)
        let stub = CryptocurrencyPriceInfoRepositoryStub(result: result)
        let sut = GetPriceInfo(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute(id: "")
        
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
