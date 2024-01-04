//
//  StockDetailViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/30/23.
//

import Foundation
import UIKit

class StockDetailViewModel {
    var stockItem: StockItem!
    var selectedCategory: StockCategory?

    var stockItemTitle: String {
        return self.stockItem.itemTitle ?? "N/A"
    }

    var stockItemImage: Data {
        if let imageData = self.stockItem.itemImage {
            return imageData
        } else if let defaultImage = UIImage(systemName: "camera"), let pngData = defaultImage.pngData() {
            return pngData
        } else {
            // 여기서는 UIImage나 pngData가 nil인 경우를 처리합니다.
            // 예를 들어, 빈 Data 객체를 반환할 수 있습니다.
            return Data()
        }
    }
    
    var stockItemCount: Int {
        return Int(self.stockItem.itemCount)
    }
    
}
