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
    
    
    
    
    // MARK: - 파이 차트 그리기
//    func drawingGraph() {
//
//        pieChart.models = [
//            PieSliceModel(value: 2, color: UIColor.yellow),
//            PieSliceModel(value: 3, color: UIColor.blue),
//            PieSliceModel(value: 1, color: UIColor.green)
//        ]
//        pieChart.insertSlice(index: 2, model: PieSliceModel(value: 2, color: UIColor.black))
//
//        // 원 내부 퍼센테이지 셋팅
//        let textLayerSettings = PiePlainTextLayerSettings()
//        textLayerSettings.viewRadius = 55
//        textLayerSettings.hideOnOverflow = true
//        textLayerSettings.label.font = UIFont.systemFont(ofSize: 10)
//
//        let formatter = NumberFormatter()
//        formatter.maximumFractionDigits = 1
//        textLayerSettings.label.textGenerator = {slice in
//            return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
//        }
//
//        let textLayer = PiePlainTextLayer()
//        //textLayer.animator = AlphaPieViewLayerAnimator()
//        textLayer.settings = textLayerSettings
//
//        // 외부 텍스트 표기
//        let lineTextSettings = PieLineTextLayerSettings()
//        lineTextSettings.label.textGenerator = {slice in
//            return formatter.string(from: floor(slice.data.model.value) as NSNumber)!
//        }
//        let lineTextLayer = PieLineTextLayer()
//        lineTextLayer.settings = lineTextSettings
//
//
//        pieChart.layers = [textLayer, lineTextLayer]
//
//
//
//    }
    
    // 소비 테이블 예시 데이터
    let arr = ["A" , "B", "C", "D"]
    
    // 차트 예시 데이터
    let numbers = [1,2,3,4,5]
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.spendList.delegate = self
        self.spendList.dataSource = self
        
        self.calendar.delegate = self
        //drawingGraph()
        //self.view.addSubview(pieChart)
        calendar.appearance.borderRadius = 0
        
        makeLabelTextToday()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    
    
    // MARK: - 달력 설정 하루 전, 하루 뒤 이동
    
    var labelToday : NSDate?
    
    // 어제
    @IBAction func yesterday(_ sender: Any) {
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
        //print(self.calendar.selectedDate!)
    }
    
    // 내일
    @IBAction func tomorrow(_ sender: Any) {
        let nowDate = today.text!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 M월 d일"
        let changedDate = dateFormatter.date(from: nowDate)
        let tomorrow = NSDate(timeInterval: 60*60*24, since: changedDate!)
        
        let makeDate = DateFormatter()
        makeDate.dateFormat = "YYYY년 M월 d일"
        let dateString = makeDate.string(from: tomorrow as Date)
        self.today.text = dateString
    }
    
    // 날짜 선택 시
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let makeDate = DateFormatter()
        makeDate.dateFormat = "YYYY년 M월 d일"
        let dateString = makeDate.string(from: date as Date)
        self.today.text = dateString
        
        let now = NSDate(timeInterval: 60*60*9, since: calendar.selectedDate!)
        print(monthPosition.rawValue)
        print(monthPosition.hashValue)
        print(self.calendar.selectedDate!)
        print(now)
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
//        let popup = UINib(nibName: "PopupView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
//
//        popup.backgroundColor = UIColor(white: 0.3, alpha: 0.9)
//
//        self.view.addSubview(popup)
        guard let moveToFirstCreateNote = self.storyboard?.instantiateViewController(withIdentifier: "firstCreateNote") else {
            return
        }
        
        moveToFirstCreateNote.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        self.present(moveToFirstCreateNote, animated: true)
    }
    
    // MARK: - 소비 리스트 테이블
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.spendList.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 테이블 선택 시 상세화면으로
        
        guard let moveToShowDetail = self.storyboard?.instantiateViewController(withIdentifier: "showDetail") else {
            return
        }
        
        moveToShowDetail.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        self.present(moveToShowDetail, animated: true)
        
    }
    
    
}
