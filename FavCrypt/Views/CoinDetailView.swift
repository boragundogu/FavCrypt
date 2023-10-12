//
//  CoinDetailViwew.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 6.10.2023.
//

import SwiftUI

struct CoinDetailView: View {
    @StateObject private var detailViewModel: CoinDetailViewModel
    @State private var isShowingAlert = false
    var coinId: Int
    var coin: Coin
    
    init(coinId: Int, coin: Coin) {
        self.coinId = coinId
        _detailViewModel = StateObject(wrappedValue: CoinDetailViewModel())
        self.coin = coin
    }
    
    var body: some View {
        ZStack {
            Color("bgColor")
            VStack {
                if let coinInfo = detailViewModel.coinInfo {
                    HStack {
                        AsyncImage(url: URL(string: coinInfo.logo))
                            //.scaledToFill()
                            .frame(width: 30, height: 30, alignment: .center)
                            .clipShape(Circle())
                            
                        Text(coinInfo.symbol)
                    }
                    HStack {
                        Text(coin.name)
                        if coin.quote.USD.percent_change_24h > 0 {
                            Text("\(coin.quote.USD.percent_change_24h)")
                                .background {
                                    Rectangle()
                                        .foregroundStyle(.green)
                                }
                        }
                        else {
                            Text("\(String(coin.quote.USD.percent_change_24h).prefix(5))" + "%")
                                .background {
                                    Rectangle()
                                        .clipShape(.circle)
                                        .foregroundStyle(.red)
                                }
                        }
                    }
                    
                }
            }
            .onAppear {
                detailViewModel.coinId = coinId
                detailViewModel.fetchCoinDetail()
            }
        }
        .ignoresSafeArea()
    }
}
