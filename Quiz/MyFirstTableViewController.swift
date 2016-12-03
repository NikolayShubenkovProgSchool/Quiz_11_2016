//
//  MyFirstTableViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 03/12/2016.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class MyFirstTableViewController: UITableViewController {

    var model:[String] = "open class UITableView : UIScrollView, NSCoding public init(frame: CGRect, style:UITableViewStyle) // must specify style at creation. -initWithFrame: calls this with UITableViewStyleP  open var style: UITableViewStyle { get } open var sectionFooterHeight: CGFloat // will return the default value if unset".components(separatedBy: " ")
    
    //MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //1.Найдем данные, которые будут отображаться в ячейке по нужному индексу
        let dataToShow = model[indexPath.row]
        
        //2. Запросим шаблон ячейки у UITableView чтобы его настроить в соответствии с моделью
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID",
                                                 for: indexPath)
        
        //3. Сделаем так, чтобы ячейка показала нужную нам строку
        cell.textLabel?.text = dataToShow
        
        //вернем настроенную нами ячейку
        return cell
    }
    
}
