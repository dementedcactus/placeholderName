//
//  CalendarView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/20/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class CalenderView: UIView, MonthViewDelegate {
    
    private var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    private var currentMonthIndex: Int = 0
    private var currentYear: Int = 0
    private var presentMonthIndex = 0
    private var presentYear = 0
    private var todaysDate = 0
    private var firstWeekDayOfMonth = 0   //(Sunday-Saturday 1-7)
    
    lazy var monthView: MonthView = {
        let cv = MonthView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var weeksView: WeekdaysView = {
        let wv = WeekdaysView()
        wv.translatesAutoresizingMaskIntoConstraints = false
        return wv
    }()
    
    lazy var monthCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let mCV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        mCV.showsHorizontalScrollIndicator = false
        mCV.translatesAutoresizingMaskIntoConstraints=false
        mCV.backgroundColor = UIColor.clear
        mCV.allowsMultipleSelection = false
        return mCV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(theme: Stylesheet.MyTheme) {
        self.init()
        if theme == .Dark {
            Style.darkTheme()
        } else {
            Style.lightTheme()
        }
        commonInit()
    }
    
    public func changeTheme() {
        monthCollectionView.reloadData()
        monthView.nameLabel.textColor = Style.monthViewLabelColor
        monthView.rightButton.setTitleColor(Style.monthViewRightButtonColor, for: .normal)
        monthView.leftButton.setTitleColor(Style.monthviewLeftButtonColor, for: .normal)
        
        for i in 0..<7 {
            (weeksView.daysStackView.subviews[i] as! UILabel).textColor = Style.weekdaysLabelColor
        }
    }
    
    private func commonInit() {
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth = getFirstWeekDay()
        
        // For leap years, make february 29 days
        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numOfDaysInMonth[currentMonthIndex-1] = 29
        }
        
        presentMonthIndex = currentMonthIndex
        presentYear = currentYear
        
        setupViews()
        
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
        monthCollectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: "DateCell")
    }
    
    private func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        
        return day
    }
    
    public func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex = monthIndex + 1
        currentYear = year
        
        // for leap year, make february 29 days
        if monthIndex == 1 {
            if currentYear % 4 == 0 {
                numOfDaysInMonth[monthIndex] = 29
            } else {
                numOfDaysInMonth[monthIndex] = 28
            }
        }
        
        firstWeekDayOfMonth = getFirstWeekDay()
        
        monthCollectionView.reloadData()
        
        monthView.leftButton.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
    }
    
    private func setupViews() {
        //MonthView
        addSubview(monthView)
        monthView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        monthView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        monthView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        monthView.monthToDisplayDelegate = self
        
        //WeeksView
        addSubview(weeksView)
        weeksView.topAnchor.constraint(equalTo: monthView.bottomAnchor).isActive = true
        weeksView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        weeksView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        weeksView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //MonthCollectionView
        addSubview(monthCollectionView)
        monthCollectionView.topAnchor.constraint(equalTo: weeksView.bottomAnchor, constant: 0).isActive = true
        monthCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        monthCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        monthCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension CalenderView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = Stylesheet.Colors.DarkRed
        let label = cell?.subviews[1] as! UILabel
        label.textColor = UIColor.white
        let calcDate = indexPath.row - firstWeekDayOfMonth + 2 // Use this math to recreate the date when clicking on a cell.
        var twoDigitMonth: String {
            if String(currentMonthIndex).count == 1 {
                return "0"+String(currentMonthIndex)
            } else {
                return String(currentMonthIndex)
            }
        }
        
        print("\(twoDigitMonth)-\(calcDate)-\(currentYear)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.clear
        let lb = cell?.subviews[1] as! UILabel
        lb.textColor = Style.activeCellLabelColor
    }
}
extension CalenderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfDaysInMonth[currentMonthIndex - 1] + firstWeekDayOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = .clear
        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden = true
        } else {
            let calcDate = indexPath.row - firstWeekDayOfMonth + 2
            cell.isHidden = false
            cell.dateLabel.text = "\(calcDate)"
            if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                cell.isUserInteractionEnabled = false
                cell.dateLabel.textColor = UIColor.lightGray
            } else {
                cell.isUserInteractionEnabled = true
                cell.dateLabel.textColor = Style.activeCellLabelColor
            }
        }
        return cell
    }
}

extension CalenderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/7 - 8
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

extension Date {
    // To get first day of the month
    public var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    public var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}

extension String {
    // To get date from string
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    public var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}

