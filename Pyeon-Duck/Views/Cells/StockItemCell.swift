//
//  StockItemCell.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/30/23.
//

import SwiftUI
import UIKit

// Task - 셀 UI 변경
class StockItemCell: UITableViewCell {
    static let identifier: String = "StockItemCell"
    var isConfirm = false

    let baseView = UIView(frame: .zero)
    var itemImage = CustomImageView(frame: .zero)
    var titleLabel = CustomLabel(frame: .zero)
    var countLabel = CustomLabel(frame: .zero)
    var checkButton = CustomButton(frame: .zero)

    var actionHandler: ((Bool) -> Void)?

    override func awakeFromNib() {
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

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

        createBaseView()
        createItemImage()
        createTitleLabel()
        createCountLabel()
        createCheckButton()
    }

    func addView() {
        contentView.addSubview(baseView)

        [itemImage, titleLabel, countLabel, checkButton].forEach {
            baseView.addSubview($0)
        }
    }

    func confirm(_ title: String, _ count: Int, _ imageData: Data, _ isConfirm: Bool) {
        titleLabel.text = title
        countLabel.text = "\(count) 개"
        itemImage.image = UIImage(data: imageData)

        let imageName = isConfirm ? "checkmark.square" : "square"
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: imageName, withConfiguration: imageConfig)

        checkButton.setImage(image, for: .normal)
    }
}

// MARK: - Create Components && Make Constraints

extension StockItemCell {
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

    func createItemImage() {
        itemImage.contentMode = .scaleAspectFill
        itemImage.layer.cornerRadius = 20
        itemImage.layer.masksToBounds = true
        itemImage.layer.borderColor = UIColor.black.cgColor
        itemImage.layer.borderWidth = 1

        NSLayoutConstraint.activate([
            itemImage.centerYAnchor.constraint(equalTo: baseView.centerYAnchor),
            itemImage.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 20),
            itemImage.widthAnchor.constraint(equalToConstant: 40),
            itemImage.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    func createTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: itemImage.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
        ])
    }

    func createCountLabel() {
        countLabel.font = .systemFont(ofSize: 14, weight: .medium)

        NSLayoutConstraint.activate([
            countLabel.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 0),
            countLabel.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 20),
            countLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
        ])
    }

    func createCheckButton() {
        checkButton.tintColor = .black
        checkButton.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            checkButton.centerYAnchor.constraint(equalTo: baseView.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -8),
            checkButton.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 10),
            checkButton.widthAnchor.constraint(equalToConstant: 60),
            checkButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

// MARK: - Button Method

extension StockItemCell {
    @objc func didClickButton(_ sender: UIButton) {
        isConfirm.toggle()
        contentView.alpha = getAlpha(isConfirm)

        let imageName = isConfirm ? "checkmark.square" : "square"
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: imageName, withConfiguration: imageConfig)

        checkButton.setImage(image, for: .normal)

        actionHandler?(isConfirm)
    }

    func getAlpha(_ isOn: Bool) -> CGFloat {
        return isOn ? 0.3 : 1
    }

    func setupAlpah(_ isConfirm: Bool) {
        if isConfirm == true {
            contentView.alpha = 0.3
        } else {
            contentView.alpha = 1
        }
    }
}

//// UITableViewCell을 SwiftUI 뷰로 변환
// struct StockItemCellPreview: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIView {
//        let cell = StockItemCell(style: .default, reuseIdentifier: nil)
//        let container = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 80))
//        container.addSubview(cell)
//        cell.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            cell.topAnchor.constraint(equalTo: container.topAnchor),
//            cell.leadingAnchor.constraint(equalTo: container.leadingAnchor),
//            cell.trailingAnchor.constraint(equalTo: container.trailingAnchor),
//            cell.bottomAnchor.constraint(equalTo: container.bottomAnchor),
//        ])
//        return container
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//        // SwiftUI 뷰 업데이트
//    }
// }
//
//// SwiftUI 프리뷰 제공
// struct StockItemCellPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        StockItemCellPreview()
//            .previewLayout(.sizeThatFits)
//            .frame(height: 90)
//            .padding()
//    }
// }
