//
//  SalaryVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import UIKit

class SalaryVC: UIViewController {
    var viewModel: SalaryViewModel!

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemPink
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = true
        return scrollView
    }()

    // MARK: - 본 내용들이 들어가는 View

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemOrange
        return view
    }()

    // MARK: - 제목들

    let hourlyWageTitleLabel = CustomLabel(frame: .zero) // 시급 제목
    let workHoursTitleLabel = CustomLabel(frame: .zero) // 근로 시간 제목
    let numberOfWorkingDaysTitleLabel = CustomLabel(frame: .zero) // 근로일 수 제목

    // MARK: - 텍스트필드들

    let hourlWageTextField = CustomTextField(frame: .zero) // 시급 입력 텍스트필드
    let workHoursTextField = CustomTextField(frame: .zero) // 근로 시간 입력 텍스트 필드

    // MARK: - 근무일 수 담는 스택뷰

    let numberOfWorkingDaysStackView = CustomStackView(frame: .zero)

    // MARK: - 스택뷰에 들어갈 버튼들

    let sundayButton = CustomButton(frame: .zero)
    let mondayButton = CustomButton(frame: .zero)
    let tuesayButton = CustomButton(frame: .zero)
    let wednesdayButton = CustomButton(frame: .zero)
    let thursdayButton = CustomButton(frame: .zero)
    let fridayButton = CustomButton(frame: .zero)
    let saturdayButton = CustomButton(frame: .zero)

    // MARK: - 계산 결과 출력 제목 라벨들

    let resultDailyWageLabel = CustomLabel(frame: .zero) // 일급 계산 결과
    let resultWeeklyWageLabel = CustomLabel(frame: .zero) // 주급 계산 결과
    let resultMonthlyWageLabel = CustomLabel(frame: .zero) // 월급 계산 결과

    // MARK: - 계산 결과 출력 텍스트필드들

    let resultDailyTextField = CustomTextField(frame: .zero) // 일급 계산 결과 출력
    let resultWeeklyTextField = CustomTextField(frame: .zero) // 주급 계산 결과 출력
    let resultMonthlyTextField = CustomTextField(frame: .zero) // 월급 계산 결과 출력

    // MARK: - 계산 하기 버튼

    let calculatorButton = CustomButton(frame: .zero) // 계산 버튼

    // MARK: - 계산

    deinit {
        print("Deinitialized SalaryVC")
    }
}

// MARK: - View Life Cycle

extension SalaryVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "시급 계산기"
    }
}

// MARK: - 전체 UI

extension SalaryVC {
    func setUpUI() {
        addView()

        createScrollView()
        createContentView()

        createHourlyWageTitleLabel()
        createHourlyWageTextField()
        createWorkHoursTitleLabel()
        createWorkHoursTextField()
        createNumberOfWorkingDaysTitleLabel()

        createNumberOfWorkingDaysStackView()
        createDayButtons()

        createResultDailyWageLabel()
        createResultDailyTextField()
        createResultWeeklyWageLabel()
        createResultWeeklyTextField()
        createResultMonthlyWageLabel()
        createResultMonthlyTextField()

        createCalulatorButton()

        createResetButton()
    }

    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

//        contentView.addSubview(hourlyWageTitleLabel)
//        contentView.addSubview(hourlWageTextField)
//        contentView.addSubview(workHoursTitleLabel)
//        contentView.addSubview(workHoursTextField)
//        contentView.addSubview(numberOfWorkingDaysTitleLabel)
//        contentView.addSubview(numberOfWorkingDaysStackView)

        [hourlyWageTitleLabel, hourlWageTextField, workHoursTitleLabel, workHoursTextField, numberOfWorkingDaysTitleLabel, numberOfWorkingDaysStackView].forEach {
            contentView.addSubview($0)
        }

        [sundayButton, mondayButton, tuesayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton].forEach { numberOfWorkingDaysStackView.addArrangedSubview($0) }

        [resultDailyWageLabel, resultWeeklyWageLabel, resultMonthlyWageLabel, resultDailyTextField, resultWeeklyTextField, resultMonthlyTextField, calculatorButton].forEach {
            contentView.addSubview($0)
        }

//        contentView.addSubview(resultDailyWageLabel)
//        contentView.addSubview(resultWeeklyWageLabel)
//        contentView.addSubview(resultMonthlyWageLabel)
//
//        contentView.addSubview(resultDailyTextField)
//        contentView.addSubview(resultWeeklyTextField)
//        contentView.addSubview(resultMonthlyTextField)
    }
}

