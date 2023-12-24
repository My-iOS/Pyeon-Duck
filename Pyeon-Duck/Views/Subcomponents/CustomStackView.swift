//
//  CustomStackView.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/23/23.
//

import UIKit

class CustomStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
