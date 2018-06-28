//
//  ViewController.swift
//  MoneyNote
//
//  Created by gyeong hawn Park on 2018. 6. 15..
//  Copyright © 2018년 gyeong hawn Park. All rights reserved.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FSCalendarDelegate, FSCalendarDataSource  {
    
    @IBOutlet var spendList: UITableView!

    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var today: UILabel!
    
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var totalSpendMoney: UILabel! // 일간 지출
    @IBOutlet weak var totalMonthSpendMoney: UILabel! // 월간 지출
    
    // 데이터 소스용 변수
    var noteList: [(row: Int, contents: String, icon: String, spendorsave: String, date: String, price: Int)]!
    
    var noteList2: [(row: Int, contents: String, icon: String, spendorsave: String, date: String, price: Int, year: String, yearMonth: String)]!
    
    var moneyDAO = MoneyNoteDAO() // SQLite를 담당할 객체
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        makeLabelTextToday()
        self.spendList.delegate = self
        self.spendList.dataSource = self
        
        self.calendar.delegate = self
        calendar.appearance.borderRadius = 0
        // 오늘 날짜 표시
        
        
        
        print("Aa")
        print(today.text!)
        print("aA")
        self.noteList = self.moneyDAO.find(date: today.text!)
        //
        let yearMonthDate = needDate(date: today.text!)
        print(yearMonthDate.0)
        print(yearMonthDate.1)
        print(yearMonthDate.2)
        
        // 일간 지출
        totalSpendMoney.text = String(self.moneyDAO.getDailySpendTotal(date: yearMonthDate.2, spendorsave: "spendPig.png"))
        // 월간 지출
        totalMonthSpendMoney.text = String(self.moneyDAO.getMonthlySpendTotal(date: yearMonthDate.1,spendorsave: "spendPig.png"))
        
        // 월간 수입
        //totalMoney.text = String(self.moneyDAO.getMonthlySpendTotal(date: yearMonthDate.1,spendorsave: "savePig.png"))
        //let testData = self.moneyDAO.getALL()
        //print(testData)
        //self.totalMoney.text! = String(self.moneyDAO.findTotal())
        
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - 메인으로 돌아오기
    @IBAction func backToMainPage(_ segue: UIStoryboardSegue){
        
    }
    
    
    // MARK: - 달력 설정 하루 전, 하루 뒤 이동
    
    var labelToday : NSDate?
    
    // 어제
    @IBAction func yesterday(_ sender: Any) {
        let yearMonthDate = needDate(date: today.text!)
        let nowDate = today.text!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 M월 d일"
        let changedDate = dateFormatter.date(from: nowDate)
        let yesterday = NSDate(timeInterval: -60*60*24, since: changedDate!)
        
        let makeDate = DateFormatter()
        makeDate.dateFormat = "YYYY년 M월 d일"
        let dateString = makeDate.string(from: yesterday as Date)
        self.today.text = dateString
        calendar.reloadData()
        self.noteList = self.moneyDAO.find(date: today.text!)
        spendList.reloadData()
        // 일간 지출
        totalSpendMoney.text = String(self.moneyDAO.getDailySpendTotal(date: yearMonthDate.2, spendorsave: "spendPig.png"))
        // 월간 지출
        totalMonthSpendMoney.text = String(self.moneyDAO.getMonthlySpendTotal(date: yearMonthDate.1,spendorsave: "spendPig.png"))
        
        // 월간 수입
        totalMoney.text = String(self.moneyDAO.getMonthlySpendTotal(date: yearMonthDate.1,spendorsave: "savePig.png"))
        
        
    }
    
    // 내일
    @IBAction func tomorrow(_ sender: Any) {
        let yearMonthDate = needDate(date: today.text!)
        let nowDate = today.text!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 M월 d일"
        let changedDate = dateFormatter.date(from: nowDate)
        let tomorrow = NSDate(timeInterval: 60*60*24, since: changedDate!)
        
        let makeDate = DateFormatter()
        makeDate.dateFormat = "YYYY년 M월 d일"
        let dateString = makeDate.string(from: tomorrow as Date)
        self.today.text = dateString
        
        self.noteList = self.moneyDAO.find(date: today.text!)
        spendList.reloadData()
        // 일간 지출
        totalSpendMoney.text = String(self.moneyDAO.getDailySpendTotal(date: yearMonthDate.2, spendorsave: "spendPig.png"))
        // 월간 지출
        totalMonthSpendMoney.text = String(self.moneyDAO.getMonthlySpendTotal(date: yearMonthDate.1,spendorsave: "spendPig.png"))
        
        // 월간 수입
        totalMoney.text = String(self.moneyDAO.getMonthlySpendTotal(date: yearMonthDate.1,spendorsave: "savePig.png"))
        
        
    }
    
    // 날짜 선택 시
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //let yearMonthDate = needDate(date: today.text!)
        
        let makeDate = DateFormatter()
        makeDate.dateFormat = "YYYY년 M월 d일"
        let dateString = makeDate.string(from: date as Date)
        self.today.text = dateString
        
        let now = NSDate(timeInterval: 60*60*9, since: calendar.selectedDate!)
        //print(monthPosition.rawValue)
        //print(monthPosition.hashValue)
        //print(self.calendar.selectedDate!)
        print(now)
