//
//  CreateCryptoDetailView.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 5/10/23.
//

import Foundation

protocol CreateCryptoDetailView {
    func create(cryptocurrency: CryptoListPresentableItem) -> CryptoDetailView
}
