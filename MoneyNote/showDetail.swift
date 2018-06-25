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
    @IBOutlet weak var lblpigName: UILabel!
    
    @IBOutlet weak var icon: UIButton!
    @IBOutlet weak var lbliconName: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var row: UILabel!
    
    //@IBOutlet weak var changeIcon: UIView!
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
        self.price.text = String(self.moneyNoteInfo!.price) // 금액
        let btnPigImage = UIImage(named: String(self.moneyNoteInfo!.spendorsave)) // 돼지아이콘
        lblpigName.text = self.moneyNoteInfo!.spendorsave // 안보이지만 돼지 아이콘의 이름이 필요하여 만듬
        self.spendPig.setBackgroundImage(btnPigImage, for: .normal)
        
        self.contentText.text = self.moneyNoteInfo!.contents // 내용
        let btnIconImage = UIImage(named: self.moneyNoteInfo!.icon)
        self.icon.setBackgroundImage(btnIconImage, for: .normal)
        lbliconName.text = self.moneyNoteInfo!.icon // 안보이지만 아이콘의 이름이 필요하여 만듬
        //self.icon.setImage(btnIconImage, for: UIControlState.normal)
        self.row.text = String(self.moneyNoteInfo!.row)
        self.date.text = self.moneyNoteInfo!.date
        print(movedRow)
        
        
    }
    @IBAction func updateNote(_ sender: Any) {
        let create = MoneyNoteDAO()
        ///
        
        
        
        ///
        let confirmOrFail = create.update(content: self.contentText.text!, icon: lbliconName.text!, spendorsave: lblpigName.text!, date: date.text!, price: Int(price.text!), row: Int(row.text!))
        
        if confirmOrFail {
            // 알림창
            let alert = UIAlertController(title: "노트를 수정하시겠습니까 ? ", message: nil, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .default) 
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
            self.present(alert, animated: true)
            
            print("성공하였습니다.")
            //backToMain(UIStoryboardSegue)
        } else {
            // 알림창
            let alert = UIAlertController(title: "노트 작성 실패", message: nil, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .cancel)
            
            alert.addAction(ok)
            
            self.present(alert, animated: true)
            
            print("실패하였습니다.")
        }
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
        lbliconName.text = sender.currentTitle
        let changedIcon = UIImage(named: iconName!)
        self.icon.setBackgroundImage(changedIcon, for: .normal)
    }
    
    // 돼지 아이콘 변경
    var pigName: String?
    @IBAction func changePig(_ sender: UIButton) {
        let pigName = sender.currentTitle
        //print(pigName!)
        lblpigName.text = sender.currentTitle
        let changedIcon = UIImage(named: pigName!)
        self.spendPig.setBackgroundImage(changedIcon, for: .normal)
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
