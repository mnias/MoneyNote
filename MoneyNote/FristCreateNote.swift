//
//  CreateViewController.swift
//  MoneyNote
//
//  Created by gyeong hawn Park on 2018. 6. 18..
//  Copyright © 2018년 gyeong hawn Park. All rights reserved.
//

import UIKit

class FirstCreateNote: UIViewController {

    @IBAction func backToMain(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // bigBackView.layer.cornerRadius = bigBackView.frame.width/8
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        
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
