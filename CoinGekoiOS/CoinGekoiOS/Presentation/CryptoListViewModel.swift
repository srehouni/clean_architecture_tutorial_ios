//
//  CryptoListViewModel.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 22/10/23.
//

import Foundation

struct CryptoListBasicInfoPresentableItem {
    let id: String
    let name: String
    let symbol: String
}

class CryptoListViewModel: ObservableObject {
    private let getCryptoList: GetCryptoListType
    private let searchCryptoList: SearchCryptoListType
    private let errorMapper: CryptocurrencyPresentableErrorMapper
    @Published var cryptos: [CryptoListBasicInfoPresentableItem] = []
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    
    init(getCryptoList: GetCryptoListType, searchCryptoList: SearchCryptoListType, errorMapper: CryptocurrencyPresentableErrorMapper) {
        self.getCryptoList = getCryptoList
        self.searchCryptoList = searchCryptoList
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        showLoadingSpinner = true
        Task {
            let result = await getCryptoList.execute()
            handleResult(result)
        }
    }
    
    func search(crypto: String) {
        Task {
            let result = await searchCryptoList.execute(crypto: crypto)
            handleResult(result)
        }
    }
    
    private func handleResult(_ result: Result<[CryptocurrencyBasicInfo], CryptocurrecyDomainError>) {
        guard case .success(let cryptos) = result else {
            handleError(error: result.failureValue as? CryptocurrecyDomainError)
            return
        }
        
        let cryptosPresentable = cryptos.map { CryptoListBasicInfoPresentableItem(id: $0.id, name: $0.name, symbol: $0.symbol) }
        
        Task { @MainActor in
            showLoadingSpinner = false
            self.cryptos = cryptosPresentable
        }
    }
    
    private func handleError(error: CryptocurrecyDomainError?) {
        Task { @MainActor in
            showLoadingSpinner = false
            showErrorMessage = errorMapper.map(error: error)
        }
    }
}
