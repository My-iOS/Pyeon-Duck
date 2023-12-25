//
//  StockCreateVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/24/23.
//

import UIKit

class StockCreateVC: UIViewController {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = false
        return scrollView
    }()

    // MARK: - 본 내용들이 들어가는 View

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - 상품 안내

    let itemImageLabel = CustomLabel(frame: .zero) // 상품 이미지 레이블
    let itemTitleLabel = CustomLabel(frame: .zero) // 상품 이름
    let stockCountDescribeLabel = CustomLabel(frame: .zero) // 상품 수 설명 레이블

    // MARK: - 상품 입력

    var imageView = CustomImageView(frame: .zero) // 직접 찍은 상품 이미지
    var itemTitleTextField = CustomTextField(frame: .zero) // 상품 입력 텍스트 필드
    var microphoneButton = CustomButton(frame: .zero) // 음성 입력 버튼

    let stockCountLabel = CustomLabel(frame: .zero) // 상품 개수 레이블
    // 재고 갯수 증가/감소
    let stockStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.value = 1
        stepper.maximumValue = 99
        stepper.minimumValue = 1
        return stepper
    }()

    // MARK: - 저장 버튼

    var saveButton = CustomButton(frame: .zero) // 저장 버튼

    deinit {
        print("#### Deinitialized ExpirationCreateVC")
    }
}

// MARK: - View Life Cycle

extension StockCreateVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup UI

extension StockCreateVC {
    func setupUI() {
        view.backgroundColor = .white
        addView()
        createScrollView()
        createContentView()

        createItemImageLabel()
        createImageView()
        createItemTitleLabel()
        createItemTitleTextField()
        createMicrophoneButton()
        createExpirationDateLabel()

        createStockCountLabel()
        createStockStepper()

        createSaveButton()

        createResetButton()
    }

    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [itemImageLabel, imageView, itemTitleLabel, itemTitleTextField, microphoneButton, stockCountDescribeLabel, stockCountLabel, stockStepper, saveButton].forEach {
            contentView.addSubview($0)
        }
    }
}

// MARK: - Create UI Components && Make Constraints

extension StockCreateVC {
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
        itemImageLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            itemImageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            itemImageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemImageLabel.widthAnchor.constraint(equalToConstant: 120),
            itemImageLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createImageView() {
        imageView.image = UIImage(systemName: "camera")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray6
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: itemImageLabel.bottomAnchor, constant: 12),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }

    func createItemTitleLabel() {
        itemTitleLabel.text = "상품 이름"
        itemTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            itemTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            itemTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            itemTitleLabel.widthAnchor.constraint(equalToConstant: 120),
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createItemTitleTextField() {
        itemTitleTextField.placeholder = "상품 이름을 입력해주세요."
        itemTitleTextField.addLeftPadding()
        itemTitleTextField.layer.cornerRadius = 10
        itemTitleTextField.layer.borderWidth = 1
        itemTitleTextField.layer.borderColor = UIColor.gray.cgColor
        itemTitleTextField.backgroundColor = .white

        NSLayoutConstraint.activate([
            itemTitleTextField.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: 24),
            itemTitleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            itemTitleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -96),
            itemTitleTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            itemTitleTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createMicrophoneButton() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30) // 이미지 크기 조절
        let image = UIImage(systemName: "mic.fill", withConfiguration: configuration)
        microphoneButton.setImage(image, for: .normal)
        microphoneButton.imageView?.tintColor = .white
        microphoneButton.backgroundColor = .red
        microphoneButton.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            microphoneButton.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: 24),
            microphoneButton.leadingAnchor.constraint(equalTo: itemTitleTextField.trailingAnchor, constant: 10),
            microphoneButton.widthAnchor.constraint(equalToConstant: 60),
            microphoneButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createExpirationDateLabel() {
        stockCountDescribeLabel.text = "상품 수"
        stockCountDescribeLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            stockCountDescribeLabel.topAnchor.constraint(equalTo: itemTitleTextField.bottomAnchor, constant: 24),
            stockCountDescribeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stockCountDescribeLabel.widthAnchor.constraint(equalToConstant: 130),
            stockCountDescribeLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createStockCountLabel() {
        stockCountLabel.text = "\(Int(stockStepper.value))개"
        stockCountLabel.font = .systemFont(ofSize: 20, weight: .bold)

        NSLayoutConstraint.activate([
            stockCountLabel.topAnchor.constraint(equalTo: stockCountDescribeLabel.topAnchor),
            stockCountLabel.leadingAnchor.constraint(equalTo: stockCountDescribeLabel.trailingAnchor, constant: 24),
            stockCountLabel.widthAnchor.constraint(equalToConstant: 120),
            stockCountLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createStockStepper() {
        NSLayoutConstraint.activate([
            stockStepper.topAnchor.constraint(equalTo: stockCountDescribeLabel.topAnchor, constant: 10),
            stockStepper.leadingAnchor.constraint(equalTo: stockCountLabel.trailingAnchor, constant: -36),
            stockStepper.widthAnchor.constraint(equalToConstant: 120),
            stockStepper.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createSaveButton() {
        saveButton.setTitle("저장", for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.backgroundColor = .systemBlue

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: stockCountDescribeLabel.bottomAnchor, constant: 50),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 180),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
        ])
    }
}

// MARK: - Reset Button

extension StockCreateVC {
    // To-Do Stuff
    func createResetButton() {
        let resetButton = UIBarButtonItem(image: UIImage(systemName: "gobackward"), style: .plain, target: self, action: #selector(didTapRestButton))
        navigationItem.rightBarButtonItem = resetButton
    }

    @objc func didTapRestButton(_ sender: UIBarButtonItem) {
        print("#### \(#function)")
    }
}

// MARK: - SWIFT UI PREVIEWS

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13, *)
//extension UIViewController {
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
//}
//
//@available(iOS 13.0, *)
//struct StockCreateVC_Preview: PreviewProvider {
//    static var previews: some View {
//        StockCreateVC().toPreview()
//    }
//}
//#endif
