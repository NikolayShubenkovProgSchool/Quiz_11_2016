//
//  Question.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 03/12/2016.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

struct Question
{
    let text:String
    let answers:[String]
    let correctAnswer:String
    private let imageName:String?
    
    var image:UIImage?
    {
        guard imageName != nil else { return nil }
        return UIImage(named: imageName!)
    }
    
    init?(json:[String:Any])
    {
        guard let questionText = json["question"] as? String,
              let answerList   = json["answers"] as? [String],
            answerList.count > 1,
              let correctAnswer = json["correctAnswer"] as? String,
              answerList.contains(correctAnswer)
            else {
            return nil
        }
        
        self.text = questionText
        self.answers = answerList
        self.correctAnswer = correctAnswer
        
        if let imageName = json["image"] as? String {
            self.imageName = imageName
        }
        else {
            self.imageName = nil
        }
        
    }
}
