//
//  CoinPrediction.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 22.10.2023.
//

import SwiftUI

struct CoinPrediction: View {
    var coinId: Int
    var coin: Coin
    
    init(coinId: Int, coin: Coin) {
        self.coinId = coinId
        self.coin = coin
    }
    
    var body: some View {
        Text(coin.name)
        }
    }

#Preview {
    CoinPrediction(coinId: 1,coin: Coin(id: 1027, name: "Bitcoin", symbol: "ETH", quote: .init(USD: .init(price: 26754.30, volume_24h: 1, market_cap: 1, market_cap_dominance: 1, percent_change_24h: 0.25)), cmc_rank: 2))
}
