//
//  Quiz.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 03/12/2016.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import Foundation

struct Quiz
{
    let name:String
    let questions:[Question]
    
    init?(json:[String:Any])
    {
        guard let name = json["name"] as? String,
              let questionsJSONs = json["questions"] as? [ [String:Any] ]
            else {
                return nil
        }
        
        //тут мы будем хранить вопросы
        var questionArray = [Question]()
        
        for json in questionsJSONs {
            if let question = Question(json: json) {
                questionArray.append(question)
            }
        }
        
        guard questionArray.count > 0 else { return nil }
        
        self.name = name
        self.questions = questionArray
    }
}
