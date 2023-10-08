//
//  CoinDetailViewModel.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 8.10.2023.
//

import Foundation

class CoinDetailViewModel: ObservableObject {
    @Published var coinInfo: CoinInfo?
    @Published var coinId: Int = 0 // Tıklanan coin'in id'si

    // CoinMarketCap API için gerekli olan base URL
    let baseURL = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/info"

    // API anahtarını burada tanımlayabilirsiniz
    let apiKey = "0c72d01c-4dac-4df2-8cc8-b76dd663d9d7"

    func fetchCoinDetail() {
        // CoinMarketCap API'sine istek yapmak için bir URL oluşturun
        if var urlComponents = URLComponents(string: baseURL) {
            urlComponents.queryItems = [
                URLQueryItem(name: "id", value: "\(coinId)") // Tıklanan coin'in id'sini gönderin
            ]

            if let url = urlComponents.url {
                var request = URLRequest(url: url)
                request.setValue(apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")

                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print("API isteği sırasında hata oluştu: \(error)")
                        return
                    }

                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let coinDetailData = try decoder.decode(CoinDetailData.self, from: data)
                            // CoinDetailData modeli, API yanıtını işler

                            // CoinInfo modelini alabiliriz
                            if let coinInfo = coinDetailData.data["\(self.coinId)"] {
                                DispatchQueue.main.async {
                                    self.coinInfo = coinInfo
                                }
                            }
                        } catch {
                            print("API yanıtı işlenirken hata oluştu: \(error)")
                        }
                    }
                }.resume()
            }
        }
    }
}

