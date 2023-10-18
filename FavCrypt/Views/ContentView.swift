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
    @State private var isMarketCapReversed = true
    @State private var currentSortBy = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: VStack {
                    Button {
                        print("xx")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .scaleEffect(1.2)
                    }
                    .offset(x: 140, y: -10)
                    
                    HStack(spacing: 80) {
                        Spacer()
                        Button(action: {
                            currentSortBy = ""
                            isPriceReversed = true
                            isPercentReversed = true
                            isMarketCapReversed = true
                            isReversed.toggle()
                        })
                        {
                            Image(systemName: isReversed ? "number.circle.fill" : "number.circle")
                                .scaleEffect(1.2)
                        }
                        .offset(x: -2)
                        Button(action: {
                            currentSortBy = "marketCap"
                            isMarketCapReversed.toggle()
                            isReversed = false
                            isPercentReversed = true
                            isPriceReversed = true
                        })
                        {
                            Image(systemName: isMarketCapReversed ? "chart.pie" : "chart.pie.fill")
                                .scaleEffect(1.2)
                        }
                        .offset(x: -20)
                        Button(action: {
                            currentSortBy = "price"
                            isPriceReversed.toggle()
                            isReversed = false
                            isPercentReversed = true
                            isMarketCapReversed = true
                        }) {
                            Image(systemName: isPriceReversed ? "dollarsign.circle" : "dollarsign.circle.fill")
                                .scaleEffect(1.2)
                        }
                        .offset(x: -20)
                        Button(action: {
                            currentSortBy = "percent"
                            isPercentReversed.toggle()
                            isPriceReversed = true
                            isReversed = false
                            isMarketCapReversed = true
                        }) {
                            Image(systemName: "percent")
                                .scaleEffect(1.2)
                        }
                        .offset(x: -5)
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.leading, -20)
                    .offset(y: -2)
                    }
                ) {
                    
                    let sortedCoins: [Coin] = {
                        switch currentSortBy {
                        case "marketCap":
                            return isMarketCapReversed ? coinViewModel.coinData.sorted(by: {$0.cmc_rank > $1.cmc_rank}) : coinViewModel.coinData.sorted(by: {$0.cmc_rank < $1.cmc_rank})
                        case "price":
                            return isPriceReversed ? coinViewModel.coinData.sorted(by: {$0.price < $1.price}) : coinViewModel.coinData.sorted(by: {$0.price > $1.price})
                        case "percent":
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
