//
//  StocCategorykCell.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/19/23.
//

import SwiftUI
import UIKit

// Task - 셀 UI 변경
class StockCategoryCell: UITableViewCell {
    static let identifier = "StocCategorykCell"

    let baseView = UIView(frame: .zero)
    var titleLabel = CustomLabel(frame: .zero)
    var countLabel = CustomLabel(frame: .zero)
    var disclosureImage = CustomImageView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        titleLabel.text = "Hello"
//        countLabel.text = "1 개"
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI

extension StockCategoryCell {
    func setupUI() {
        addView()
        createBaseView()
        createTitleLabel()
        createCountLable()
        createImageView()
    }

    func addView() {
        contentView.addSubview(baseView)
        baseView.addSubview(titleLabel)
        baseView.addSubview(countLabel)
        baseView.addSubview(disclosureImage)
    }
}

// MARK: - Create Components && Make Constraints

extension StockCategoryCell {
    func createBaseView() {
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = .white
        baseView.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }

    func createTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: baseView.centerYAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 32),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
        ])
    }

    func createCountLable() {
        countLabel.font = .systemFont(ofSize: 14, weight: .bold)
        countLabel.textColor = .systemGray

        NSLayoutConstraint.activate([
            countLabel.centerYAnchor.constraint(equalTo: baseView.centerYAnchor, constant: 12),
            countLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 32),
            countLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
        ])
    }

    func createImageView() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)
        disclosureImage.image = image
        disclosureImage.contentMode = .scaleAspectFit
        disclosureImage.tintColor = .systemGray

        NSLayoutConstraint.activate([
            disclosureImage.centerYAnchor.constraint(equalTo: baseView.centerYAnchor),
            disclosureImage.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16),
            disclosureImage.widthAnchor.constraint(equalToConstant: 30),
            disclosureImage.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

struct StocCategoryCellPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let cell = StockCategoryCell(style: .default, reuseIdentifier: nil)
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 50))
        container.addSubview(cell)
        cell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.topAnchor.constraint(equalTo: container.topAnchor),
            cell.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            cell.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            cell.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])
        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // SwiftUI 뷰 업데이트
    }
}

struct StocCategoryCellPreview_Previews: PreviewProvider {
    static var previews: some View {
        StocCategoryCellPreview()
            .previewLayout(.sizeThatFits)
            .frame(height: 90)
            .padding()
    }
}
