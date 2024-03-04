//
//  ResultViewController.swift
//  QuizeTest
//
//  Created by Ranjit Mahto on 18/02/24.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var lblResult:UILabel!
    @IBOutlet weak var lblGreeting:UILabel!
    @IBOutlet weak var lblRightAns:UILabel!
    @IBOutlet weak var lblWrongAns:UILabel!
    @IBOutlet weak var lblSkipAns:UILabel!
    
    var replayBlock:((_ isReplay:Bool)->Void)?

    var queryResult:[Query]?
    private var rightAns : Int = 0
    private var wrongAns : Int = 0
    private var skipAns : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.loadResult()
    }
     
    private func setUpView(){
        self.title = "Trivia for success"
        self.lblResult.text = ""
        self.lblGreeting.text = ""
        self.lblRightAns.text = ""
        self.lblWrongAns.text = ""
        self.lblSkipAns.text = ""
    }
    
    func loadResult(){
        guard let queryResult else {return}
        //print("Result", queryResult.count)
        print("Final Result:", queryResult.count)
        queryResult.forEach { query  in
            print("User Sel Answer:", query.userSelAnswer, " Correct:", query.correct, " Result:", query.userSelAnswer == query.correct ? "✅":"❌")

            if query.userSelAnswer == "none" {
                skipAns += 1
            }else{
                if query.userSelAnswer == query.correct {
                    rightAns += 1
                }else{
                    wrongAns += 1
                }
            }
        }
        
        self.lblResult.text = "\(rightAns) out of \(queryResult.count)"
        self.lblGreeting.text = rightAns > 5 ? "Well Done" : "Fail"
        self.lblRightAns.text = "Your right answer is : \(rightAns)"
        self.lblWrongAns.text = "Your wrong answer is : \(wrongAns)"
        self.lblSkipAns.text = "Your skip answer is : \(skipAns)"
    }
    
    @IBAction func replay(_ sender:UIButton) {
        self.replayBlock?(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func home(_ sender:UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
