import Foundation

struct CoinResponse: Codable {
    let data: [Coin]
}

struct Coin: Codable, Identifiable {
    let id: Int
    let name: String
    let symbol: String
    let quote: Quote
    let cmc_rank: Int
    
    
    struct Quote: Codable {
        let USD: USD
        
        struct USD: Codable {
            let price: Double
            let volume_24h: Double
            let market_cap: Double
            let market_cap_dominance: Double
            let percent_change_24h: Double
        }
    }
    
    var price: Double {
        return quote.USD.price
    }
    
    var volume_24h: Double {
        return quote.USD.volume_24h
    }
}
