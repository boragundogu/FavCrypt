//
//  CoinDetail.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 8.10.2023.
//

import Foundation

struct CoinDetailData: Codable {
    let data: [String: CoinInfo]
}

struct CoinInfo: Codable {
    let id: Int
    let name: String
    let symbol: String
    let description: String
    let slug: String
    let logo: String
}
