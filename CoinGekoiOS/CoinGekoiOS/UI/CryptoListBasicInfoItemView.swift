//
//  CryptoListBasicInfoItemView.swift
//  CoinGekoiOS
//
//  Created by Said Rehouni on 22/10/23.
//

import SwiftUI

struct CryptoListBasicInfoItemView: View {
    let item: CryptoListBasicInfoPresentableItem
    
    var body: some View {
        VStack {
            HStack {
                Text(item.name)
                    .font(.title3)
                    .lineLimit(1)
                
                Spacer()
                
                Text(item.symbol)
                    .font(.headline)
            }.padding()
        }
    }
}

struct CryptoListBasicInfoItemView_Previews: PreviewProvider {
    static var previews: some View {
        let item = CryptoListBasicInfoPresentableItem(id: "", name: "Bitcoin", symbol: "btc")
        CryptoListBasicInfoItemView(item: item)
    }
}
