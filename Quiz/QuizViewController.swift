//
//  QuizViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 03/12/2016.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var quiz:Quiz! {
        didSet {
            print("New Quize:\(quiz)")
            score = 0
            questionIndex = 0
            currentQuestion = quiz.questions.first
        }
    }
    
    fileprivate var currentQuestion:Question? {
        didSet {
            updateUI(animated: true)
        }
    }
    
    fileprivate var score = 0
    fileprivate var questionIndex = 0
    
    //1) Когда вьюконтроллер только создан,  унего не загружены никакие компоненты интерфейста.
    
    //2) Когда наступает пора загрузить View в память
    //Мы можем это сделать a) в коде, либо b) из файла storyboard.
    
    //a)Для этого необходимо переопредить метод loadView
    //в нем следуюет создать один объект типа UIView, или его наследник
    //добавить в коде другие элементы и все будет ок
    
    //b)Второй вариант - за вас все сделает система.
    
    //3) затем, после загрузки вью
    //у ViewController сработает метод viewDidLoad
    //Это отличное место для того, чтобы начать инициализию моделей,
    //начать какие-то длительные по времени процессы
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        setup()
        // в принт напишется имя вызванного метода
    }
    
    //4) У вьюконтроллера перед самым моментом показа на экране
    // сработает метод viewWillAppear
    // Обязательно следует вызвать super.
    // Отличная точка для подготовки к анимации
    // Сразу же после него ваш контроллер анимированно или не очень 
    // окажется на экране
    override func viewWillAppear(_ animated:Bool)
    {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    //5) вызывается в момент, когда анимация появления завершилась
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        updateUI(animated: true)
    }
    
    //6) вызывается перед тем, как будет произведено исчезновение
    //контроллера с экрана
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    //7) вызывается в момент, когда наш контроллер пропал с экрана.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    // 8) вызывается в момент, когда у системы заканчивается свободная 
    // опреативная память. Это отличный момент для того,
    // чтобы освободить память от тех объектов, коорые вы сможете позже
    // восстановить
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(#function)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? ResultViewController,
            let result = sender as? Double {
            vc.result = Int(result)
        }
        
    }
    
    
    
    //вызывается перед уничтожением вашего контроллера
    deinit {
        print(#function)
    }
    
    //MARK: - Setup
    
    func setup()
    {
        setupModel()
        setupViews()
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
    
    func setupViews()
    {
        //чтобы обработать события на tableView
        tableView?.delegate = self
        //чтобы отобразить ячейки
        tableView?.dataSource = self
    }
    
    //MARK: - Update UI
    
    func updateUI(animated:Bool)
    {
        imageView.image = currentQuestion?.image
        questionText.text = currentQuestion?.text
        tableView.reloadData()
    }
}

extension QuizViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let q = currentQuestion else {
            return 0
        }
        return q.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let answer = answerAt(index: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "quiestionCellID", for: indexPath)
        
        cell.textLabel?.text = answer
        cell.detailTextLabel?.text = "\(indexPath.row + 1)"
        
        return cell
    }
    
    fileprivate func answerAt(index:IndexPath)->String
    {
        if let q = currentQuestion {
            return q.answers[index.row]
        }
        return ""
    }
    
}

extension QuizViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedAnswer = answerAt(index: indexPath)
        if selectedAnswer == currentQuestion!.correctAnswer {
            score += 1
        }
        showNextQuestionIfNeeded()
    }
    
    func showNextQuestionIfNeeded()
    {
        questionIndex += 1
        guard questionIndex < quiz.questions.count else {
            print("показать результат")
            
            //посчитаем относительный результат
            let result = Double(score) / Double(quiz.questions.count)
            
            performSegue(withIdentifier: "Show Result", sender: result * 100)
            return
        }
        currentQuestion = quiz.questions[questionIndex]
    }
}
