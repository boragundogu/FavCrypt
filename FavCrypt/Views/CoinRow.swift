//
//  CoinRow.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 7.10.2023.
//

import SwiftUI

func formatPrice(_ price: Double) -> String {
    let formattedPrice: String
    
    if price >= 1000.0 {
        formattedPrice = String(format: "%.2f", price)
    }
    else if price >= 1.0 {
        formattedPrice = String(format: "%.2f", price)
    } 
    else if price > 0.0001 {
        formattedPrice = String(format: "%.4f", price)
    }
    else if price > 0.00001 {
        formattedPrice = String(format: "%.6f", price)
    }
    else {
        formattedPrice = String(format: "%.8f", price)
    }

    return formattedPrice
}

import SwiftUI

struct CoinRow: View {
    var coin: Coin

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
            Text("\(coin.symbol)").foregroundStyle(.gray)
                .frame(width: 70, height: 70, alignment: .leading)
            Text(formatPrice(coin.price)).foregroundStyle(.white)
                .frame(width: 90, height: 90, alignment: .leading)
            if coin.quote.USD.percent_change_24h > 0.0 {
                Text("\((String(coin.quote.USD.percent_change_24h).prefix(5)))" + "%")
                    .padding(10)
                    .background {
                        Rectangle()
                            .foregroundStyle(.green)
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(width: 65, height: 50, alignment: .center)
                    }
            }
            else{
                Text("\((String(coin.quote.USD.percent_change_24h).prefix(5)))" + "%")
                    .padding(10)
                    .background {
                        Rectangle()
                            .foregroundStyle(.red)
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(width: 65, height: 50, alignment: .center)
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
    CoinRow(coin: Coin(id: 1, name: "Bitcoin", symbol: "BTC", quote: .init(USD: .init(price: 1, volume_24h: 1, market_cap: 1, percent_change_24h: 0.25)), cmc_rank: 1))
}
