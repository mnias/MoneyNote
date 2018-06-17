//
//  ViewController.swift
//  MoneyNote
//
//  Created by gyeong hawn Park on 2018. 6. 15..
//  Copyright © 2018년 gyeong hawn Park. All rights reserved.
//

import UIKit
import PieCharts

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var spendList: UITableView!

    @IBOutlet weak var pieChart: PieChart!
    
    
    // 파이 차트 그리기
    func drawingGraph() {

        pieChart.models = [
            PieSliceModel(value: 2, color: UIColor.yellow),
            PieSliceModel(value: 3, color: UIColor.blue),
            PieSliceModel(value: 1, color: UIColor.green)
        ]
        pieChart.insertSlice(index: 2, model: PieSliceModel(value: 2, color: UIColor.black))
        
        // 원 내부 퍼센테이지 셋팅
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 55
        textLayerSettings.hideOnOverflow = true
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 10)
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        textLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
        }
        
        let textLayer = PiePlainTextLayer()
        //textLayer.animator = AlphaPieViewLayerAnimator()
        textLayer.settings = textLayerSettings
        
        // 외부 텍스트 표기
        let lineTextSettings = PieLineTextLayerSettings()
        lineTextSettings.label.textGenerator = {slice in
            return formatter.string(from: floor(slice.data.model.value) as NSNumber)!
        }
        let lineTextLayer = PieLineTextLayer()
        lineTextLayer.settings = lineTextSettings
        
        
        pieChart.layers = [textLayer, lineTextLayer]
        
        
        
    }
    
    let arr = ["A" , "B", "C", "D"]
    
    // 차트 예시 데이터
    let numbers = [1,2,3,4,5]
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        spendList.delegate = self
        spendList.dataSource = self
        drawingGraph()
        self.view.addSubview(pieChart)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // 작성하기 팝업 창
    @IBAction func choiceSpendOrSave(_ sender: Any) {
        let popup = UINib(nibName: "PopupView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        
        popup.backgroundColor = UIColor(white: 0.3, alpha: 0.9)
        
        self.view.addSubview(popup)
        
    }
    
    // 소비 리스트 테이블
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.spendList.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    
    
    // 차트 만들기
}