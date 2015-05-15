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
    
    var chartViewController : ChartViewController?
    
    //UIKit vars
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var yesNoButton: UISegmentedControl!
    @IBOutlet weak var spinnerOnLoadQuestion: UIActivityIndicatorView!
    @IBOutlet weak var questionText: UILabel!

    
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
    }
    
    @IBAction func answerQuestion(sender: AnyObject) {
        self.viewModel.answerQuestion(sender){
            answers in
            
            //Generate charts!
            self.viewModel.generateCharts(answers)
            
            //enableCharts
            self.viewModel.chartViewModel.chartIsHidden.value = false
        }
    }
    
    func initializeView(){
        self.initializeBindings()
        
        //ook via bond:
        self.setButtonToSkipQuestion()
        
        self.setNextQuestion()
    }
    func setButtonToSkipQuestion(){
        self.nextQuestionButton.setTitle("Skip Question", forState: nil)
    }
    
    //MVVM Binding
    func initializeBindings(){
        self.viewModel.question ->> self.questionText
        self.viewModel.spinnerShouldSpin ->> self.spinnerOnLoadQuestion
        self.viewModel.chartViewModel.chartIsHidden ->> self.chartViewController!.view.dynHidden
        
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

