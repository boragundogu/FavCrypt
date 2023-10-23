//
//  CoinPrediction.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 22.10.2023.
//

import SwiftUI

struct CoinPrediction: View {
    @StateObject private var coinViewModel = CoinListViewModel()
    @State private var selectedCoin = "Select Coin"
    
    var body: some View {
        Picker(selection: $selectedCoin) {
            ForEach(coinViewModel.coinData) { coin in
                Text(coin.symbol)
            }
        } label: {
            Text("Coins")
        }
        .labelsHidden()
        .onAppear {
            coinViewModel.fetchCoinData()
        }
        
    }
}

#Preview {
    CoinPrediction()
}
