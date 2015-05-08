//
//  FirstViewController.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 29/04/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import UIKit
import Meteor

class AnswerViewController: UIViewController {
    
    //UIKit vars
    @IBOutlet weak var yesNoButton: UISegmentedControl!
    @IBOutlet weak var spinnerOnLoadQuestion: UIActivityIndicatorView!
    @IBOutlet weak var questionText: UILabel!
    var chartViewController: ChartViewController?
    
    //Core Data vars
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //Meteor vars
    var currentQuestionID: String = "-1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setNextQuestion()
        
        self.chartViewController?.helloWorldLabel.text = "hallo wereld!"
        
    }
    
    //IBActions -> action funcs
    @IBAction func setNextQuestion(){
        self.startSpinner()
        self.enableYesNo()
        
        let subscriptionLoader = SubscriptionLoader()
        Meteor.callMethodWithName("getUnreadQuestion", parameters: []){
            questionID, error in
            
            var currentQuestionID = Meteor.objectIDForDocumentKey(METDocumentKey(collectionName: "questions", documentID: questionID))
            self.currentQuestionID = questionID as! String
            
            
            subscriptionLoader.addSubscriptionWithName("questionById", parameters: questionID)
            
            subscriptionLoader.whenReady {
                self.stopSpinner()
                var question = (self.managedObjectContext?.existingObjectWithID(currentQuestionID, error: nil) as? Question)
                if let question = question {
                    self.questionText.text = question.content + "?"
                }
            }
        }
    }
    @IBAction func answerQuestion(sender: AnyObject) {
        var answer = false
        if(sender.selectedSegmentIndex == 0){
            answer = true
        }
        
        Meteor.callMethodWithName("answerQuestion", parameters: [self.currentQuestionID, answer]) {
            result in
            var skipped: Int = 0
            var yes: Int = 0
            var no: Int = 0
            
            let subscriptionLoader = SubscriptionLoader()
            subscriptionLoader.addSubscriptionWithName("answersForQuestion", parameters: self.currentQuestionID as String)
            
            subscriptionLoader.whenReady {
                let fetchRequest = NSFetchRequest(entityName: "Answer")
                if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Answer]{
                    for Answer in fetchResults{
                        if Answer.answer == true {
                            yes++
                        }else if Answer.answer == false {
                            no++
                        }else{
                            skipped++
                        }
                    }
                }
            }
        }
        sender.setEnabled(false, forSegmentAtIndex: (sender.selectedSegmentIndex-1)*(-1))
    }
    
    //JawBone Charts
    func createChart(skipped: Int, no: Int, yes: Int)->JBBarChartView{
        var chart = JBBarChartView()
        //TODO
        
        
        return chart
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
        self.yesNoButton.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    
    //ViewController funcs
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        super.prepareForSegue(segue, sender: sender)
        self.chartViewController = segue.destinationViewController as? ChartViewController
    }
}

