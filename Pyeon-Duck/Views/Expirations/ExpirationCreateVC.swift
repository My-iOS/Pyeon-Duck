//
//  ExpirationCreateVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/24/23.
//

import UIKit

class ExpirationCreateVC: UIViewController {
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
    let createdItemDateLabel = CustomLabel(frame: .zero) // 등록한 상품 날짜
    let modifiedItemDateLabel = CustomLabel(frame: .zero) // 수정한 상품 날짜
    let expirationDateLabel = CustomLabel(frame: .zero) // 상품 유통기한 날짜

    // MARK: - 상품 입력

    var imageView = CustomImageView(frame: .zero) // 직접 찍은 상품 이미지
    var itemTitleTextField = CustomTextField(frame: .zero) // 상품 입력 텍스트 필드
    var microphoneButton = CustomButton(frame: .zero) // 음성 입력 버튼
    let datePicker = UIDatePicker() // 유통기한 날짜 입력

    // MARK: - 저장 버튼

    var saveButton = CustomButton(frame: .zero) // 저장 버튼

    deinit {
        print("#### Deinitialized ExpirationCreateVC")
    }
}

// MARK: - View Life Cycle

extension ExpirationCreateVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup UI

extension ExpirationCreateVC {
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
        createDatePicker()
        createSaveButton()
    }

    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [itemImageLabel, imageView, itemTitleLabel, itemTitleTextField, microphoneButton, expirationDateLabel, datePicker, saveButton].forEach {
            contentView.addSubview($0)
        }
    }
}

// MARK: - Create UI Components && Make Constraints

extension ExpirationCreateVC {
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
        expirationDateLabel.text = "상품 유통기한"
        expirationDateLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            expirationDateLabel.topAnchor.constraint(equalTo: itemTitleTextField.bottomAnchor, constant: 24),
            expirationDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            expirationDateLabel.widthAnchor.constraint(equalToConstant: 130),
            expirationDateLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createDatePicker() {
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: expirationDateLabel.topAnchor, constant: 0),
            datePicker.leadingAnchor.constraint(equalTo: expirationDateLabel.trailingAnchor, constant: 0),
            datePicker.widthAnchor.constraint(equalToConstant: 200),
            datePicker.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createSaveButton() {
        saveButton.setTitle("저장", for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.backgroundColor = .systemBlue

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: expirationDateLabel.bottomAnchor, constant: 50),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 180),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
        ])
    }
}
