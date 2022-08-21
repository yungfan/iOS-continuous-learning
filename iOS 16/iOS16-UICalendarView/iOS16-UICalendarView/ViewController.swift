//
//  ViewController.swift
//  iOS16-UICalendarView
//
//  Created by 杨帆 on 2022/8/21.
//

import UIKit

class ViewController: UIViewController {
    // 创建UICalendarView
    lazy var calendarView: UICalendarView = {
        let calendarView = UICalendarView(frame: UIScreen.main.bounds)
        // 背景色
        calendarView.backgroundColor = .white
        // 渲染色
        calendarView.tintColor = .orange
        // 日历
        calendarView.calendar = Calendar(identifier: .chinese)
        // 本地化
        calendarView.locale = Locale(identifier: "zh_Hans_CN")
        // 字体
        calendarView.fontDesign = .rounded
        // 可选择的日期范围
        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        // 代理
        calendarView.delegate = self
        // 日期单选
        let singleDateSelection = UICalendarSelectionSingleDate(delegate: self)
        // 选择行为
        calendarView.selectionBehavior = singleDateSelection
        return calendarView
    }()

    // 用户选择的日期
    var selectedDate: DateComponents = DateComponents(year: 39, month: 6, day: 10) {
        didSet {
            // 格式化日期
            let formatDate = Calendar.current
                .date(from: selectedDate)?
                .formatted(.dateTime.year().month().day()
                    .locale(Locale(identifier: "zh_Hans_CN")))

            print(formatDate)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(calendarView)
    }
}

// MARK: - UICalendarSelectionSingleDateDelegate
extension ViewController: UICalendarSelectionSingleDateDelegate {
    // MARK: 选择某个日期
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selectedDate = dateComponents!
    }

    // MARK: 是否能够选择日期
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
}

// MARK: - UICalendarViewDelegate
extension ViewController: UICalendarViewDelegate {
    // MARK: 装饰视图，显示在日历数字下边区域
    func calendarView(_ calendarView: UICalendarView,
                      decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if dateComponents.year == selectedDate.year,
           dateComponents.month == selectedDate.month,
           dateComponents.day == selectedDate.day {
            return .customView {
                let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0))
                label.textColor = .red
                label.font = UIFont.systemFont(ofSize: 10.0)
                label.text = "今"
                return label
            }
        } else {
            return .default(color: .systemTeal)
        }
    }
}

