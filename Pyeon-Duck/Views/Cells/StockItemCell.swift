//
//  StockItemCell.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/30/23.
//

import UIKit

class StockItemCell: UITableViewCell {
    static let identifier: String = "StockItemCell"

    var titleLabel = CustomLabel(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI

extension StockItemCell {
    func setupUI() {
        addView()
        createTitleLabel()
    }

    func addView() {
        contentView.addSubview(titleLabel)
    }
}

// MARK: - Create Components && Make Constraints

extension StockItemCell {
    func createTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150)
        ])
    }
}
