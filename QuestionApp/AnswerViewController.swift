//
//  FirstViewController.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 29/04/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import UIKit
import Bond

class AnswerViewController: UIViewController {
    
    var viewModel = AnswerViewModel()
    
    var chartViewController : ChartViewController?
    
    //UIKit vars
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var yesNoButton: UISegmentedControl!
    @IBOutlet weak var spinnerOnLoadQuestion: UIActivityIndicatorView!
    @IBOutlet weak var questionText: UILabel!
    
    
    //Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initializeView()
    }
    
    func initializeView(){
        self.initializeBindings()
        
        //ook via bond:
        self.setNextQuestion()
    }
    
    //IBActions -> action funcs
    @IBAction func setNextQuestion(){
        self.viewModel.setNextQuestion()
        self.enableYesNo()
    }
    @IBAction func answerQuestion(sender: AnyObject) {
        self.viewModel.answerQuestion(sender){
            answers in
            
            //Generate charts!
            self.chartViewController?.generateChart(answers[0], no: answers[1], skipped: answers[2])
            
            //Show charts!
            self.viewModel.chartViewModel.chartIsHidden.value = false
        }
    }
    
    //MVVM Binding
    func initializeBindings(){
        //AnswerViewModel
        self.viewModel.question ->> self.questionText
        self.viewModel.spinnerShouldSpin ->> self.spinnerOnLoadQuestion
        self.viewModel.nextQuestionForButton ->> self.nextQuestionButton.dynTitle
        //No enableYesNo; see explenation below
        
        //ChartViewModel (=Sub VM!)
        self.viewModel.chartViewModel.chartIsHidden ->> self.chartViewController!.view.dynHidden
        self.viewModel.chartViewModel.yesForLabel ->> self.chartViewController!.yesCountLabel
        self.viewModel.chartViewModel.noForLabel ->> self.chartViewController!.noCountLabel
        self.viewModel.chartViewModel.skippedForLabel ->>   self.chartViewController!.skippedCountLabel
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
    
    /**
    
    Making a Bond (in SwiftBond) for UISegmentedControl is either difficult or impossible (I have yet to figure this out).
    I aspired to make a bond from the button to a Bool in the AnswerViewModel to enable the button. However, it appears that every segment of this UIResponder is enabled seperatly according to index (see the function below).
    One Bool will obviously not suffice...
    
    Hence the function below. I placed this function in the ViewController (or View in MVVM), since I found that the VM should know as little as possible of UI elements.
    
    */
    func enableYesNo(){
        self.yesNoButton.setEnabled(true, forSegmentAtIndex: 0)
        self.yesNoButton.setEnabled(true, forSegmentAtIndex: 1)
        self.yesNoButton.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    
}

