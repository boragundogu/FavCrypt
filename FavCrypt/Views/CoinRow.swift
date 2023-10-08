//
//  CoinRow.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 7.10.2023.
//

import SwiftUI

func formatPrice(_ price: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.minimumFractionDigits = 2
    numberFormatter.maximumFractionDigits = 8
    return numberFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
}

struct CoinRow: View {
    var coin: Coin
    
    var body: some View {
        HStack {
            Text("\(coin.cmc_rank)")
            Text("\(coin.name)" + " " + "\(coin.symbol)").foregroundStyle(.red)
            Text(formatPrice(coin.price)).foregroundStyle(.green)
        }
        .background(
            NavigationLink(destination: CoinDetailView(coinId: coin.id)) {}.opacity(0)
        )
        .swipeActions(edge: .trailing) {
            Button {
                print("Favoriye eklendi.")
            } label: {
                Label("Favorite", systemImage: "heart.fill")
            }
        }
        .tint(Color("favColor"))
    }
}
