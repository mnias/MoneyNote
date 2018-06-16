//
//  ViewController.swift
//  MoneyNote
//
//  Created by gyeong hawn Park on 2018. 6. 15..
//  Copyright © 2018년 gyeong hawn Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var spendList: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func choiceSpendOrSave(_ sender: Any) {
        let popup = UINib(nibName: "PopupView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        
        popup.backgroundColor = UIColor(white: 0.3, alpha: 0.9)
        
        self.view.addSubview(popup)
        
    }
    
}

