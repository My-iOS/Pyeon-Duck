//
//  StockDetailVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/25/23.
//

import UIKit

class StockDetailVC: UIViewController {
    var viewModel = StockDetailViewModel()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemOrange
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    // MARK: - 본 내용들이 들어가는 View

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        return view
    }()

    // MARK: - 상태 표시 설명 라벨

    let itemImageLabel = CustomLabel(frame: .zero) // 상품 이미지 레이블
    let itemTitleDescribeLabel = CustomLabel(frame: .zero) // 상품 이름 표시 레이블
    let stockCountDescribeLabel = CustomLabel(frame: .zero) // 상품 수 설명 레이블

    // MARK: - 상품 표시

    var imageView = CustomImageView(frame: .zero) // 직접 찍은 상품 이미지
    var itemTitleLabel = CustomLabel(frame: .zero) // 상품 입력 레이블

    let stockCountLabel = CustomLabel(frame: .zero) // 상품 개수 레이블

    // MARK: - 변경 버튼

    var editButton = CustomButton(frame: .zero) // 변경 버튼
}

// MARK: - View Life Cycle

extension StockDetailVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Set up UI

extension StockDetailVC {
    func setupUI() {
        view.backgroundColor = .white
        addView()
        createScrollView()
        createContentView()

        createItemImageLabel()
        createImageView()
        createItemTitleDescribeLabel()
        createItemTitleLabel()
        createStockCountDescribeLabel()
        createStockCountLabel()

        createEditButton()
    }

    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [itemImageLabel, imageView, itemTitleDescribeLabel, itemTitleLabel, stockCountDescribeLabel, stockCountLabel, editButton].forEach {
            contentView.addSubview($0)
        }
    }
}

// MARK: - Create Components && Make a Constraints

extension StockDetailVC {
    func createScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func createContentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // 너비 제약 조건 추가
//            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 1400), // 높이 제약 조건 추가 (필요에 따라 조절)
        ])
    }

    func createItemImageLabel() {
        itemImageLabel.text = "상품 이미지"
        itemImageLabel.textAlignment = .center
        itemImageLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            itemImageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            itemImageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            itemImageLabel.widthAnchor.constraint(equalToConstant: 150),
            itemImageLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createImageView() {
        imageView.image = UIImage(data: viewModel.stockItemImage)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .systemGray6

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: itemImageLabel.bottomAnchor, constant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }

    func createItemTitleDescribeLabel() {
        itemTitleDescribeLabel.text = "상품 이름 :"
        itemTitleDescribeLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            itemTitleDescribeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 36),
            itemTitleDescribeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            itemTitleDescribeLabel.widthAnchor.constraint(equalToConstant: 150),
            itemTitleDescribeLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createItemTitleLabel() {
        itemTitleLabel.text = viewModel.stockItemTitle
        itemTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            itemTitleLabel.topAnchor.constraint(equalTo: itemTitleDescribeLabel.topAnchor, constant: 0),
            itemTitleLabel.leadingAnchor.constraint(equalTo: itemTitleDescribeLabel.trailingAnchor, constant: 12),
            itemTitleLabel.widthAnchor.constraint(equalToConstant: 150),
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createStockCountDescribeLabel() {
        stockCountDescribeLabel.text = "필요한 상품 수 :"
        stockCountDescribeLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            stockCountDescribeLabel.topAnchor.constraint(equalTo: itemTitleDescribeLabel.bottomAnchor, constant: 24),
            stockCountDescribeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stockCountDescribeLabel.widthAnchor.constraint(equalToConstant: 150),
            stockCountDescribeLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createStockCountLabel() {
        stockCountLabel.text = "\(viewModel.stockItemCount) 개"
        stockCountLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            stockCountLabel.topAnchor.constraint(equalTo: stockCountDescribeLabel.topAnchor, constant: 0),
            stockCountLabel.leadingAnchor.constraint(equalTo: stockCountDescribeLabel.trailingAnchor, constant: 24),
            stockCountLabel.widthAnchor.constraint(equalToConstant: 150),
            stockCountLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createEditButton() {
        editButton.setTitle("변경", for: .normal)
        editButton.layer.cornerRadius = 10
        editButton.backgroundColor = .systemBlue
        editButton.tintColor = .white
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: stockCountDescribeLabel.bottomAnchor, constant: 60),
            editButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -142),
            editButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 150),
            editButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    @objc func didTapEditButton(_ sender: UIButton) {
        let vc = StockCreateVC()
        vc.viewModel.actionTag = 2
        vc.viewModel.stockItem = viewModel.stockItem
        vc.viewModel.selectedStockCategory = viewModel.selectedCategory

        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - SWIFT UI PREVIEWS

// #if DEBUG
// import SwiftUI
//
// @available(iOS 13, *)
// extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        // this variable is used for injecting the current view controller
//        let viewController: UIViewController
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//    }
//
//    func toPreview() -> some View {
//        // inject self (the current view controller) for the preview
//        Preview(viewController: self)
//    }
// }
//
// @available(iOS 13.0, *)
// struct StockDetailVC_Preview: PreviewProvider {
//    static var previews: some View {
//        StockDetailVC().toPreview()
//    }
// }
// #endif
