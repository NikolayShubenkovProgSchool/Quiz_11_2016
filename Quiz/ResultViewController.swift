//
//  ResultViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 03/12/2016.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    //0 ... 100
    var result:Int = 100
    
    @IBOutlet weak var resultText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews()
    {
        var text = ""
        
        switch result
        {
        case 0:  text = "Вы бот"
        
        case 1 ... 30: text = "Повезет в другой раз"
            
        case 31 ... 60: text = "Неплохо, могло быть и получше"
            
        case 61 ... 99: text = "Отлично"
        
        case 100: text = "Ну вот теперь точно бот"
            
        default:
            text = "эээ..... "
        }
        
        resultText.text = text
    }
    

}
