//
//  SpendOrSave.swift
//  MoneyNote
//
//  Created by gyeong hawn Park on 2018. 6. 15..
//  Copyright © 2018년 gyeong hawn Park. All rights reserved.
//

import UIKit
//class Inherit: UIViewController {
//    var inherit = self
//}
//class NeedUIView: UIView {
//
//}
class SpendOrSave: UIView {
//    var inherit: Inherit
//    init(inherit: UIViewController) {
//        super.init()
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    @IBOutlet var spend: UIView!
    
    @IBOutlet var save: UIView!
    
    @IBOutlet weak var wallet: UIButton!
    
    
    @IBAction func spend(_ sender: Any) {
        
        let storyboard =  UIStoryboard(name: "Main", bundle: Bundle.main)
        let moveToShowDetail = storyboard.instantiateViewController(withIdentifier: "showDetail")

        moveToShowDetail.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

        moveToShowDetail.present(moveToShowDetail, animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
//        guard let moveToShowDetail = inherit.self.storyboard?.instantiateViewController(withIdentifier: "showDetail") else {
//            return
//        }
//
//        moveToShowDetail.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//
//        inherit.self.present(moveToShowDetail, animated: true)
    }
    
    @IBAction func touchDragEnter(_ sender: Any) {
        NSLog("Touch Drag Enter!")
    }
    
    @IBAction func spendOrSave(_ sender: Any) {
        NSLog("Touch Drag Enter!")
    }
    
    @IBAction func tde(_ sender: Any) {
        NSLog("Touch Drag Exit!")
    }
    
    @IBAction func tdi(_ sender: Any) {
        
        NSLog("Touch Drag Inside!")
    }
    
    @IBAction func tdo(_ sender: Any) {
        NSLog("Touch Drag Outside!")
    }
    
    
    
    //닫기 버튼
    @IBAction func close(_ sender: Any) {
        //self.removeFromSuperview()
    }
    
    
    
    
    
    
    func drag(control: UIControl, event: UIEvent) {
        if let center = event.allTouches?.first?.location(in: self.wallet) {
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
