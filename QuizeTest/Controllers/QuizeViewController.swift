//
//  ViewController.swift
//  QuizeTest
//
//  Created by Ranjit Mahto on 17/02/24.
//

import UIKit

class QuizeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblCounter : UILabel!
    @IBOutlet weak var bottomAnchor : NSLayoutConstraint!
    
     var counter = 0
     var topTenQueries : [Query] = []
     var currentQuestion : Query!
     var currentAnswers:[AnswerOption] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    private func setUpView() {
        
        lblCounter.text = ""
        bottomAnchor.constant = 0
        btnPrev.isHidden = true
        btnNext.isHidden = true
        
        let questionCellNib = UINib(nibName: "QueryViewCell", bundle: nil)
        tableView.register(questionCellNib, forCellReuseIdentifier: "QueryCell")
        let answerCellNib = UINib(nibName: "AnswerViewCell", bundle: nil)
        tableView.register(answerCellNib, forCellReuseIdentifier: "AnswerCell")
        
        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableView.automaticDimension
        // Initialization code
        tableView.dataSource = self
        tableView.delegate = self
        
        btnPrev.layer.cornerRadius = 25
        btnNext.layer.cornerRadius = 25
        
        self.fetchQuestion()
    }
    
    private func fetchQuestion(){
        self.getAllQuery {
            DispatchQueue.main.async{
                self.loadQuestionAnswer(Index: self.counter)
            }
        }
    }
    
    func loadQuestionAnswer(Index:Int){
        self.currentQuestion = self.topTenQueries[Index]
        self.currentAnswers = self.getAnswers(of: currentQuestion)
        self.tableView.reloadData()
        self.updateCounterLabel()
        
        /*
        print("ALL ANSWER WITH KEY CODE", self.currentAnswers.count)
        self.currentAnswers.forEach { option in
            print("Available option key:- ", option.ansCode, " value:-", option.ansValue)
        }
        print("The CORRECT ANSWER IS :- ", self.currentQuestion.correct)
         */
    }
    
    func updateCounterLabel(){
        //print("Current Counter", counter)
        lblCounter.text = "Question \(counter+1) of \(topTenQueries.count)"
        if counter == 0 {
            btnPrev.isHidden = true
            btnNext.isHidden = false
            bottomAnchor.constant = 0
        }else if counter == (topTenQueries.count-1){
            btnNext.isHidden = true
            btnPrev.isHidden = false
            bottomAnchor.constant = 80
        }else{
            btnNext.isHidden = false
            btnPrev.isHidden = false
            bottomAnchor.constant = 0
        }
    }
}

extension QuizeViewController {
    
    @IBAction func gotoNextQuestion(_ sender:UIButton) {
        counter += 1
        self.loadQuestionAnswer(Index: counter)
    }
    
    @IBAction func gotoPreviuosQuestion(_ sender:UIButton) {
        counter -= 1
        self.loadQuestionAnswer(Index: counter)
    }
    
    @IBAction func sumbitQuery(_ sender:UIButton){
        let storyBoard = UIStoryboard(name:"Main", bundle: nil)
        let resultController = storyBoard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        resultController.queryResult = topTenQueries
        resultController.replayBlock = { isReplay in
            if isReplay {
                print("Replay Again")
                self.counter = 0
                self.topTenQueries.removeAll()
                self.currentAnswers.removeAll()
                self.fetchQuestion()
            }
        }
        self.navigationController?.pushViewController(resultController, animated: true)
    }
}

