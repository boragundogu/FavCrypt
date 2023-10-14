//
//  CoinRow.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 7.10.2023.
//

import SwiftUI

import SwiftUI

struct CoinRow: View {
    @StateObject private var listViewModel: CoinListViewModel
    var coin: Coin
    
    init(coin: Coin) {
        _listViewModel = StateObject(wrappedValue: CoinListViewModel())
        self.coin = coin
    }

    var body: some View {
        HStack {
            Text("\(coin.cmc_rank)").foregroundStyle(.white)
                .frame(width: 30, height: 30, alignment: .leading)
            AsyncImage(url: URL(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/\(coin.id).png")) { phase in
                switch phase {
                case .empty:
                    Image(systemName: "photo")
                        .frame(width: 50, height: 50, alignment: .center)
                case .success(let image):
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30, alignment: .center)
                        .clipShape(Circle())
                case .failure:
                    Image(systemName: "photo")
                        .frame(width: 50, height: 50, alignment: .center)
                @unknown default:
                    EmptyView()
                }
            }
            .padding(.leading, -10)
            Text("\(coin.symbol)").foregroundStyle(.gray)
                .frame(width: 70, height: 70, alignment: .leading)
            Text(listViewModel.formatPrice(coin.price)).foregroundStyle(.white)
                .frame(width: 90, height: 90, alignment: .leading)
                .padding(.leading, -20)
           // Text()
            if coin.quote.USD.percent_change_24h > 0.0 {
                Text("\((String(coin.quote.USD.percent_change_24h).prefix(5)))" + "%")
                    .frame(width: 70, height: 70, alignment: .center)
                    .padding(.leading, 45)
                    .background {
                        Rectangle()
                            .foregroundStyle(.green)
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(width: 67, height: 31, alignment: .center)
                            .padding(.leading, 45)
                    }
            }
            else{
                Text("\((String(coin.quote.USD.percent_change_24h).prefix(5)))" + "%")
                    .frame(width: 70, height: 70, alignment: .center)
                    .padding(.leading, 45)
                    .background {
                        Rectangle()
                            .foregroundStyle(.red)
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(width: 67, height: 31, alignment: .center)
                            .padding(.leading, 45)
                    }
            }
        }
        .background(
            NavigationLink(destination: CoinDetailView(coinId: coin.id, coin: coin)) {}.opacity(0)
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


#Preview {
    CoinRow(coin: Coin(id: 1, name: "Bitcoin", symbol: "BTC", quote: .init(USD: .init(price: 26754.30, volume_24h: 1, market_cap: 1, percent_change_24h: 0.25)), cmc_rank: 1))
}
