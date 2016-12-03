//
//  QuizViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 03/12/2016.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    var quiz:Quiz! {
        didSet {
            print("New Quize:\(quiz)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup
    func setup()
    {
        setupModel()
    }
    
    func setupModel()
    {
        //если нам уже задали модель,
        //не нужно ее загружть
        if quiz != nil {
            return
        }
        let loader = DataLoader()
        
        quiz = loader.loadQuizWith(name: "cinema")!
    }
    
}

