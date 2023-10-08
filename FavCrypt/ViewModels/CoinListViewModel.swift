
import Foundation

class CoinListViewModel: ObservableObject {
    @Published var coinData: [Coin] = []
    
    
    func fetchCoinData() {
            if let url = URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=200") {
                var request = URLRequest(url: url)
                request.setValue("0c72d01c-4dac-4df2-8cc8-b76dd663d9d7", forHTTPHeaderField: "X-CMC_PRO_API_KEY")
                
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print("Hata: \(error)")
                    } else if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let coinResponse = try decoder.decode(CoinResponse.self, from: data)
                            DispatchQueue.main.async {
                                self.coinData = coinResponse.data
                            }
                        } catch {
                            print("Veri çözümleme hatası: \(error)")
                        }
                    }
                }
                task.resume()
            }
        }
    
}
