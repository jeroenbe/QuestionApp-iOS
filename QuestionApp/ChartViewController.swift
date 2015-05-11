//
//  ChartViewController.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 07/05/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {
    
    //IBOutlet For BarChart
    @IBOutlet weak var yesHeight: NSLayoutConstraint!
    @IBOutlet weak var noHeight: NSLayoutConstraint!
    @IBOutlet weak var skippedHeight: NSLayoutConstraint!
    
    @IBOutlet weak var barViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var barView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func generateChart(yes: Double, no: Double, skipped: Double){
        var total = yes + no + skipped
        
        self.yesHeight.constant = CGFloat((yes/total)*Double(self.barViewHeight.constant))
        self.noHeight.constant = CGFloat((no/total)*Double(self.barViewHeight.constant))
        self.skippedHeight.constant = CGFloat((skipped/total)*Double(self.barViewHeight.constant))
        
        //self.noXAlign.constant = (self.yesWidth.constant < 276) ? self.yesXAlign.constant - self.yesWidth.constant : (self.yesWidth.constant - 276)*(-1)
        
        //var yesNoWidth = self.yesWidth.constant + self.noWidth.constant
        //self.skippedXAlign.constant = (yesNoWidth < 276) ? yesNoWidth : (yesNoWidth - 276)*(-1)
        
        
        
        self.barView.needsUpdateConstraints()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
