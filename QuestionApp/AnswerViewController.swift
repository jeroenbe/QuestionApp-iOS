//
//  FirstViewController.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 29/04/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import UIKit
import Meteor
import Bond

class AnswerViewController: UIViewController {
    
    var viewModel = AnswerViewModel()
    
    
    //UIKit vars
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var yesNoButton: UISegmentedControl!
    @IBOutlet weak var spinnerOnLoadQuestion: UIActivityIndicatorView!
    @IBOutlet weak var questionText: UILabel!
    var chartViewController: ChartViewController?
    
    //Core Data vars
    //let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //Meteor vars
    var currentQuestionID: String = "-1"
    var skip = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initializeView()
        
    }
    
    //IBActions -> action funcs
    @IBAction func setNextQuestion(){
        self.viewModel.setNextQuestion()
        
        
//        self.chartViewController?.disableGraph()
//        if(self.skip){
//            Meteor.callMethodWithName("skipQuestion", parameters: [self.currentQuestionID]){
//                void in
//                self.getUnreadQuestion()
//            }
//        }else{
//            self.getUnreadQuestion()
//            self.skip = true
//        }
    }
    
//    func getUnreadQuestion(){
//        self.startSpinner()
//        self.enableYesNo()
//        self.setButtonToSkipQuestion()
//        
//        let subscriptionLoader = SubscriptionLoader()
//        Meteor.callMethodWithName("getUnreadQuestion", parameters: []){
//            questionID, error in
//            
//            var currentQuestionID = Meteor.objectIDForDocumentKey(METDocumentKey(collectionName: "questions", documentID: questionID))
//            self.currentQuestionID = questionID as! String
//            
//            
//            subscriptionLoader.addSubscriptionWithName("questionById", parameters: questionID)
//            
//            subscriptionLoader.whenReady {
//                self.stopSpinner()
//                var question = (self.managedObjectContext?.existingObjectWithID(currentQuestionID, error: nil) as? Question)
//                if let question = question {
//                    self.questionText.text = question.content + "?"
//                }
//            }
//        }
//    }
    
    @IBAction func answerQuestion(sender: AnyObject) {
        self.viewModel.answerQuestion(sender){
            answers in
            
            self.chartViewController?.generateChart(answers[0], no: answers[1], skipped: answers[2])
            self.chartViewController?.enableGraph()
        }
//        var answer = false
//        self.skip = false
//        self.setButtonToNextQuestion()
//        
//        if(sender.selectedSegmentIndex == 0){
//            answer = true
//        }
//        
//        self.sendAnswer(answer) {
//            result in
//            self.fetchAnswersForQuestion(){
//                answers in
//                
//                self.chartViewController?.generateChart(answers[0], no: answers[1], skipped: answers[2])
//                self.chartViewController?.enableGraph()
//            }
//        }
//        sender.setEnabled(false, forSegmentAtIndex: (sender.selectedSegmentIndex-1)*(-1))
    }
    
//    func sendAnswer(answer: Bool, callback: METMethodCompletionHandler){
//        Meteor.callMethodWithName("answerQuestion", parameters: [self.currentQuestionID, answer], completionHandler: callback)
//    }
    
//   func fetchAnswersForQuestion(callback: ([Double])->()){
//        var skipped: Double = 0
//        var yes: Double = 0
//        var no: Double = 0
//        
//        let subscriptionLoader = SubscriptionLoader()
//        
//        subscriptionLoader.addSubscriptionWithName("answersForQuestion", parameters: self.currentQuestionID as String)
//        
//        subscriptionLoader.whenReady {
//            let fetchRequest = NSFetchRequest(entityName: "Answer")
//            let predicate = NSPredicate(format: "question == %@", self.currentQuestionID)
//            
//            fetchRequest.predicate = predicate
//            
//            if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Answer]{
//                for Answer in fetchResults{
//                    if Answer.answer == true {
//                        yes++
//                    }else if Answer.answer == false {
//                        no++
//                    }else{
//                        skipped++
//                    }
//                }
//                callback([yes, no, skipped])
//            }
//        }
//    }
    
    //UIKit detail funcs
//    func startSpinner(){
//        self.spinnerOnLoadQuestion.startAnimating()
//        self.spinnerOnLoadQuestion.hidden = false
//    }
//    func stopSpinner(){
//        self.spinnerOnLoadQuestion.hidden = true
//        self.spinnerOnLoadQuestion.stopAnimating()
//    }
//    func enableYesNo(){
//        self.yesNoButton.setEnabled(true, forSegmentAtIndex: 0)
//        self.yesNoButton.setEnabled(true, forSegmentAtIndex: 1)
//        self.yesNoButton.selectedSegmentIndex = UISegmentedControlNoSegment
//    }
    func initializeView(){
        self.initializeBindings()
        
        //ook via bond:
        self.setButtonToSkipQuestion()
        
        self.setNextQuestion()
    }
    func setButtonToSkipQuestion(){
        self.nextQuestionButton.setTitle("Skip Question", forState: nil)
    }
//    func setButtonToNextQuestion(){
//        self.nextQuestionButton.setTitle("Next Question", forState: nil)
//    }
    
    //MVVM Binding
    func initializeBindings(){
        self.viewModel.question ->> self.questionText
        self.viewModel.spinnerShouldSpin ->> self.spinnerOnLoadQuestion
        // self.viewModel.yesNoButtonIsEnabled ->> self.yesNoButton
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

