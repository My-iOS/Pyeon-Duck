//
//  ViewModelInjectable.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import Foundation

protocol ViewModelInjectable {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }

    // 뷰모델 주입하는 함수
    func injectViewModel(_ viewModelType: ViewModelType)
}
