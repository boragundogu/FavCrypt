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
    let urls: Urls
    let symbol: String
    let description: String
    let slug: String
    let logo: String
    
    
    struct Urls: Codable {
        let website: [String]
        let twitter: [String]
        let facebook: [String]
        let reddit: [String]
        let technical_doc: [String]
        let explorer: [String]
        let source_code: [String]
    }
}

