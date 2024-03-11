//
//  StrategyCacheCryptocurrencyBasicInfoTests.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 9/3/24.
//

import XCTest
@testable import CoinGekoiOS

final class StrategyCacheCryptocurrencyBasicInfoTests: XCTestCase {
    func test_getCryptoList_returns_non_empty_array_when_there_is_temporal_cache() async {
        // GIVEN
        let cryptoList = CryptocurrencyBasicInfo.makeCryptoList()
        let temporalCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: cryptoList)
        let persistanceCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])
        
        let sut = StrategyCacheCryptocurrencyBasicInfo(temporalCache: temporalCache,
                                                       persistanceCache: persistanceCache)
        
        // WHEN
        let capturedResult = await sut.getCryptoList()
        
        // THEN
        XCTAssertEqual(capturedResult, cryptoList)
    }
    
    func test_getCryptoList_returns_non_empty_array_when_temporal_is_empty_and_there_is_persited_cache() async {
        // GIVEN
        let cryptoList = CryptocurrencyBasicInfo.makeCryptoList()
        let temporalCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])
        let persistanceCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: cryptoList)
        
        let sut = StrategyCacheCryptocurrencyBasicInfo(temporalCache: temporalCache,
                                                       persistanceCache: persistanceCache)
        
        // WHEN
        let capturedResult = await sut.getCryptoList()
        
        // THEN
        XCTAssertEqual(capturedResult, cryptoList)
    }
    
    func test_getCryptoList_returns_empty_array_when_temporal_is_empty_and_persited_is_empty() async {
        // GIVEN
        let temporalCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])
        let persistanceCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])
        
        let sut = StrategyCacheCryptocurrencyBasicInfo(temporalCache: temporalCache,
                                                       persistanceCache: persistanceCache)
        
        // WHEN
        let capturedResult = await sut.getCryptoList()
        
        // THEN
        XCTAssertEqual(capturedResult, [])
    }
    
    func test_getCryptoList_saves_in_temporal_cache_when_temporal_is_empty_and_there_is_persited_cache() async {
        // GIVEN
        let cryptoList = CryptocurrencyBasicInfo.makeCryptoList()
        let temporalCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])
        let persistanceCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: cryptoList)
        
        let sut = StrategyCacheCryptocurrencyBasicInfo(temporalCache: temporalCache,
                                                       persistanceCache: persistanceCache)
        
        // WHEN
        _ = await sut.getCryptoList()
        
        // THEN
        XCTAssertEqual(temporalCache.cachedCryptoList, cryptoList)
    }
    
    func test_saveCryptoList_saves_in_temporal_cache_and_in_persited_cache() async {
        // GIVEN
        let cryptoList = CryptocurrencyBasicInfo.makeCryptoList()
        let temporalCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])
        let persistanceCache = CacheCryptocurrencyBasicInfoDataSourceStub(getCryptoList: [])
        
        let sut = StrategyCacheCryptocurrencyBasicInfo(temporalCache: temporalCache,
                                                       persistanceCache: persistanceCache)
        
        // WHEN
        await sut.saveCryptoList(cryptoList)
        
        // THEN
        XCTAssertEqual(temporalCache.cachedCryptoList, cryptoList)
        XCTAssertEqual(persistanceCache.cachedCryptoList, cryptoList)
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
