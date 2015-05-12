//
//  ChartViewController.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 07/05/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {
    @IBOutlet weak var yesWidth: NSLayoutConstraint!
    @IBOutlet weak var noWidth: NSLayoutConstraint!

    @IBOutlet weak var yesCountLabel: UILabel!
    @IBOutlet weak var noCountLabel: UILabel!
    @IBOutlet weak var skippedCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func generateChart(yes: Double, no: Double, skipped: Double){
        self.updateAnswerCount(yes, no: no, skipped: skipped)
        
        var total = yes + no + skipped
        var newYesWidth = self.yesWidth.withMultiplier(CGFloat(yes/total))
        var newNoWidth = self.noWidth.withMultiplier(CGFloat(no/total))
        
        
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.45){
            self.view.removeConstraints([self.yesWidth, self.noWidth])
            self.view.addConstraints([newYesWidth, newNoWidth])
            (self.yesWidth, self.noWidth) = (newYesWidth, newNoWidth)
            self.view.layoutIfNeeded()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateAnswerCount(yes: Double, no: Double, skipped: Double){
        self.yesCountLabel.text = "\(Int(yes))"
        println("\(Int(yes))")
        self.noCountLabel.text = "\(Int(no))"
        self.skippedCountLabel.text = "\(Int(skipped))"
    }
    func resetCounts(){
        self.yesCountLabel.text = "0"
        self.noCountLabel.text = "0"
        self.skippedCountLabel.text = "0"
    }
    func enableGraph(){
        
        self.view.hidden = false
    }
    func disableGraph(){
        self.view.hidden = true
        self.resetCounts()
    }
}


extension NSLayoutConstraint{
    func withMultiplier(newMultiplier: CGFloat) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: firstItem, attribute: firstAttribute, relatedBy: relation, toItem: secondItem, attribute: secondAttribute, multiplier: newMultiplier, constant: constant)
    }
}
