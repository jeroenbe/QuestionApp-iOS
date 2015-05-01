//
//  FirstViewController.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 29/04/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import UIKit
import Meteor

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var subscriptionLoader = SubscriptionLoader();
        
        if Meteor.connected {
            let question: AnyObject! = Meteor.callMethodWithName("getUnreadQuestion", parameters: []){
                
            }();
            subscriptionLoader.addSubscriptionWithName(name: "questionByID", parameters: );
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

