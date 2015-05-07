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
    
    @IBOutlet weak var yesNoButton: UISegmentedControl!
    @IBOutlet weak var spinnerOnLoadQuestion: UIActivityIndicatorView!
    @IBOutlet weak var questionText: UILabel!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    var currentQuestionID: String = "-1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setNextQuestion()
    }
    
    //IBActions -> action funcs
    @IBAction func setNextQuestion(){
        self.startSpinner()
        self.enableYesNo()
        
        let subscriptionLoader = SubscriptionLoader()
        Meteor.callMethodWithName("getUnreadQuestion", parameters: []){
            questionID, error in
            
            self.currentQuestionID = questionID as! String
            
            subscriptionLoader.addSubscriptionWithName("questionById", parameters: questionID)
            
            subscriptionLoader.whenReady {
                let fetchRequest = NSFetchRequest(entityName: "Question")
                if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Question] {
                    self.stopSpinner()
                    self.questionText.text = fetchResults[0].content + "?"
                    println(fetchResults[0].content)
                }
            }
        }
    }
    @IBAction func answerQuestion(sender: AnyObject) {
        if(sender.selectedSegmentIndex == 0){
            Meteor.callMethodWithName("answerQuestion", parameters: [self.currentQuestionID, true]);
        }else{
            Meteor.callMethodWithName("answerQuestion", parameters: [self.currentQuestionID, false])
        }
        sender.setEnabled(false, forSegmentAtIndex: (sender.selectedSegmentIndex-1)*(-1))
    }
    
    //UIKit detail funcs
    func startSpinner(){
        self.spinnerOnLoadQuestion.startAnimating()
        self.spinnerOnLoadQuestion.hidden = false
    }
    func stopSpinner(){
        self.spinnerOnLoadQuestion.hidden = true
        self.spinnerOnLoadQuestion.stopAnimating()
    }
    func enableYesNo(){
        self.yesNoButton.setEnabled(true, forSegmentAtIndex: 0)
        self.yesNoButton.setEnabled(true, forSegmentAtIndex: 1)
    }
    
    
    //ViewController funcs
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

