//
//  CustomTableView.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/19/23.
//

import UIKit

class CustomTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
