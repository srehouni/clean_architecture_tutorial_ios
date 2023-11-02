//
//  GetGlobalCryptoListTests.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 1/11/23.
//

import XCTest
@testable import CoinGekoiOS

final class GetGlobalCryptoListTests: XCTestCase {
    
    func test_execute_sucesfully_returns_sorted_array_when_repository_returns_nonEmpty_array() async throws {
        // GIVEN
        let mockArray = [
            Cryptocurrency(id: "001", name: "solana", symbol: "sol", price: 34563.23, price24h: 1.23, volume24h: 3000, marketCap: 54312312),
            Cryptocurrency(id: "002", name: "bitcoin", symbol: "btc", price: 34563.23, price24h: 0.32, volume24h: 1000000, marketCap: 2312312312),
            Cryptocurrency(id: "003", name: "cardano", symbol: "ada", price: 1.23, price24h: -0.45, volume24h: 32434, marketCap: 12312312),
        ]
        let result: Result<[Cryptocurrency], CryptocurrecyDomainError> = .success(mockArray)
        let stub = GlobalCryptoListRepositoryStub(result: result)
        let sut = GetGlobalCryptoList(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute()
        
        // THEN
        let capturedCryptoList = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCryptoList[0], mockArray[1])
        XCTAssertEqual(capturedCryptoList[1], mockArray[0])
        XCTAssertEqual(capturedCryptoList[2], mockArray[2])
    }
    
    func test_execute_sucesfully_returns_sorted_array_when_repository_returns_nonEmpty_sorted_array() async {
        // GIVEN
        let mockArray = [
            Cryptocurrency(id: "002", name: "bitcoin", symbol: "btc", price: 34563.23, price24h: 0.32, volume24h: 1000000, marketCap: 2312312312),
            Cryptocurrency(id: "001", name: "solana", symbol: "sol", price: 34563.23, price24h: 1.23, volume24h: 3000, marketCap: 54312312),
            Cryptocurrency(id: "003", name: "cardano", symbol: "ada", price: 1.23, price24h: -0.45, volume24h: 32434, marketCap: 12312312),
        ]
        let result: Result<[Cryptocurrency], CryptocurrecyDomainError> = .success(mockArray)
        let stub = GlobalCryptoListRepositoryStub(result: result)
        let sut = GetGlobalCryptoList(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute()
        
        // THEN
        XCTAssertEqual(capturedResult, result)
    }
    
    func test_execute_sucesfully_returns_anEmpty_array_when_repository_returns_anEmpty_array() async {
        // GIVEN
        let result: Result<[Cryptocurrency], CryptocurrecyDomainError> = .success([])
        let stub = GlobalCryptoListRepositoryStub(result: result)
        let sut = GetGlobalCryptoList(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute()
        
        // THEN
        XCTAssertEqual(capturedResult, result)
    }
    
    func test_execute_returns_error_when_repository_returns_error() async {
        // GIVEN
        let result: Result<[Cryptocurrency], CryptocurrecyDomainError> = .failure(.generic)
        let stub = GlobalCryptoListRepositoryStub(result: result)
        let sut = GetGlobalCryptoList(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute()
        
        // THEN
        XCTAssertEqual(capturedResult, result)
    }
}

