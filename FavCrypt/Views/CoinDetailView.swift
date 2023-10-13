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
                        AsyncImage(url: URL(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/\(coin.id).png")) { phase in
                            switch phase {
                            case .empty:
                                Image(systemName: "photo")
                                    .frame(width: 60, height: 60, alignment: .center)
                            case .success(let image):
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 35, height: 35, alignment: .center)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "photo")
                                    .frame(width: 50, height: 50, alignment: .center)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        Text(coinInfo.symbol)
                            .fontWeight(.bold)
                    }
                    HStack {
                        VStack {
                            HStack {
                                VStack {
                                    HStack {
                                        Text(coin.name)
                                            .fontWeight(.light)
                                            .font(.system(size: 18))
                                        
                                        Text("#" + "\(String(coin.cmc_rank))")
                                            .opacity(0.7)
                                            .font(.system(size: 13))
                                            .padding(5)
                                            .foregroundStyle(.white)
                                            .background {
                                                GeometryReader { geometry in
                                                    Color("rankColor")
                                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                }
                                            }
                                    }
                                    Text("$" + String(coin.price))
                                        .fontWeight(.bold)
                                        .font(.system(size: 18))
                                    
                                }
                                Spacer()
                                if coin.quote.USD.percent_change_24h > 0 {
                                    Text("\((String(coin.quote.USD.percent_change_24h).prefix(5)))" + "%")
                                        .padding(30)
                                        .background {
                                            Rectangle()
                                                .foregroundStyle(.green)
                                                .clipShape(.rect(cornerRadius: 10))
                                                .frame(width: 67, height: 31, alignment: .center)
                                        }
                                }
                                else {
                                    Text("\((String(coin.quote.USD.percent_change_24h)).prefix(5))" + "%")
                                        .padding(30)
                                        .background {
                                            Rectangle()
                                                .foregroundStyle(.red)
                                                .clipShape(.rect(cornerRadius: 10))
                                                .frame(width: 67, height: 31, alignment: .center)
                                        }
                                }
                            }
                            .padding(.leading, 20)
                            
                        }
                    }
                    .padding(.bottom, 600)
                    
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

#Preview {
    CoinDetailView(coinId: 1, coin: Coin(id: 1, name: "Bitcoin", symbol: "BTC", quote: .init(USD: .init(price: 26754.30, volume_24h: 1, market_cap: 1, percent_change_24h: 0.25)), cmc_rank: 1))
}
