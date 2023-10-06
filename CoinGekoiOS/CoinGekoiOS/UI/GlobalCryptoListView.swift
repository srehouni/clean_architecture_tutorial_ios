//
//  GlobalCryptoListView.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 24/9/23.
//

import SwiftUI

struct GlobalCryptoListView: View {
    @ObservedObject private var viewModel: GlobalCryptoListViewModel
    private let createCryptoDetailView: CreateCryptoDetailView
    
    init(viewModel: GlobalCryptoListViewModel, createCryptoDetailView: CreateCryptoDetailView) {
        self.viewModel = viewModel
        self.createCryptoDetailView = createCryptoDetailView
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                if viewModel.showErrorMessage == nil {
                    NavigationStack {
                        List {
                            ForEach(viewModel.cryptos, id: \.id) { crypto in
                                NavigationLink {
                                    createCryptoDetailView.create(cryptocurrency: crypto)
                                } label: {
                                    CryptoListItemView(item: crypto)
                                }
                            }
                        }
                    }
                } else {
                    Text(viewModel.showErrorMessage!)
                }
            }
        }.onAppear {
            viewModel.onAppear()
        }.refreshable {
            viewModel.onAppear()
        }
    }
}
