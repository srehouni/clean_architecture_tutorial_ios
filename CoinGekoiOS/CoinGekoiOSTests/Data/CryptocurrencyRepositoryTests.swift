//
//  CryptocurrencyRepositoryTests.swift
//  CoinGekoiOSTests
//
//  Created by Said Rehouni on 3/1/24.
//

import XCTest
@testable import CoinGekoiOS

final class CryptocurrencyRepositoryTests: XCTestCase {

    func test_getGlobalCryptoList_returns_success() async throws {
        // GIVEN
        
        let apiDataSourceStub = ApiDataSourceStub(
            globalCryptoSymbolList: .success(String.makeGlobalCryptoListSymbol()),
            cryptoList: .success(CryptocurrencyBasicDTO.makeCryptoList()),
            priceInfo: .success(CryptocurrencyPriceInfoDTO.makePriceInfo()))
        
        let sut = CryptocurrencyRepository(apiDataSourcePriceInfo: apiDataSourceStub,
                                           apiDataSourceSymbol: apiDataSourceStub,
                                           apiDataSourceCrypto: apiDataSourceStub,
                                           errorMapper: CryptocurrencyDomainErrorMapper(),
                                           domainMapper: CryptocurrencyDomainMapper())
        
        // WHEN
        let result = await sut.getGlobalCryptoList()
        
        // THEN
        let cryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(cryptoList, Cryptocurrency.makeCryptocurrency())
    }
    
