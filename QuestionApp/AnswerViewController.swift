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
    
    @IBOutlet weak var spinnerOnLoadQuestion: UIActivityIndicatorView!
    @IBOutlet weak var questionText: UILabel!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setNextQuestion()
    }
    
    //IBActions -> action funcs
    @IBAction func setNextQuestion(){
        self.startSpinner()
        
        let subscriptionLoader = SubscriptionLoader()
        Meteor.callMethodWithName("getUnreadQuestion", parameters: []){
            questionID, error in
            subscriptionLoader.addSubscriptionWithName("questionById", parameters: questionID)
            
            subscriptionLoader.whenReady {
                let fetchRequest = NSFetchRequest(entityName: "Question")
                if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Question] {
                    self.stopSpinner()
                    self.questionText.text = fetchResults[0].content + "?"
                }
            }
        }
    }
    @IBAction func answerQuestion(sender: AnyObject) {
        println((sender as! UISegmentedControl).selectedSegmentIndex)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

