//
//  CoinPrediction.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 22.10.2023.
//

import SwiftUI

struct CoinPrediction: View {
    @StateObject private var coinVM = CoinListViewModel()
    @State private var selectedCoinId = 0
    @State var growthPercentage: Double?
    @State private var placeholder: String = "Select"
    @State private var selection: String?
    @State private var isShowing = false
    //
    var maxWidth: CGFloat = 180
    var cornerRadius: CGFloat = 15
    @State private var showOption = false
    @Environment(\.colorScheme) private var scheme
    
    
    var body: some View {
        
        
        VStack {
            Picker("Select Coin", selection: $selectedCoinId) {
                Text("Select Coin")
                    .tag(-1)
                ForEach(coinVM.coinData, id:\.id) { coin in
                    Text(coin.name + " " + "(\(coin.symbol))")
                        .tag(coin.id)
                }
            }
            .onChange(of: selectedCoinId) { _ in
                isShowing = false
            }
            //.pickerStyle(.wheel)
            .onAppear {
                coinVM.fetchCoinData()
            }
            TextField("Growth Percentage", value: $growthPercentage, format: .number)
            Button {
                if selectedCoinId != -1 && !(growthPercentage ?? 0.0).isZero {
                    isShowing.toggle()
                } else {
                    
                    isShowing = false
                }
            } label: {
                isShowing ? Text("") : Text("Prediction")
            }
            .disabled(selectedCoinId == -1 || (growthPercentage ?? 0.0).isZero)
            if isShowing == true {
                ForEach(coinVM.coinData) { coin in
                    if selectedCoinId == coin.id {
                        VStack {
                            AsyncImage(url: URL(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/\(coin.id).png"))
                                .scaledToFill()
                                .frame(width: 50, height: 50, alignment: .center)
                                .clipShape(Circle())
                            Text(coin.name)
                            Text("\(coin.price)")
                            let pred = coinVM.calculatePrediction(d: coin.price, x: growthPercentage ?? 0.0, n: 1)
                            Text("\(pred)")
                        }
                    }
                }
            }
        }
        
    }
    
}



#Preview {
    CoinPrediction()
    
}
