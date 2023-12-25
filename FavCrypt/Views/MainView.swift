//
//  testView.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 15.12.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var coinViewModel = CoinListViewModel()
    @State private var isReversed = true
    @State private var isPercentReversed = true
    @State private var isPriceReversed = true
    @State private var isMarketCapReversed = true
    @State private var currentSortBy = ""
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
                ZStack {
                    Color("bgColor")
                    List{
                        if searchText.isEmpty {
                            let sortedCoins: [Coin] = {
                                switch currentSortBy {
                                case "marketCap":
                                    return isMarketCapReversed ? coinViewModel.coinData.sorted(by: {$0.volume_24h < $1.volume_24h}) : coinViewModel.coinData.sorted(by: {$0.volume_24h > $1.volume_24h})
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
                        if !searchText.isEmpty {
                            let searchLowercased = searchText.lowercased()
                            
                            ForEach(coinViewModel.coinData) { coin in
                                if coin.name.localizedCaseInsensitiveContains(searchLowercased) || coin.symbol.localizedCaseInsensitiveContains(searchLowercased) {
                                    CoinRow(coin: coin)
                                        .listRowBackground(Color("rowColor"))
                                        .listRowSeparator(.hidden)
                                }
                            }
                        }
                    }
                    .padding(.top, 80)
                    .toolbar {
                      /*  ToolbarItem {
                            HStack(spacing: 0) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.gray)
                                    .padding(.leading, 20)
                                    .scaleEffect(0.8)
                                TextField("Ara", text: $searchText).scaleEffect(1.2)
                                    .padding(.leading, 30)
                                    .textCase(nil)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 375, height: 35, alignment: .center)
                                    )
                                    .onTapGesture {
                                        hideKeyboard()
                                    }
                                    .frame(width: 295)
                                Button {
                                    searchText = ""
                                } label: {
                                    if !searchText.isEmpty {
                                        Image(systemName: "x.circle.fill")
                                            .foregroundStyle(.gray)
                                            .scaleEffect(0.8)
                                    }
                                }
                                .frame(width: 50, height: 30, alignment: .center)
                            }
                        } */
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                currentSortBy = ""
                                isPriceReversed = true
                                isPercentReversed = true
                                isMarketCapReversed = true
                                isReversed.toggle()
                            })
                            {
                                    Image(systemName: isReversed ? "number.circle.fill" : "number.circle")
                                    .scaleEffect(0.7)
                                    .padding(.leading, 5)
                            }
                        }
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                currentSortBy = "marketCap"
                                isMarketCapReversed.toggle()
                                isReversed = false
                                isPercentReversed = true
                                isPriceReversed = true
                            })
                            {
                                HStack {
                                    Text("Piyasa Değeri")
                                    Image(systemName: isMarketCapReversed ? "chart.pie" : "chart.pie.fill")
                                    .scaleEffect(0.7)
                                    .padding(.leading, -10)
                                }
                                .padding(.leading, -10)
                                
                            }
                        }
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                currentSortBy = "price"
                                isPriceReversed.toggle()
                                isReversed = false
                                isPercentReversed = true
                                isMarketCapReversed = true
                            }) {
                                HStack {
                                    Text("Fiyat")
                                        .font(.system(size: 15))
                                    Image(systemName: isPriceReversed ? "dollarsign.circle" : "dollarsign.circle.fill")
                                        .scaleEffect(0.7)
                                        .padding(.leading, -10)
                                }
                                .padding(.leading, -7)
                            }
                        }
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                currentSortBy = "percent"
                                isPercentReversed.toggle()
                                isPriceReversed = true
                                isReversed = false
                                isMarketCapReversed = true
                            }) {
                                Text("24s" + " " + "%")
                                    .padding(.leading, 15)
                            }
                        }
                    }
                    .toolbarBackground(
                        Color("bgColor").opacity(0.98),
                        for: .navigationBar)
                    .onAppear {
                        coinViewModel.fetchCoinData()
                    }
                }
                .ignoresSafeArea()
            
        }
        .refreshable {
            coinViewModel.fetchCoinData()
        }
        .scrollContentBackground(.hidden)
        
    }
}

extension MainView{
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

#Preview {
    MainView()
}
