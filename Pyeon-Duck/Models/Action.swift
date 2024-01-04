//
//  Action.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 1/4/24.
//

import Foundation

enum Action {
    case read
    case update

    var tagNum: Int {
        switch self {
        case .read:
            return 1
        case .update:
            return 2
        }
    }
}