    func test_getGlobalCryptoList_returns_failure_when_apiDataSourceSymbol_fails() async throws {
        // GIVEN
        
        let apiDataSourceStub = ApiDataSourceStub(
            globalCryptoSymbolList: .failure(.clientError),
            cryptoList: .success(CryptocurrencyBasicDTO.makeCryptoList()),
            priceInfo: .success(CryptocurrencyPriceInfoDTO.makePriceInfo()))
        
        let sut = CryptocurrencyRepository(apiDataSourcePriceInfo: apiDataSourceStub,
                                           apiDataSourceSymbol: apiDataSourceStub,
                                           apiDataSourceCrypto: apiDataSourceStub,
                                           errorMapper: CryptocurrencyDomainErrorMapper(),
                                           domainMapper: CryptocurrencyDomainMapper())
        
        // WHEN
        let result = await sut.getGlobalCryptoList()
        
        // THEN
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, CryptocurrecyDomainError.generic)
    }
    
    func test_getGlobalCryptoList_returns_failure_when_apiDataSourceCrypto_fails() async throws {
        // GIVEN
        
        let apiDataSourceStub = ApiDataSourceStub(
            globalCryptoSymbolList: .success(String.makeGlobalCryptoListSymbol()),
            cryptoList: .failure(.clientError),
            priceInfo: .success(CryptocurrencyPriceInfoDTO.makePriceInfo()))
        
        let sut = CryptocurrencyRepository(apiDataSourcePriceInfo: apiDataSourceStub,
                                           apiDataSourceSymbol: apiDataSourceStub,
                                           apiDataSourceCrypto: apiDataSourceStub,
                                           errorMapper: CryptocurrencyDomainErrorMapper(),
                                           domainMapper: CryptocurrencyDomainMapper())
        
        // WHEN
        let result = await sut.getGlobalCryptoList()
        
        // THEN
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, CryptocurrecyDomainError.generic)
    }
    
    func test_getGlobalCryptoList_returns_failure_when_apiDataSourcePriceInfo_fails() async throws {
        // GIVEN
        
        let apiDataSourceStub = ApiDataSourceStub(
            globalCryptoSymbolList: .success(String.makeGlobalCryptoListSymbol()),
            cryptoList: .success(CryptocurrencyBasicDTO.makeCryptoList()),
            priceInfo: .failure(.clientError))
        
        let sut = CryptocurrencyRepository(apiDataSourcePriceInfo: apiDataSourceStub,
                                           apiDataSourceSymbol: apiDataSourceStub,
                                           apiDataSourceCrypto: apiDataSourceStub,
                                           errorMapper: CryptocurrencyDomainErrorMapper(),
                                           domainMapper: CryptocurrencyDomainMapper())
        
        // WHEN
        let result = await sut.getGlobalCryptoList()
        
        // THEN
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, CryptocurrecyDomainError.generic)
    }
    
    func test_getGlobalCryptoList_returns_success_with_one_item_when_there_is_one_cryptocurrency_with_all_required_data() async throws {
        // GIVEN
        let cryptoListStub = [
            CryptocurrencyBasicDTO(id: "bitcoin", symbol: "btc", name: "Bitcoin"),
            CryptocurrencyBasicDTO(id: "dasdsa", symbol: "dasdas", name: "asdsa"),
            CryptocurrencyBasicDTO(id: "sadsad", symbol: "dasdsa", name: "asdsad"),
            CryptocurrencyBasicDTO(id: "asdasfdasf", symbol: "eqweqwe", name: "qweqweqw"),
        ]
        let apiDataSourceStub = ApiDataSourceStub(
            globalCryptoSymbolList: .success(String.makeGlobalCryptoListSymbol()),
            cryptoList: .success(cryptoListStub),
            priceInfo: .success(CryptocurrencyPriceInfoDTO.makePriceInfo()))
        
        let sut = CryptocurrencyRepository(apiDataSourcePriceInfo: apiDataSourceStub,
                                           apiDataSourceSymbol: apiDataSourceStub,
                                           apiDataSourceCrypto: apiDataSourceStub,
                                           errorMapper: CryptocurrencyDomainErrorMapper(),
                                           domainMapper: CryptocurrencyDomainMapper())
        
        let expectedResult = [Cryptocurrency(id: "bitcoin", name: "Bitcoin", symbol: "btc", price: 123, price24h: 123, volume24h: 123, marketCap: 123)]
        
        // WHEN
        let result = await sut.getGlobalCryptoList()
        
        // THEN
        let cryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(cryptoList, expectedResult)
    }
    
    func test_getGlobalCryptoList_returns_success_with_two_item_when_there_are_two_cryptocurrencies_with_all_required_data() async throws {
        // GIVEN
        let cryptoListStub = [
            CryptocurrencyBasicDTO(id: "bitcoin", symbol: "btc", name: "Bitcoin"),
            CryptocurrencyBasicDTO(id: "ethereum", symbol: "eth", name: "Ethereum"),
            CryptocurrencyBasicDTO(id: "dasdsa", symbol: "dasdas", name: "asdsa"),
            CryptocurrencyBasicDTO(id: "sadsad", symbol: "dasdsa", name: "asdsad"),
            CryptocurrencyBasicDTO(id: "asdasfdasf", symbol: "eqweqwe", name: "qweqweqw"),
        ]
        let apiDataSourceStub = ApiDataSourceStub(
            globalCryptoSymbolList: .success(String.makeGlobalCryptoListSymbol()),
            cryptoList: .success(cryptoListStub),
            priceInfo: .success(CryptocurrencyPriceInfoDTO.makePriceInfo()))
        
        let sut = CryptocurrencyRepository(apiDataSourcePriceInfo: apiDataSourceStub,
                                           apiDataSourceSymbol: apiDataSourceStub,
                                           apiDataSourceCrypto: apiDataSourceStub,
                                           errorMapper: CryptocurrencyDomainErrorMapper(),
                                           domainMapper: CryptocurrencyDomainMapper())
        
        let expectedResult = [
            Cryptocurrency(id: "bitcoin", name: "Bitcoin", symbol: "btc", price: 123, price24h: 123, volume24h: 123, marketCap: 123),
            Cryptocurrency(id: "ethereum", name: "Ethereum", symbol: "eth", price: 456, price24h: 456, volume24h: 456, marketCap: 456)
        ]
        
        // WHEN
        let result = await sut.getGlobalCryptoList()
        
        // THEN
        let cryptoList = try XCTUnwrap(result.get())
        XCTAssertEqual(cryptoList, expectedResult)
    }
}

private extension String {
    static func makeGlobalCryptoListSymbol() -> [String] {
        return ["btc", "eth", "xrp"]
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

private extension CryptocurrencyPriceInfoDTO {
    static func makePriceInfo() -> [String : CryptocurrencyPriceInfoDTO] {
        [
            "bitcoin" :  CryptocurrencyPriceInfoDTO(price: 123, marketCap: 123, volume24h: 123, price24h: 123),
            "ethereum" : CryptocurrencyPriceInfoDTO(price: 456, marketCap: 456, volume24h: 456, price24h: 456),
            "ripple" : CryptocurrencyPriceInfoDTO(price: 789, marketCap: 789, volume24h: 789, price24h: 789),
        ]
    }
}

private extension Cryptocurrency {
    static func makeCryptocurrency() -> [Cryptocurrency] {
        return [
            Cryptocurrency(id: "bitcoin", name: "Bitcoin", symbol: "btc", price: 123, price24h: 123, volume24h: 123, marketCap: 123),
            Cryptocurrency(id: "ethereum", name: "Ethereum", symbol: "eth", price: 456, price24h: 456, volume24h: 456, marketCap: 456),
            Cryptocurrency(id: "ripple", name: "Ripple", symbol: "xrp", price: 789, price24h: 789, volume24h: 789, marketCap: 789)
        ]
    }
}
