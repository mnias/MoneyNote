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
    @IBOutlet weak var howMuch: UITextView! // 돈 표시
    
    @IBOutlet weak var pig: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var content: UITextView!
    
    var movedPigName: String!
    var movedPrice: Int!
    var movedDate: String!
    var iconName: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(movedPigName!)
        self.pig.image = UIImage(named: movedPigName)
        if( movedPrice == nil ) {
            self.howMuch.text = String(0)
        } else {
            self.howMuch.text = String(movedPrice)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func X(_ sender: Any) {
        self.performSegue(withIdentifier: "backToMainPage", sender: self)
    }
    
    @IBAction func createNote(_ sender: Any) {
        guard let _ = iconName else {
            print("아이콘을 선택해주세요.")
            // 얼럿 창 띄우기
            return
        }
        print("bbbb")
        let create = MoneyNoteDAO()
        let confirmOrFail = create.create(content: self.content.text!, icon: self.iconName!, spendorsave: self.movedPigName!, date: movedDate!, price: movedPrice!)
        
        if confirmOrFail {
            // 알림창
            let alert = UIAlertController(title: "노트 작성 완료", message: nil, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .default) {
                (_) in
                self.performSegue(withIdentifier: "backToMainPage", sender: self)
            }
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
    
    // MARK: - 키보드 관련
    
    // 키보드 나타날때 화면이 위로
    func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    // 키보드 리턴버튼 누를 시 키보드 사라짐
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // 화면 다른곳 터치하면 키보드 사라짐
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // 화면 높이 원상복귀
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    // MARK: - 아이콘 버튼 클릭
    
    @IBAction func changeIcon(_ sender: UIButton) {
        let iconName = sender.currentTitle!
        print(iconName)
        self.iconName = iconName+".png"
        print(self.iconName!)
        self.icon.image = UIImage(named: iconName+".png")
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
