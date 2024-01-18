//
//  CryptocurrencyBasicInfoRepositoryTests.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 17/1/24.
//

import XCTest
@testable import CoinGekoiOS

final class CryptocurrencyBasicInfoRepositoryTests: XCTestCase {

    func test_getCryptoList_returns_success_when_there_is_nonEmpty_cache() async throws {
        // GIVEN
        let expectedCryptocurrencyBasicList = CryptocurrencyBasicInfo.makeCryptoList()
        
        let (sut, _) = makeSUT(apiDataSourceResult: .success([]),
                               cachedValue: expectedCryptocurrencyBasicList)
        
        // WHEN
        let result = await sut.getCryptoList()
        
        // THEN
        let capturedCryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(capturedCryptoList, expectedCryptocurrencyBasicList)
    }
    
    func test_getCryptoList_returns_success_when_there_is_empty_cache() async throws {
        // GIVEN
        let expectedCryptocurrencyBasicList = CryptocurrencyBasicInfo.makeCryptoList()
        
        let (sut, _) = makeSUT(apiDataSourceResult: .success(CryptocurrencyBasicDTO.makeCryptoList()),
                               cachedValue: [])
        
        // WHEN
        let result = await sut.getCryptoList()
        
        // THEN
        let capturedCryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(capturedCryptoList, expectedCryptocurrencyBasicList)
    }
    
    func test_getCryptoList_saves_in_cache_when_cache_is_empty_and_gets_data_from_apiDataSource() async throws {
        // GIVEN
        let (sut, cacheDataSource) = makeSUT(apiDataSourceResult: .success(CryptocurrencyBasicDTO.makeCryptoList()),
                               cachedValue: [])
        
        let expectedCryptocurrencyBasicList = CryptocurrencyBasicInfo.makeCryptoList()
        
        // WHEN
        _ = await sut.getCryptoList()
        
        // THEN
        XCTAssertEqual(cacheDataSource.cachedCryptoList, expectedCryptocurrencyBasicList)
    }
    
    func test_getCryptoList_returns_failure_when_there_is_empty_cache_and_apiDataSource_returns_failure() async {
        // GIVEN
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.clientError),
                               cachedValue: [])
        
        // WHEN
        let result = await sut.getCryptoList()
        
        // THEN
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .generic)
    }
    
    func test_search_returs_all_crypto_list_when_search_is_empty() async throws {
        // GIVEN
        let (sut, _) = makeSUT(apiDataSourceResult: .success(CryptocurrencyBasicDTO.makeCryptoList()),
                               cachedValue: [])
        
        let expectedCryptoList = CryptocurrencyBasicInfo.makeCryptoList()
        
        // WHEN
        let result = await sut.search(crypto: "")
        
        //THEN
        let capturedCryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(capturedCryptoList, expectedCryptoList)
    }
    
    func test_search_returs_filtered_crypto_list_with_one_item_based_on_search() async throws {
        // GIVEN
        let (sut, _) = makeSUT(apiDataSourceResult: .success(CryptocurrencyBasicDTO.makeCryptoList()),
                               cachedValue: [])
        
        let expectedCryptoList = [CryptocurrencyBasicInfo(id: "bitcoin", name: "Bitcoin", symbol: "btc")]
        
        // WHEN
        let result = await sut.search(crypto: "bit")
        
        //THEN
        let capturedCryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(capturedCryptoList, expectedCryptoList)
    }
    
    func test_search_returs_filtered_crypto_list_with_four_item_based_on_search() async throws {
        // GIVEN
        let cryptoList = [
            CryptocurrencyBasicDTO(id: "bitcoin", symbol: "btc", name: "Bitcoin"),
            CryptocurrencyBasicDTO(id: "ethereum", symbol: "eth", name: "Ethereum"),
            CryptocurrencyBasicDTO(id: "ripple", symbol: "xrp", name: "Ripple"),
            CryptocurrencyBasicDTO(id: "etheresadsaum", symbol: "ethasdsd", name: "Ethereuasdasdm"),
            CryptocurrencyBasicDTO(id: "etheresadsasdm", symbol: "ethqwe", name: "Ethereuasqwewdm"),
            CryptocurrencyBasicDTO(id: "ethew", symbol: "ethwwe", name: "Ethereuasqqwew"),
        ]
        let (sut, _) = makeSUT(apiDataSourceResult: .success(cryptoList),
                               cachedValue: [])
        
        let expectedCryptoList = [
            CryptocurrencyBasicInfo(id: "ethereum", name: "Ethereum", symbol: "eth"),
            CryptocurrencyBasicInfo(id: "etheresadsaum", name: "Ethereuasdasdm", symbol: "ethasdsd"),
            CryptocurrencyBasicInfo(id: "etheresadsasdm", name: "Ethereuasqwewdm", symbol: "ethqwe"),
            CryptocurrencyBasicInfo(id: "ethew", name: "Ethereuasqqwew", symbol: "ethwwe")
        ]
        
        // WHEN
        let result = await sut.search(crypto: "eth")
        
        //THEN
        let capturedCryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(capturedCryptoList, expectedCryptoList)
    }
    
    func test_search_returns_failure_when_getCrypto_returns_failure() async {
        // GIVEN
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.clientError),
                               cachedValue: [])
        
        // WHEN
        let result = await sut.search(crypto: "bit")
        
        //THEN
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .generic)
    }
    
    private func makeSUT(apiDataSourceResult: Result<[CryptocurrencyBasicDTO], HTTPClientError>, cachedValue: [CryptocurrencyBasicInfo]) -> (sut: CryptocurrencyBasicInfoRepository, cache: CacheCryptocurrencyBasicInfoDataSourceStub) {
        
        let apiDataSource = APICryptocurrencyBasicInfoDataSourceStub(getCryptoList: apiDataSourceResult)
        let cacheDataSource = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: cachedValue)
        
        let sut = CryptocurrencyBasicInfoRepository(apiDatasource: apiDataSource,
                                                    errorMapper: CryptocurrencyDomainErrorMapper(),
                                                    cacheDatasource: cacheDataSource)
        
        return (sut, cacheDataSource)
    }
}


private extension CryptocurrencyBasicDTO {
    static func makeCryptoList() -> [CryptocurrencyBasicDTO] {
        return [
            CryptocurrencyBasicDTO(id: "bitcoin", symbol: "btc", name: "Bitcoin"),
            CryptocurrencyBasicDTO(id: "ethereum", symbol: "eth", name: "Ethereum"),
            CryptocurrencyBasicDTO(id: "ripple", symbol: "xrp", name: "Ripple"),
        ]
    }
}

private extension CryptocurrencyBasicInfo {
    static func makeCryptoList() -> [CryptocurrencyBasicInfo] {
        return [
            CryptocurrencyBasicInfo(id: "bitcoin", name: "Bitcoin", symbol: "btc"),
            CryptocurrencyBasicInfo(id: "ethereum", name: "Ethereum", symbol: "eth"),
            CryptocurrencyBasicInfo(id: "ripple", name: "Ripple", symbol: "xrp"),
        ]
    }
}
