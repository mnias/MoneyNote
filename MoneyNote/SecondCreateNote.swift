//
//  SecondCreateNote.swift
//  MoneyNote
//
//  Created by gyeong hawn Park on 2018. 6. 18..
//  Copyright © 2018년 gyeong hawn Park. All rights reserved.
//

import UIKit

class SecondCreateNote: UIViewController {

    @IBOutlet weak var bigBack: UIView! // 제일 큰 배경, 색상용
    @IBOutlet weak var pigBack: UIView! // 소비,저축 아이콘 배경용
    @IBOutlet weak var iconBack: UIView! // 아이콘 배경용
    @IBOutlet weak var date: UIButton! // 날짜 표시, 클릭해서 달력 생성
    @IBOutlet weak var howMuch: UITextView! // 돈 표시
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToMain(_ segue: UIStoryboardSegue) {
         
    }
    
    @IBAction func createNote(_ sender: Any) {
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
