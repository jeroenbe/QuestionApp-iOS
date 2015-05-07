//
//  ChartViewController.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 07/05/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {


    @IBOutlet weak var helloWorldLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.helloWorldLabel.text = "hello world!"
        // Do any additional setup after loading the view.
    }
    
    func generateChart(yes: Int, no: Int, skipped: Int){
        //TODO
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
