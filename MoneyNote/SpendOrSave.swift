//
//  SpendOrSave.swift
//  MoneyNote
//
//  Created by gyeong hawn Park on 2018. 6. 15..
//  Copyright © 2018년 gyeong hawn Park. All rights reserved.
//

import UIKit

class SpendOrSave: UIView {
    @IBOutlet var spend: UIView!
    
    @IBOutlet var save: UIView!
    
    @IBOutlet var myWallet: UIImageView!
    
    @IBAction func spend(_ sender: Any) {
        
    }
    
    @IBAction func save(_ sender: Any) {
        
    }
    
    @IBAction func close(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    func drag(control: UIControl, event: UIEvent) {
        if let center = event.allTouches?.first?.location(in: self.myWallet) {
            control.center = center
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
