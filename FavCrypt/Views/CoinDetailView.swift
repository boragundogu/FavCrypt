//
//  CoinDetailViwew.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 6.10.2023.
//

import SwiftUI

struct CoinDetailView: View {
    @StateObject private var detailViewModel: CoinDetailViewModel
    var coinId: Int // Binding değil, sadece bir Int

    init(coinId: Int) {
        self.coinId = coinId
        _detailViewModel = StateObject(wrappedValue: CoinDetailViewModel())
    }

    var body: some View {
        VStack {
            if let coinInfo = detailViewModel.coinInfo {
                Text(coinInfo.name)
                Text(coinInfo.symbol)
                Text(coinInfo.description)
                AsyncImage(url: URL(string: coinInfo.logo))
            } else {
            }
        }
        .onAppear {
            detailViewModel.coinId = coinId // CoinDetailViewModel içindeki coinId'yi ayarla
            detailViewModel.fetchCoinDetail()
        }
    }
}