//        self.noteList = self.moneyDAO.find(date: today.text!)
//        spendList.reloadData()
//        // 일간 지출
//        totalSpendMoney.text = String(self.moneyDAO.getDailySpendTotal(date: yearMonthDate.2, spendorsave: "spendPig.png"))
//        // 월간 지출
//        totalMonthSpendMoney.text = String(self.moneyDAO.getMonthlySpendTotal(date: yearMonthDate.1,spendorsave: "spendPig.png"))
//
//        // 월간 수입
//        totalMoney.text = String(self.moneyDAO.getMonthlySpendTotal(date: yearMonthDate.1,spendorsave: "savePig.png"))
        
        reloadData()
        
    }
    
    
    // 메인화면에 오늘 날짜 표시
    func makeLabelTextToday() {
        labelToday = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 M월 d일"
        
        let dateString = dateFormatter.string(from: labelToday! as Date)
        self.today.text = dateString
        
    }
    
    // 날짜 형식 변환
    func changeDate(date: String) {
        let newDate = date.components(separatedBy: ["년","월","일"," "])
        var changedDate: String = ""
        
        changedDate.append(newDate[0])
        changedDate.append("-"+newDate[2])
        changedDate.append("-"+newDate[4])
        changedDate.append(" 00:00:00 +0000")
    }
    
    // 메인 Label 값을 날짜로 변경
    func stringToDate(_ str: String)->Date{
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd hh:mm:ss Z"
        return formatter.date(from: str)!
    }
    
    // MARK: - 작성하기
    @IBAction func choiceSpendOrSave(_ sender: Any) {
        
        guard let moveToFirstCreateNote = self.storyboard?.instantiateViewController(withIdentifier: "firstCreateNote") else {
            return
        }
        let movePara = moveToFirstCreateNote as! FirstCreateNote
        movePara.date = today.text!
        //print(movePara.date)
        
        moveToFirstCreateNote.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        self.present(moveToFirstCreateNote, animated: true)
    }
    
    // MARK: - 소비 리스트 테이블
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }

    // 일간 지출 변수
    var dailySpend: Int = 0
    var monthlySpend: Int = 0
    // 월간 지출 변수
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowData = self.noteList[indexPath.row]
        let cell = spendList.dequeueReusableCell(withIdentifier: "Note") as! NoteCell
        cell.spendPig.image = UIImage(named: rowData.spendorsave)
        cell.content.text = rowData.contents
        cell.price.text = String(rowData.price)
        cell.icon.image = UIImage(named: rowData.icon)

        return cell
    }
    
    // 테이블 선택했을때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let moveRow = self.noteList[indexPath.row].row
        let moveDate = self.noteList[indexPath.row].date
        guard let moveToShowDetail = self.storyboard?.instantiateViewController(withIdentifier: "showDetail") else {
            return
        }
        if let _moveToShowDetial = moveToShowDetail as? showDetail {
            _moveToShowDetial.movedRow = moveRow
            _moveToShowDetial.movedDate = moveDate
        }
        moveToShowDetail.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        self.present(moveToShowDetail, animated: true)
        
    }
    
    // 드래그하여 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let rowData = self.noteList[indexPath.row]
            if moneyDAO.remove(row: rowData.row) {
                
                self.noteList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                print("DB에서 삭제하였습니다.")
                reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    // MAKR: - 일,월,연간 지출을 위한 데이터 만들기
    typealias makingNeedDate = (String, String, String)
    func needDate(date: String) -> makingNeedDate {
        let a = date.components(separatedBy: " ")
        let year = a[0]
        var yearMonth: String = a[0]
        yearMonth.append(" ")
        yearMonth.append(a[1])
        let today = self.today.text!
        return (year, yearMonth, today)
    }
    
    func reloadData() {
        let yearMonthDate = needDate(date: today.text!)
        self.noteList = self.moneyDAO.find(date: today.text!)
        spendList.reloadData()
        // 일간 지출
        totalSpendMoney.text = String(self.moneyDAO.getDailySpendTotal(date: yearMonthDate.2, spendorsave: "spendPig.png"))
        // 월간 지출
        totalMonthSpendMoney.text = String(self.moneyDAO.getMonthlySpendTotal(date: yearMonthDate.1,spendorsave: "spendPig.png"))
        
        // 월간 수입
        totalMoney.text = String(self.moneyDAO.getMonthlySpendTotal(date: yearMonthDate.1,spendorsave: "savePig.png"))
    }
}
