//
//  Stock.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import Foundation

struct Stock {
    var title: String
}

// MARK: - Sample Data

extension Stock {
    static let sampleData: [Stock] = [
        Stock(title: "1"),
        Stock(title: "2"),
        Stock(title: "3"),
        Stock(title: "4"),
        Stock(title: "5")
    ]
}
