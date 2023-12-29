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

    func setupUI() {
        contentView.addSubview(titleLabel)

        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

//    // 이 부분에 셀의 레이아웃을 구성하는 코드를 추가하세요.
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        // 여기에 셀 구성을 추가하세요.
//        self.textLabel?.text = "만료일 목록 셀"
//    }
//
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

// UITableViewCell을 SwiftUI 뷰로 변환
// struct ExpirationListCellPreview: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIView {
//        let cell = ExpirationListCell(style: .default, reuseIdentifier: nil)
//        let container = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 50))
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
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
// }
