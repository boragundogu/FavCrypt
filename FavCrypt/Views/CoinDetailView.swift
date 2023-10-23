//
//  CoinDetailViwew.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 6.10.2023.
//

import SwiftUI

struct CoinDetailView: View {
    @StateObject private var detailViewModel: CoinDetailViewModel
    @StateObject private var listViewModel: CoinListViewModel
    var coinId: Int
    var coin: Coin
    
    init(coinId: Int, coin: Coin) {
        self.coinId = coinId
        _detailViewModel = StateObject(wrappedValue: CoinDetailViewModel())
        _listViewModel = StateObject(wrappedValue: CoinListViewModel())
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
                                    Spacer()
                                }
                                .padding(.leading, 20)
                                .padding(.bottom, -30)
                                HStack {
                                    Text("$" + "\(listViewModel.formatPrice(coin.price))")
                                        .fontWeight(.bold)
                                        .font(.system(size: 24))
                                    
                                    Spacer()
                                    if coin.quote.USD.percent_change_24h > 0 {
                                            Text("\(String(format: "%.2f", coin.quote.USD.percent_change_24h))" + "%")
                                                .padding(30)
                                                .background {
                                                    Rectangle()
                                                        .foregroundStyle(.green)
                                                        .clipShape(.rect(cornerRadius: 10))
                                                        .frame(width: 75, height: 31, alignment: .center)
                                                }
                                    }
                                    else {
                                        Text("\(String(format: "%.2f", coin.quote.USD.percent_change_24h))" + "%")
                                            .padding(30)
                                            .background {
                                                Rectangle()
                                                    .foregroundStyle(.red)
                                                    .clipShape(.rect(cornerRadius: 10))
                                                    .frame(width: 75, height: 31, alignment: .center)
                                            }
                                    }
                                }
                                .padding(.leading, 20)
                            }
                        }
                        Text(coinInfo.description)
                            .padding()
                        
                        Text("Official Links")
                            .fontWeight(.bold)
                            .font(.system(size: 23))
                            .padding(.leading, -175)
                        
                        HStack {
                            Spacer()
                            Button {
                                if coinInfo.urls.website != [] {
                                    if let url = URL(string: coinInfo.urls.website.first ?? "No website found.") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "network")
                                        .foregroundStyle(.white)
                                        .opacity(0.8)
                                    Text("Website")
                                        .foregroundStyle(.white)
                                }
                                .background {
                                    Rectangle()
                                        .clipShape(.rect(cornerRadius: 10))
                                        .foregroundColor(.gray)
                                        .frame(width: 107, height: 31, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                }
                            }
                            .opacity(coinInfo.urls.website == [] ? 0 : 1)
                            Spacer()
                            Spacer()
                            Button {
                                if coinInfo.urls.technical_doc != [] {
                                    if let url = URL(string: coinInfo.urls.technical_doc.first ?? "No website found.") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            }label: {
                                HStack {
                                    Image(systemName: "doc")
                                        .foregroundStyle(.white)
                                        .opacity(0.8)
                                    Text("Whitepaper")
                                        .foregroundStyle(.white)
                                }
                                .background {
                                    Rectangle()
                                        .clipShape(.rect(cornerRadius: 10))
                                        .foregroundColor(.gray)
                                        .frame(width: 137, height: 31, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                }
                            }
                            Spacer()
                            Spacer()
                            Button {
                                if coinInfo.urls.source_code != [] {
                                    if let url = URL(string: coinInfo.urls.source_code.first ?? "No website found.") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            } label: {
                                HStack {
                                    Image("github")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20, alignment: .center)
                                        .foregroundStyle(.white)
                                        .opacity(0.8)
                                    Text("GitHub")
                                        .foregroundStyle(.white)
                                }
                                .background {
                                    Rectangle()
                                        .clipShape(.rect(cornerRadius: 10))
                                        .foregroundColor(.gray)
                                        .frame(width: 100, height: 31, alignment: .center)
                                }
                            }
                            .opacity(coinInfo.urls.source_code == [] ? 0 : 1)
                            Spacer()
                        }
                        .padding(10)
                        
                        Text("Socials")
                            .fontWeight(.bold)
                            .font(.system(size: 23))
                            .padding(.leading, -175)
                            .padding(.bottom, -3)
                        HStack {
                            if !coinInfo.urls.twitter.isEmpty {
                                ButtonWithIconForTwitter(imageName: "x", text: "Twitter", url: coinInfo.urls.twitter.first ?? "", width: 120, height: 30)
                                    .padding()
                            } else {
                                ButtonWithIconForTwitter(imageName: "x", text: "Twitter", url: coinInfo.urls.twitter.first ?? "", width: 120, height: 30)
                                    .padding()
                                    .disabled(true)
                                    .opacity(0.2)
                            }
                            if !coinInfo.urls.facebook.isEmpty {
                                ButtonWithIcon(imageName: "facebook", text: "Facebook", url: coinInfo.urls.facebook.first ?? "", width: 120, height: 30)
                                    .padding()
                            } else {
                                ButtonWithIcon(imageName: "facebook", text: "Facebook", url: coinInfo.urls.facebook.first ?? "", width: 120, height: 30)
                                    .padding()
                                    .disabled(true)
                                    .opacity(0.2)
                            }
                            if !coinInfo.urls.reddit.isEmpty {
                                ButtonWithIcon(imageName: "reddit", text: "Reddit", url: coinInfo.urls.reddit.first ?? "", width: 100, height: 30)
                                    .padding()
                            } else {
                                ButtonWithIcon(imageName: "reddit", text: "Reddit", url: coinInfo.urls.reddit.first ?? "", width: 100, height: 30)
                                    .padding()
                                    .disabled(true)
                                    .opacity(0.2)
                            }
                        }
                        
                        Text("Network Information")
                            .fontWeight(.bold)
                            .font(.system(size: 23))
                            .padding(.leading, -125)
                            .padding(.bottom, 5)
                        
                        
                        VStack {
                            HStack {
                                Image(systemName: "network")
                                    .foregroundStyle(.white)
                                Menu {
                                    ForEach(coinInfo.urls.explorer, id: \.self) { link in
                                        if let cleanLink = cleanURL(link) {
                                            Button(action: {
                                                if let url = URL(string: link) {
                                                    UIApplication.shared.open(url)
                                                }
                                            }) {
                                                Text(cleanLink)
                                                    .font(.system(size: 11))
                                                    .lineLimit(1)
                                                    .minimumScaleFactor(0.7)
                                                    .foregroundStyle(.white)
                                                    .background {
                                                        Rectangle()
                                                            .clipShape(.rect(cornerRadius: 10))
                                                            .foregroundColor(.gray)
                                                            .frame(width: 125, height: 31, alignment: .center)
                                                    }
                                            }
                                        }
                                    }
                                }
                            label: {
                                Text("Chain Explorers")
                                    .foregroundStyle(.white)
                            }
                            }
                            .padding()
                            .background {
                                Rectangle()
                                    .clipShape(.rect(cornerRadius: 10))
                                    .foregroundColor(.gray)
                                    .frame(width: 170, height: 31, alignment: .center)
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

func cleanURL(_ url: String) -> String? {
    if let urlComponents = URLComponents(string: url) {
        if let host = urlComponents.host {
            var cleanedLink = host
            
            if host.lowercased().hasPrefix("www.") {
                if let index = host.range(of: "www.") {
                    cleanedLink = String(host.suffix(from: index.upperBound))
                }
            }
            return cleanedLink
        }
    }
    return nil
}


struct ButtonWithIcon: View {
    var imageName: String
    var text: String
    var url: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Button {
            if let webURL = URL(string: url) {
                UIApplication.shared.open(webURL)
            }
        } label: {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundStyle(.white)
                    .opacity(0.8)
                Text(text)
                    .foregroundStyle(.white)
            }
            .background {
                Rectangle()
                    .clipShape(.rect(cornerRadius: 10))
                    .foregroundColor(.gray)
                    .frame(width: width, height: height, alignment: .center)
            }
        }
    }
}

struct ButtonWithIconForTwitter: View {
    var imageName: String
    var text: String
    var url: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Button {
            if let twitterURL = URL(string: url) {
                if let username = twitterURL.pathComponents.last {
                    if !username.isEmpty {
                        if let appURL = URL(string: "twitter://user?screen_name=\(username)") {
                            if UIApplication.shared.canOpenURL(appURL) {
                                UIApplication.shared.open(appURL)
                                return
                            }
                        }
                    }
                }
                if let webURL = URL(string: url) {
                    UIApplication.shared.open(webURL)
                }
            }
        } label: {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundStyle(.white)
                    .opacity(0.8)
                Text(text)
                    .foregroundStyle(.white)
            }
            .background {
                Rectangle()
                    .clipShape(.rect(cornerRadius: 10))
                    .foregroundColor(.gray)
                    .frame(width: width, height: height, alignment: .center)
            }
        }
    }
}


#Preview {
    CoinDetailView(coinId: 1, coin: Coin(id: 1027, name: "Etherueum", symbol: "ETH", quote: .init(USD: .init(price: 26754.30, volume_24h: 1, market_cap: 1, market_cap_dominance: 1, percent_change_24h: 0.25)), cmc_rank: 2))
}
