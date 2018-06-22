//
//  showDetail.swift
//  MoneyNote
//
//  Created by gyeong hawn Park on 2018. 6. 18..
//  Copyright © 2018년 gyeong hawn Park. All rights reserved.
//

import UIKit

class showDetail: UIViewController, UITextViewDelegate {

    @IBOutlet weak var price: UITextView!
    
    @IBOutlet weak var contentText: UITextView!
    
    @IBOutlet weak var spendPig: UIButton!
    
    @IBOutlet weak var icon: UIButton!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var row: UILabel!
    
    @IBOutlet weak var changeIcon: UIView!
    var para: MemoData?
    
    typealias showdetail = (row: Int, contents: String, icon: String, spendorsave: String, date: String, price: Int)
    var movedRow: Int!
    var movedDate: String!
    let thisMoneyNoteDAO = MoneyNoteDAO()
    
    var moneyNoteInfo: showdetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentText.delegate = self
        price.delegate = self
        
        self.moneyNoteInfo = self.thisMoneyNoteDAO.get(row: movedRow, date: movedDate)
        self.price.text = String(self.moneyNoteInfo!.price)
        let btnPigImage = UIImage(named: String(self.moneyNoteInfo!.spendorsave))
        self.spendPig.setBackgroundImage(btnPigImage, for: .normal)
        self.contentText.text = self.moneyNoteInfo!.contents
        let btnIconImage = UIImage(named: self.moneyNoteInfo!.icon)
        self.icon.setBackgroundImage(btnIconImage, for: .normal)
        //self.icon.setImage(btnIconImage, for: UIControlState.normal)
        self.row.text = String(self.moneyNoteInfo!.row)
        self.date.text = self.moneyNoteInfo!.date
        print(movedRow)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 밑에서 아이콘 올라오기
    @IBOutlet weak var changeIconConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var changePig: NSLayoutConstraint!
    
    var changeIconMenu = false
    
    var changePigMenu = false
    
    @IBAction func upAndDownChangeIcon(_ sender: UIButton) {
        if changeIconMenu {
            self.changeIconConstraint.constant = 200
        } else {
            self.changeIconConstraint.constant = 0
            UIView.animate(withDuration: 0.3){
                self.view.layoutIfNeeded()
            }
        }
        changeIconMenu = !changeIconMenu
    }
    
    @IBAction func upAndDownPig(_ sender: UIButton) {
        if changePigMenu {
            self.changePig.constant = -375
        } else {
            self.changePig.constant = 0
            UIView.animate(withDuration: 0.3){
                self.view.layoutIfNeeded()
            }
        }
        changePigMenu = !changePigMenu
    }
    
    // 아이콘 변경
    var iconName: String?
    @IBAction func chagneIcon(_ sender: UIButton) {
        let iconName = sender.currentTitle
        print(iconName!)
        
        let changedIcon = UIImage(named: iconName!)
        self.icon.setBackgroundImage(changedIcon, for: .normal)
    }
    
    // 돼지 아이콘 변경
    var pigName: String?
    @IBAction func changePig(_ sender: UIButton) {
        let pigName = sender.currentTitle
        //print(pigName!)
        
        let changedIcon = UIImage(named: pigName!)
        self.icon.setBackgroundImage(changedIcon, for: .normal)
    }
    
    
    
    // 메인화면으로 이동
    @IBAction func backToMain(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //override func textView
    
    // MARK: 키보드 관련
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("DidBeginEditing")
        self.view.frame.origin.y = -150
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("DidBeginEnd")
        self.view.frame.origin.y = 0
    }
    
    
//    // 키보드 나타날때 화면이 위로
//    func keyboardWillShow(_ sender: Notification) {
//        self.view.frame.origin.y = -150 // Move view 150 points upward
//    }
//
//    // 키보드 리턴버튼 누를 시 키보드 사라짐
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//
    // 화면 다른곳 터치하면 키보드 사라짐
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
//
//    // 화면 높이 원상복귀
//    func keyboardWillHide(_ sender: Notification) {
//        self.view.frame.origin.y = 0 // Move view to original position
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
