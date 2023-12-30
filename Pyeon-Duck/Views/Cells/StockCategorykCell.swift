//
//  StocCategorykCell.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/19/23.
//

import SwiftUI
import UIKit

class StockCategorykCell: UITableViewCell {
    static let identifier = "StocCategorykCell"

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

extension StockCategorykCell {
    func setupUI() {
        addView()
        createTitleLabel()
    }

    func addView() {
        contentView.addSubview(titleLabel)
    }
}

// MARK: - Create Components && Make Constraints

extension StockCategorykCell {
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

// struct StocCategorykCellPreview: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIView {
//        let cell = StockCategorykCell(style: .default, reuseIdentifier: nil)
//        let container = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 50))
//        container.addSubview(cell)
//        cell.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            cell.topAnchor.constraint(equalTo: container.topAnchor),
//            cell.leadingAnchor.constraint(equalTo: container.leadingAnchor),
//            cell.trailingAnchor.constraint(equalTo: container.trailingAnchor),
//            cell.bottomAnchor.constraint(equalTo: container.bottomAnchor)
//        ])
//        return container
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//        // SwiftUI 뷰 업데이트
//    }
// }
//
// struct StocCategorykCellPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        StocCategorykCellPreview()
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
// }
