//
//  GlobalCryptoListViewModel.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 24/9/23.
//

import Foundation

class GlobalCryptoListViewModel: ObservableObject {
    private let getGlobalCryptoList: GetGlobalCryptoListType
    private let errorMapper: CryptocurrencyPresentableErrorMapper
    @Published var cryptos: [CryptoListPresentableItem] = []
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    
    init(getGlobalCryptoList: GetGlobalCryptoListType, errorMapper: CryptocurrencyPresentableErrorMapper) {
        self.getGlobalCryptoList = getGlobalCryptoList
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        showLoadingSpinner = true
        Task {
            let result = await getGlobalCryptoList.execute()
            
            guard case .success(let cryptos) = result else {
                handleError(error: result.failureValue as? CryptocurrecyDomainError)
                return
            }
            
            let cryptosPresentable = cryptos.map { CryptoListPresentableItem(domainModel: $0) }
            
            Task { @MainActor in
                showLoadingSpinner = false
                self.cryptos = cryptosPresentable
            }
        }
    }
    
    private func handleError(error: CryptocurrecyDomainError?) {
        Task { @MainActor in
            showLoadingSpinner = false
            showErrorMessage = errorMapper.map(error: error)
        }
    }
}
