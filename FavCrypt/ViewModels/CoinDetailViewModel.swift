//
//  CoinDetailViewModel.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 8.10.2023.
//

import Foundation

class CoinDetailViewModel: ObservableObject {
    @Published var coinInfo: CoinInfo?
    @Published var coinId: Int = 0

    let baseURL = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/info"

    //let apiKey = "0c72d01c-4dac-4df2-8cc8-b76dd663d9d7"

    func fetchCoinDetail() {
        if var urlComponents = URLComponents(string: baseURL) {
            urlComponents.queryItems = [
                URLQueryItem(name: "id", value: "\(coinId)")
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

