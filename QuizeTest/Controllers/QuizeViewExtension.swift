//
//  QuizeViewExtension.swift
//  QuizeTest
//
//  Created by Ranjit Mahto on 18/02/24.
//

import Foundation
import UIKit

extension QuizeViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 //question and answers
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // question
        }
        return currentAnswers.count // answer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let  cell  = tableView.dequeueReusableCell(withIdentifier: "QueryCell", for: indexPath) as! QueryViewCell
            cell.lblQuestion.text = currentQuestion?.question
            return cell
        }
        
        let  cell  = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerViewCell
        cell.ivCorrect.image = UIImage(systemName:imgCheck.unselect)
        cell.ivCorrect.tintColor = .black
        cell.lblAnswer.text = currentAnswers[indexPath.row].ansValue
        
        if currentAnswers[indexPath.row].ansCode == self.topTenQueries[counter].userSelAnswer {
            cell.ivCorrect.image = UIImage(systemName:imgCheck.select)
            cell.ivCorrect.tintColor = .accent
        }
        return cell
    }
}

extension QuizeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.topTenQueries[counter].userSelAnswer = currentAnswers[indexPath.row].ansCode
            //print("User Selected:-", self.topTenQueries[counter].userSelAnswer, "Result", self.topTenQueries[counter].userSelAnswer == self.topTenQueries[counter].correct ? "✅":"❌")
            tableView.reloadSections(IndexSet(integer: 1), with: .fade)
        }
    }
}

extension QuizeViewController {
    
    func getAllQuery(completion:@escaping()->Void){
        
        APIManager.shared.fetchQuestions { responseResult in
            
            switch responseResult {
            case .success(let questions):
                print(questions.count)
                
                if questions.count > 0 {
                    self.topTenQueries = self.getRandomQuestions(allQueries: questions, pickQueries: 10)
                }
                
                completion()
            case .failure(let error):
                print("Response Error:::", error)
                completion()
            }
        }
    }
    
    private func getRandomQuestions(allQueries:[Query], pickQueries:Int) -> [Query] {
        
        var querySet = Set<Query>()
        
        while querySet.count < pickQueries {
            let randomIndex = Int(arc4random_uniform(UInt32(allQueries.count)))
            querySet.insert(allQueries[randomIndex])
        }
        let resultArray = Array(querySet)
        return resultArray
    }
    
    private func getTotalAnswers(of questions:Query) -> [String] {
        //guard let questions else {return [] }
        let queryDict = questions.toDictionary()
        var ans = [String]()
        for(key, value) in  queryDict {
            if key.hasPrefix("ans") && (value as! String).count > 0 {
                ans.append(value as! String)
            }
        }
        return ans
    }
    
    func getAnswers(of questions:Query) -> [AnswerOption] {
        //guard let questions else {return []
        let totalOptions = self.getTotalAnswers(of: questions)
        let queryDict = questions.toDictionary()
        var answerOptions = [AnswerOption](repeating: AnswerOption(ansCode:"", ansValue:"") , count: totalOptions.count)
        
        for aQuery in queryDict {
            if aQuery.key.hasPrefix("ans") {
                if (aQuery.value as! String).count > 0 {
                    let ansOption = AnswerOption(ansCode: aQuery.key , ansValue: aQuery.value as! String)
                    let index:Int = Int(String(ansOption.ansCode.last!))!
                    answerOptions[index-1] = ansOption
                }
            }
        }
        return answerOptions
    }
}


