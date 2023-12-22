//
//  ViewModelInjectable.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import Foundation

protocol ViewModelInjectable {
    /*
     associatedtype
     associatedtype은 프로토콜 내에서 사용되며, 해당 프로토콜을 구현하는 타입이 제공해야 하는 연관 타입을 정의할 때 사용됩니다.
     이를 통해 프로토콜은 일부 타입 정보를 구현하는 타입에 위임하여, 프로토콜이 보다 일반적인 형태로 사용될 수 있도록 합니다.
     */
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }

    // 뷰모델 주입하는 함수
    func injectViewModel(_ viewModelType: ViewModelType)
}

/*
 typealias
 typealias는 기존의 타입에 대한 다른 이름(별칭)을 정의하는 데 사용됩니다. 이는 코드의 가독성을 높이거나 타입의 목적을 명확히 하는 데 도움을 줍니다.
 클래스, 구조체, 열거형 뿐만 아니라 함수 타입이나 복잡한 제네릭 타입에도 사용할 수 있습니다.
 */
