//
//  showDetail.swift
//  MoneyNote
//
//  Created by gyeong hawn Park on 2018. 6. 18..
//  Copyright © 2018년 gyeong hawn Park. All rights reserved.
//

import UIKit

class showDetail: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var price: UITextView!
    
    @IBOutlet weak var contentText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.price.delegate = self
//        self.contentText.delegate = self
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToMain(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    // MARK: 키보드 관련
    
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
