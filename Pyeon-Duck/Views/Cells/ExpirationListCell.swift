//
//  ExpirationCell.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/19/23.
//

import SwiftUI
import UIKit

// Task - 셀 UI 변경
class ExpirationListCell: UITableViewCell {
    static let identifier = "ExpirationListCell"
    var isConfirm = false

    let baseView = UIView(frame: .zero)
    var itemImage = CustomImageView(frame: .zero)
    var titleLabel = CustomLabel(frame: .zero)
    var checkButton = CustomButton(frame: .zero)

    var actionHandler: ((Bool) -> Void)?

    override func awakeFromNib() {
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // 이 부분에 셀의 레이아웃을 구성하는 코드를 추가하세요.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 여기에 셀 구성을 추가하세요.
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI

extension ExpirationListCell {
    func setupUI() {
        addView()

        createBaseView()
        createItemImage()
        createTitleLabel()
        createCheckButton()
    }

    func addView() {
        contentView.addSubview(baseView)

        [itemImage, titleLabel, checkButton].forEach {
            baseView.addSubview($0)
        }
    }

    func confirm(_ title: String, _ imageData: Data, _ isConfirm: Bool) {
        titleLabel.text = title
        itemImage.image = UIImage(data: imageData)

        let imageName = isConfirm ? "checkmark.square" : "square"
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: imageName, withConfiguration: imageConfig)

        checkButton.setImage(image, for: .normal)
    }
}

// MARK: - Create Components && Make Constraints

extension ExpirationListCell {
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
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: baseView.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: itemImage.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
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

extension ExpirationListCell {
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
// struct ExpirationListCellPreview: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIView {
//        let cell = ExpirationListCell(style: .default, reuseIdentifier: nil)
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
// struct ExpirationListCellPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpirationListCellPreview()
//            .previewLayout(.fixed(width: 375, height: 80))
//            .frame(height: 90)
//            .padding()
//    }
// }
