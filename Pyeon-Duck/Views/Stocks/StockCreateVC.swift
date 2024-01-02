//
//  StockCreateVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/24/23.
//

import Speech
import UIKit

class StockCreateVC: UIViewController {
    var viewModel = StockCreateViewModel()

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

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "유통기한 상품 작성"
        navigationItem.largeTitleDisplayMode = .never
        setupUI()
    }
}

// MARK: - Setup UI

extension StockCreateVC {
    func setupUI() {
        view.backgroundColor = .systemGray6
        viewModel.sstService.speechRecognizer?.delegate = self
        hideKeyboardWhenTappedAround()

        addView()
        configureUI()

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

    func configureUI() {
        if let item = viewModel.stockItem {
            imageView.image = UIImage(data: item.itemImage!)
            itemTitleTextField.text = item.itemTitle
            stockCountLabel.text = "\(item.itemCount) 개"
        } else {
            imageView.image = UIImage(systemName: "camera")
            itemTitleTextField.text = nil
            stockCountLabel.text = "1 개"
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
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray6
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true

        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        imageView.addGestureRecognizer(tapGesture)

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
        microphoneButton.addTarget(self, action: #selector(didTapMicrophoneButton), for: .touchUpInside)

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
        stockCountLabel.font = .systemFont(ofSize: 20, weight: .bold)

        NSLayoutConstraint.activate([
            stockCountLabel.topAnchor.constraint(equalTo: stockCountDescribeLabel.topAnchor),
            stockCountLabel.leadingAnchor.constraint(equalTo: stockCountDescribeLabel.trailingAnchor, constant: 24),
            stockCountLabel.widthAnchor.constraint(equalToConstant: 120),
            stockCountLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createStockStepper() {
        stockStepper.addTarget(self, action: #selector(didTapStepper), for: .valueChanged)

        NSLayoutConstraint.activate([
            stockStepper.topAnchor.constraint(equalTo: stockCountDescribeLabel.topAnchor, constant: 10),
            stockStepper.leadingAnchor.constraint(equalTo: stockCountLabel.trailingAnchor, constant: -36),
            stockStepper.widthAnchor.constraint(equalToConstant: 120),
            stockStepper.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

// MARK: - Save Button Method

extension StockCreateVC {
    func createSaveButton() {
        saveButton.setTitle("저장", for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.backgroundColor = .systemBlue
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: stockCountDescribeLabel.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 180),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
        ])
    }

    @objc func didTapSaveButton(_ sender: UIButton) {
        guard let title = itemTitleTextField.text else { return }
        guard let imageData = imageView.image?.pngData() else { return }

        if viewModel.actionTag == 1 {
            // Create
            if let imageData = imageView.image?.pngData() {
                if imageView.image?.isSymbolImage == true {
                    viewModel.addStockItem(title, UIImage(named: "DuckBlankImage")!.pngData()!, Int64(stockStepper.value), viewModel.selectedStockCategory!)
                } else {
                    viewModel.addStockItem(title, imageData, Int64(stockStepper.value), viewModel.selectedStockCategory!)
                }
            }
            navigationController?.popViewController(animated: true)
        } else {
            // Update
            if let item = viewModel.stockItem {
                viewModel.updateStockItem(stockItem: item, newTitle: title, newImage: imageData, newCount: Int(stockStepper.value), selectedCategory: viewModel.selectedStockCategory!)

                let view = navigationController?.viewControllers as [UIViewController]

                navigationController?.popToViewController(view[1], animated: true)
            }
        }
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

// MARK: - Stepper Method

extension StockCreateVC {
    @objc func didTapStepper(_ sender: UIStepper) {
        stockCountLabel.text = "\(Int(stockStepper.value)) 개"
    }
}

// MARK: - MicrophoneButton Method

extension StockCreateVC {
    @objc func didTapMicrophoneButton(_ sender: UIButton) {
        print("#### \(#function)")
        itemTitleTextField.text = nil
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold) // 이미지 크기 조절
        let image = UIImage(systemName: "mic.fill", withConfiguration: configuration)
        microphoneButton.setImage(image, for: .normal)
        microphoneButton.imageView?.tintColor = .white
        microphoneButton.backgroundColor = .red

        if viewModel.sstService.audioEngine.isRunning {
            viewModel.sstService.audioEngine.stop()
            viewModel.sstService.recognitionRequest?.endAudio()
            microphoneButton.isEnabled = false

        } else {
            viewModel.sstService.startRecording { [weak self] str in
                self?.itemTitleTextField.text = str
            } stopHandler: { [weak self] isStop in
                self?.microphoneButton.isEnabled = isStop
            } placeHandler: { [weak self] str in
                self?.itemTitleTextField.text = str
            }

            let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold) // 이미지 크기 조절
            let image = UIImage(systemName: "mic.fill", withConfiguration: configuration)
            microphoneButton.setImage(image, for: .normal)
            microphoneButton.imageView?.tintColor = .red
            microphoneButton.backgroundColor = .white
        }
    }
}

// MARK: - ImageView Tap Gesture Method

extension StockCreateVC {
    @objc func didTapImageView(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true

        present(picker, animated: false)
    }
}

extension StockCreateVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        print("이미지 선택")
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) { () in
            // 이미지를 이미지 뷰에 표시
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imageView.image = img
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("#### 취소 버튼 눌름")

        dismiss(animated: false) { () in
            // 알림 창 호출
            let alert = UIAlertController(title: "", message: "사진 촬영이 취소되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: true)
        }
    }
}

// MARK: - SFSpeechRecognizerDelegate

extension StockCreateVC: SFSpeechRecognizerDelegate {
    // 음성 인식기의 사용 가능 상태가 변경될 때 호출됩니다.
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            // True
            microphoneButton.isEnabled = true
        } else {
            // False
            microphoneButton.isEnabled = false
        }
    }
}

// MARK: - Hide Keyboard When Tapped Around

extension StockCreateVC {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ExpirationCreateVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
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
// struct StockCreateVC_Preview: PreviewProvider {
//    static var previews: some View {
//        StockCreateVC().toPreview()
//    }
// }
// #endif
