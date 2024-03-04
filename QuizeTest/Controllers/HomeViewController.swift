//
//  HomeViewController.swift
//  QuizeTest
//
//  Created by Ranjit Mahto on 18/02/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startQuize(_ sender:UIButton) {
        
        let storyBoard = UIStoryboard(name:"Main", bundle: nil)
        let resultController = storyBoard.instantiateViewController(withIdentifier: "QuizeViewController") as! QuizeViewController
        self.navigationController?.pushViewController(resultController, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }

}
