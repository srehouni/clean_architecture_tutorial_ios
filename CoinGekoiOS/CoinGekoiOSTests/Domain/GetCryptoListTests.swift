//
//  GetCryptoListTests.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 1/11/23.
//

import XCTest
@testable import CoinGekoiOS

final class GetCryptoListTests: XCTestCase {

    func test_execute_sucesfully_returns_sorted_array_when_repository_returns_nonEmpty_array() async throws {
        // GIVEN
        let mockArray = [
            CryptocurrencyBasicInfo(id: "001", name: "solana", symbol: "sol"),
            CryptocurrencyBasicInfo(id: "002", name: "bitcoin", symbol: "btc"),
            CryptocurrencyBasicInfo(id: "003", name: "cardano", symbol: "ada"),
        ]
        let result: Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError> = .success(mockArray)
        let stub = CryptoListBasicInfoRepositoryStub(result: result)
        let sut = GetCryptoList(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute()
        
        // THEN
        let capturedCryptoList = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCryptoList[0], mockArray[1])
        XCTAssertEqual(capturedCryptoList[1], mockArray[2])
        XCTAssertEqual(capturedCryptoList[2], mockArray[0])
    }
    
    func test_execute_sucesfully_returns_sorted_array_when_repository_returns_nonEmpty_sorted_array() async {
        // GIVEN
        let mockArray = [
            CryptocurrencyBasicInfo(id: "002", name: "bitcoin", symbol: "btc"),
            CryptocurrencyBasicInfo(id: "003", name: "cardano", symbol: "ada"),
            CryptocurrencyBasicInfo(id: "001", name: "solana", symbol: "sol")
        ]
        let result: Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError> = .success(mockArray)
        let stub = CryptoListBasicInfoRepositoryStub(result: result)
        let sut = GetCryptoList(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute()
        
        // THEN
        XCTAssertEqual(capturedResult, result)
    }
    
    func test_execute_sucesfully_returns_anEmpty_array_when_repository_returns_anEmpty_array() async {
        // GIVEN
        let result: Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError> = .success([])
        let stub = CryptoListBasicInfoRepositoryStub(result: result)
        let sut = GetCryptoList(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute()
        
        // THEN
        XCTAssertEqual(capturedResult, result)
    }
    
    func test_execute_returns_error_when_repository_returns_error() async {
        // GIVEN
        let result: Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError> = .failure(.generic)
        let stub = CryptoListBasicInfoRepositoryStub(result: result)
        let sut = GetCryptoList(repository: stub)
        
        // WHEN
        let capturedResult = await sut.execute()
        
        // THEN
        XCTAssertEqual(capturedResult, result)
    }
}
