//
//  ExpirationDateVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/13/23.
//

import UIKit

class ExpirationCalendarVC: UIViewController {
    var selectedDate: DateComponents? = nil

    // 달력 선언
    let dateView: UICalendarView = {
        let view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false

        // 달력 커스텀을 위해 설정해 주어야 하는 속성
        view.wantsDateDecorations = true

        return view
    }()

    deinit {
        print("Deinitialized ExpirationDateVC")
    }
}

// MARK: - View Life Cycle

extension ExpirationCalendarVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "유통기한"
        setUpUI()
    }
}

// MARK: - Setting Up UI

extension ExpirationCalendarVC {
    func setUpUI() {
        view.backgroundColor = .white
        addView()

        createDateView()
        createAddButton()

        setCalendar()
        reloadDateView(date: Date())
    }

    func addView() {
        view.addSubview(dateView)
    }
}

// MARK: - Confirm UI

extension ExpirationCalendarVC {
    func createDateView() {
        let dateViewConstraints = [
            dateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
        ]

        NSLayoutConstraint.activate(dateViewConstraints)
    }
}

// MARK: - DateView Method

extension ExpirationCalendarVC {
    func setCalendar() {
        dateView.delegate = self
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateView.selectionBehavior = dateSelection
    }

    func reloadDateView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        dateView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
}

// MARK: - UIBarButtonItem Method

extension ExpirationCalendarVC {
    // Create Add NavigationItem
    func createAddButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        tabBarController?.navigationItem.rightBarButtonItem = button
    }

    @objc func didTapAddButton(_ sender: UIBarButtonItem) {
        let vc = ExpirationCreateVC()
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICalendarViewDelegate && UICalendarSelectionSingleDateDelegate

extension ExpirationCalendarVC: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    // UICalendarView
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        let currentDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        if currentDateComponents == dateComponents {
            return .customView {
                let view = UIView()
                view.layer.cornerRadius = 10 // 원의 반지름 설정
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = .red
                return view
            }
        }

        if let selectedDate = selectedDate, selectedDate == dateComponents {
//            return .customView {
//                let label = UILabel()
//                label.text = "🐶"
//                label.textAlignment = .center
//                return label
//            }
        }
        return nil
    }

    // 달력에서 날짜 선택했을 경우
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        reloadDateView(date: Calendar.current.date(from: dateComponents!))
        print("#### \(Calendar.current.date(from: dateComponents!))")

        let vc = ExpirationListVC()
        guard let dateComponent = dateComponents else { return }
        let today = Calendar.current.date(from: dateComponent)
        present(vc, animated: true)
    }
}
