//
//  ChartViewModel.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 13/05/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import Foundation
import Bond

import UIKit

class ChartViewModel {
    var chartIsHidden = Dynamic<Bool>(true)
    
    @IBOutlet weak var yesWidth: NSLayoutConstraint!
    @IBOutlet weak var noWidth: NSLayoutConstraint!
    
    @IBOutlet weak var yesCountLabel: UILabel!
    @IBOutlet weak var noCountLabel: UILabel!
    @IBOutlet weak var skippedCountLabel: UILabel!
    
    
    
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
    
    func updateAnswerCount(yes: Double, no: Double, skipped: Double){
        self.yesCountLabel.text = "\(Int(yes))"
        self.noCountLabel.text = "\(Int(no))"
        self.skippedCountLabel.text = "\(Int(skipped))"
    }
    func resetCounts(){
        self.yesCountLabel.text = "0"
        self.noCountLabel.text = "0"
        self.skippedCountLabel.text = "0"
    }
}


extension NSLayoutConstraint{
    func withMultiplier(newMultiplier: CGFloat) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: firstItem, attribute: firstAttribute, relatedBy: relation, toItem: secondItem, attribute: secondAttribute, multiplier: newMultiplier, constant: constant)
    }
}