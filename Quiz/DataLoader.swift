//
//  DataLoader.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 03/12/2016.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import Foundation

class DataLoader {
    
    func loadQuizWith(name:String)->Quiz?
    {
        //попытаемся найти путь, по которому лежит наш файл с викториной
        guard let pathToQuestion = Bundle.main.path(forResource: name,
                                                    ofType: "json") else {
                                                        return nil
        }
        
        //попробуем прочитать сырые данные из файл
        guard let data = NSData(contentsOfFile: pathToQuestion) else {
            return nil
        }
        
        //мы получили что-то
        guard let quizData = try? JSONSerialization.jsonObject(with: data as Data,
                                                          options: []) else {
                                                            return nil
        }
        
        //привели полученный объект к нужному нам типу для создания нашей модели
        guard let json = quizData as? [String:Any] else {
            return nil
        }
        
        guard let quiz = Quiz(json: json) else { return nil }
        
        return quiz
    }
}
