//
//  ExpirationCell.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/19/23.
//

import SwiftUI
import UIKit

class ExpirationListCell: UITableViewCell {
    static let identifier = "ExpirationListCell"

    var titleLabel = CustomLabel(frame: .zero)
    var actionSwitch = UISwitch(frame: .zero)

    var switchHandler: ((Bool) -> Void)?

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

        createTitleLabel()
        createSwitch()
    }

    func addView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(actionSwitch)
    }
}

// MARK: - Create Components && Make Constraints

extension ExpirationListCell {
    func createTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
        ])
    }

    func createSwitch() {
        actionSwitch.translatesAutoresizingMaskIntoConstraints = false
        actionSwitch.addTarget(self, action: #selector(didClickSwitch), for: .valueChanged)

        NSLayoutConstraint.activate([
            actionSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionSwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            actionSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 48),

            actionSwitch.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
}

// MARK: - Switch Method

extension ExpirationListCell {
    @objc func didClickSwitch(_ sender: UISwitch) {
        contentView.alpha = getAlpha(sender.isOn)
        switchHandler?(sender.isOn)
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

// UITableViewCell을 SwiftUI 뷰로 변환
struct ExpirationListCellPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let cell = ExpirationListCell(style: .default, reuseIdentifier: nil)
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

// SwiftUI 프리뷰 제공
struct ExpirationListCellPreview_Previews: PreviewProvider {
    static var previews: some View {
        ExpirationListCellPreview()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
