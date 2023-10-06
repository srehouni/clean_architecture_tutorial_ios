//
//  CryptoDetailView.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 5/10/23.
//

import SwiftUI
import Charts

struct CryptoDetailView: View {
    @ObservedObject private var viewModel: CryptoDetailViewModel
    @State private var selectedItem: DaysOption = .month
    
    init(viewModel: CryptoDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                CryptoDetailHeaderView(cryptocurrency: viewModel.cryptocurrency)
                
                Chart(viewModel.dataPoints) {
                    LineMark(x: .value("Fecha", $0.date),
                             y: .value("Precio", $0.price))
                    
                }
                
                Picker("", selection: $selectedItem) {
                    ForEach(DaysOption.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }.onChange(of: selectedItem) { newValue in
                    viewModel.getPriceHistory(option: newValue)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .onAppear {
                viewModel.getPriceHistory(option: selectedItem)
            }
            
            if viewModel.showLoadingSpinner {
                ProgressView()
                    .progressViewStyle(.circular)
            } else if let errorMessage = viewModel.showErrorMessage {
                VStack {
                    Text(errorMessage)
                    Button("Try again") {
                        viewModel.getPriceHistory(option: selectedItem)
                    }
                }
            }
        }
    }
}