// MARK: - UI 작업

extension SalaryVC {
    func createScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func createContentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // 너비 제약 조건 추가
//            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 1400), // 높이 제약 조건 추가 (필요에 따라 조절)
        ])
    }

    func createHourlyWageTitleLabel() {
        hourlyWageTitleLabel.text = "시급"
        hourlyWageTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            hourlyWageTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            hourlyWageTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            hourlyWageTitleLabel.widthAnchor.constraint(equalToConstant: 120),
            hourlyWageTitleLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createHourlyWageTextField() {
        hourlWageTextField.placeholder = "시급을 입력해주세요"
        hourlWageTextField.backgroundColor = .white
        hourlWageTextField.layer.cornerRadius = 10
        hourlWageTextField.addLeftPadding()

        NSLayoutConstraint.activate([
            hourlWageTextField.topAnchor.constraint(equalTo: hourlyWageTitleLabel.bottomAnchor, constant: 10),
            hourlWageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            hourlWageTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hourlWageTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createWorkHoursTitleLabel() {
        workHoursTitleLabel.text = "근로 시간"
        workHoursTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            workHoursTitleLabel.topAnchor.constraint(equalTo: hourlWageTextField.bottomAnchor, constant: 24),
            workHoursTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            workHoursTitleLabel.widthAnchor.constraint(equalToConstant: 120),
            workHoursTitleLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createWorkHoursTextField() {
        workHoursTextField.placeholder = "하루 근로 시간을 입력해주세요"
        workHoursTextField.backgroundColor = .white
        workHoursTextField.layer.cornerRadius = 10
        workHoursTextField.addLeftPadding()

        NSLayoutConstraint.activate([
            workHoursTextField.topAnchor.constraint(equalTo: workHoursTitleLabel.bottomAnchor, constant: 10),
            workHoursTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            workHoursTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            workHoursTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createNumberOfWorkingDaysTitleLabel() {
        numberOfWorkingDaysTitleLabel.text = "근무일 수"
        numberOfWorkingDaysTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            numberOfWorkingDaysTitleLabel.topAnchor.constraint(equalTo: workHoursTextField.bottomAnchor, constant: 24),
            numberOfWorkingDaysTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            numberOfWorkingDaysTitleLabel.widthAnchor.constraint(equalToConstant: 120),
            numberOfWorkingDaysTitleLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createNumberOfWorkingDaysStackView() {
        numberOfWorkingDaysStackView.axis = .horizontal
        numberOfWorkingDaysStackView.spacing = 4
        numberOfWorkingDaysStackView.distribution = .fillEqually
        numberOfWorkingDaysStackView.backgroundColor = .clear

        NSLayoutConstraint.activate([
            numberOfWorkingDaysStackView.topAnchor.constraint(equalTo: numberOfWorkingDaysTitleLabel.bottomAnchor, constant: 5),
            numberOfWorkingDaysStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            numberOfWorkingDaysStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24), // 추가된 제약 조건
            numberOfWorkingDaysStackView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createDayButtons() {
        let buttonWidth: CGFloat = 40 // 적절한 너비 값으로 변경

        // 일요일
        sundayButton.setTitle("일", for: .normal)
        sundayButton.backgroundColor = .red
        sundayButton.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            sundayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            sundayButton.heightAnchor.constraint(equalToConstant: 50),
        ])

        // 월요일
        mondayButton.setTitle("월", for: .normal)
        mondayButton.backgroundColor = .gray
        mondayButton.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            mondayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            mondayButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        // 화요일
        tuesayButton.setTitle("화", for: .normal)
        tuesayButton.backgroundColor = .gray
        tuesayButton.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            tuesayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            tuesayButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        // 수요일
        wednesdayButton.setTitle("수", for: .normal)
        wednesdayButton.backgroundColor = .gray
        wednesdayButton.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            wednesdayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            wednesdayButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        // 목요일
        thursdayButton.setTitle("목", for: .normal)
        thursdayButton.backgroundColor = .gray
        thursdayButton.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            thursdayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            thursdayButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        // 금요일
        fridayButton.setTitle("금", for: .normal)
        fridayButton.backgroundColor = .gray
        fridayButton.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            fridayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            fridayButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        // 토요일
        saturdayButton.setTitle("토", for: .normal)
        saturdayButton.backgroundColor = .blue
        saturdayButton.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            saturdayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            saturdayButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createResultDailyWageLabel() {
        resultDailyWageLabel.text = "나의 일급은?"
        resultDailyWageLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            resultDailyWageLabel.topAnchor.constraint(equalTo: numberOfWorkingDaysStackView.bottomAnchor, constant: 24),
            resultDailyWageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            resultDailyWageLabel.widthAnchor.constraint(equalToConstant: 200),
            resultDailyWageLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createResultDailyTextField() {
        resultDailyTextField.placeholder = "여기에 일급 결과가 출력됩니다."
        resultDailyTextField.backgroundColor = .white
        resultDailyTextField.layer.cornerRadius = 10
        resultDailyTextField.addLeftPadding()

        NSLayoutConstraint.activate([
            resultDailyTextField.topAnchor.constraint(equalTo: resultDailyWageLabel.bottomAnchor, constant: 24),
            resultDailyTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            resultDailyTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            resultDailyTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createResultWeeklyWageLabel() {
        resultWeeklyWageLabel.text = "나의 주급은?"
        resultWeeklyWageLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            resultWeeklyWageLabel.topAnchor.constraint(equalTo: resultDailyTextField.bottomAnchor, constant: 24),
            resultWeeklyWageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            resultWeeklyWageLabel.widthAnchor.constraint(equalToConstant: 200),
            resultWeeklyWageLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createResultWeeklyTextField() {
        resultWeeklyTextField.placeholder = "여기에 주급 결과가 출력됩니다."
        resultWeeklyTextField.backgroundColor = .white
        resultWeeklyTextField.layer.cornerRadius = 10
        resultWeeklyTextField.addLeftPadding()

        NSLayoutConstraint.activate([
            resultWeeklyTextField.topAnchor.constraint(equalTo: resultWeeklyWageLabel.bottomAnchor, constant: 24),
            resultWeeklyTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            resultWeeklyTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            resultWeeklyTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createResultMonthlyWageLabel() {
        resultMonthlyWageLabel.text = "나의 월급은?"
        resultMonthlyWageLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            resultMonthlyWageLabel.topAnchor.constraint(equalTo: resultWeeklyTextField.bottomAnchor, constant: 24),
            resultMonthlyWageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            resultMonthlyWageLabel.widthAnchor.constraint(equalToConstant: 200),
            resultMonthlyWageLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createResultMonthlyTextField() {
        resultMonthlyTextField.placeholder = "여기에 월급 결과가 출력됩니다."
        resultMonthlyTextField.backgroundColor = .white
        resultMonthlyTextField.layer.cornerRadius = 10
        resultMonthlyTextField.addLeftPadding()

        NSLayoutConstraint.activate([
            resultMonthlyTextField.topAnchor.constraint(equalTo: resultMonthlyWageLabel.bottomAnchor, constant: 24),
            resultMonthlyTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            resultMonthlyTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            resultMonthlyTextField.heightAnchor.constraint(equalToConstant: 60),

        ])
    }

    func createCalulatorButton() {
        calculatorButton.setTitle("계산하기", for: .normal)
        calculatorButton.layer.cornerRadius = 10
        calculatorButton.backgroundColor = .red

        NSLayoutConstraint.activate([
            calculatorButton.topAnchor.constraint(equalTo: resultMonthlyTextField.bottomAnchor, constant: 34),
            calculatorButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            calculatorButton.widthAnchor.constraint(equalToConstant: 120),
            calculatorButton.heightAnchor.constraint(equalToConstant: 60),
            calculatorButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
        ])
    }
}

// MARK: - Reset Button

extension SalaryVC {
    // To-Do Stuff
    func createResetButton() {
        let resetButton = UIBarButtonItem(image: UIImage(systemName: "gobackward"), style: .plain, target: self, action: #selector(didTapRestButton))
        tabBarController?.navigationItem.rightBarButtonItem = resetButton
    }

    @objc func didTapRestButton(_ sender: UIBarButtonItem) {
        print("#### \(#function)")
    }
}

// MARK: - ViewModelInjectable

// 상위 TabBarVC에서 ViewModel 주입

extension SalaryVC: ViewModelInjectable {
    func injectViewModel(_ viewModelType: SalaryViewModel) {
        viewModel = viewModelType
    }
}

// MARK: - SWIFT UI PREVIEWS

#if DEBUG
import SwiftUI

@available(iOS 13, *)
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }

    func toPreview() -> some View {
        // inject self (the current view controller) for the preview
        Preview(viewController: self)
    }
}

@available(iOS 13.0, *)
struct SalaryVC_Preview: PreviewProvider {
    static var previews: some View {
        SalaryVC().toPreview()
    }
}
#endif
