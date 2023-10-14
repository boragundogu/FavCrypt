//
//  ContentView.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 4.10.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coinViewModel = CoinListViewModel()
    @State private var isReversed = true
    @State private var isPercentReversed = true
    @State private var isPriceReversed = true
    @State private var currentSortBy = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: HStack {
                    Button(action: {
                        currentSortBy = ""
                        isPriceReversed = true
                        isPercentReversed = true
                        isReversed.toggle()
                    })
                    {
                        Image(systemName: isReversed ? "number.circle.fill" : "number.circle")
                            .scaleEffect(1.4)
                            .padding()
                        
                    }
                    Button(action: {
                        currentSortBy = "price"
                        isPriceReversed.toggle()
                        isReversed = false
                        isPercentReversed = true
                    }) {
                        Image(systemName: isPriceReversed ? "dollarsign.circle" : "dollarsign.circle.fill")
                            .scaleEffect(1.4)
                            .padding()
                    }
                    Button(action: {
                        currentSortBy = "totalCap"
                        isPercentReversed.toggle()
                        isPriceReversed = true
                        isReversed = false
                    }) {
                        Image(systemName: "percent")
                            .scaleEffect(1.4)
                            .padding()
                    }
                }
                ) {
                    
                    let sortedCoins: [Coin] = {
                        switch currentSortBy {
                        case "price":
                            return isPriceReversed ? coinViewModel.coinData.sorted(by: {$0.price < $1.price}) : coinViewModel.coinData.sorted(by: {$0.price > $1.price})
                        case "totalCap":
                            return isPercentReversed ? coinViewModel.coinData.sorted(by: {$0.quote.USD.percent_change_24h < $1.quote.USD.percent_change_24h}) : coinViewModel.coinData.sorted(by: {$0.quote.USD.percent_change_24h > $1.quote.USD.percent_change_24h})
                        default:
                            return isReversed ? coinViewModel.coinData.sorted(by: {$0.cmc_rank < $1.cmc_rank}) : coinViewModel.coinData.sorted(by: {$0.cmc_rank > $1.cmc_rank})
                        }
                    }()
                    
                    ForEach(sortedCoins, id: \.id) { coin in
                        CoinRow(coin: coin)
                            .listRowBackground(Color("rowColor"))
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .scrollContentBackground(.hidden) // list background değişmesi için gerekli !
            .background(Color("bgColor"))
            .refreshable {
                coinViewModel.fetchCoinData()
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                coinViewModel.fetchCoinData()
            }
        }
    }
}

#Preview {
    ContentView()
}
