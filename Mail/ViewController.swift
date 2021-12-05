//
//  ViewController.swift
//  Mail
//
//  Created by Оксана on 01.12.2021.
//

/*
  Добавить кастомные ячейки можно через
 1. xib
 2. Main.storyboard
 */
import UIKit

class ViewController: UIViewController {
    
    let idCell = "mailCell"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate  = self
        
        
        // добавляем navigationBar
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        //позволяем редактировать таблицу
//        tableView.isEditing = true

        // добавляем строку поска
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self as UISearchResultsUpdating
        self.navigationItem.searchController = search
        
        let btnSettings = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(goToSettings))
        navigationItem.rightBarButtonItem = btnSettings
        
        // регистрируем наш класс с кастомной ячейкой
//        tableView.register(UINib(nibName: "MailTableViewCell", bundle: nil), forCellReuseIdentifier: idCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    @objc func goToSettings(){
        //инициализируем SettingsVC с помощью идентификатора
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeRead = UIContextualAction(style: .normal, title: "Непрочитано"){ (action, view, success) in
            print("No Read Swipe")
        }
        
        swipeRead.image = UIImage.init(named: "icon")
        swipeRead.backgroundColor = UIColor.white
        
        return UISwipeActionsConfiguration(actions: [swipeRead])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeMore = UIContextualAction(style: .normal, title: "more"){ (action, view, success) in
            print("More")
        }
        
        swipeMore.backgroundColor = UIColor.darkGray
        swipeMore.image = UIImage.init(systemName: "ellipsis.bubble")
        
        
        let swipeFlag = UIContextualAction(style: .normal, title: "flag") { (action, view, success) in
            print("Flag")
        }
        swipeFlag.backgroundColor = UIColor.cyan
        swipeFlag.image = UIImage.init(systemName: "flag.circle.fill")
        
        let swipeAr = UIContextualAction(style: .normal, title: "archive") { (action, view, success) in
            print("archive")
        }
        swipeAr.backgroundColor = UIColor.brown
        swipeAr.image = UIImage.init(systemName: "archivebox.circle")
        
        
        
        let conf = UISwipeActionsConfiguration(actions: [swipeMore, swipeFlag, swipeAr])
        conf.performsFirstActionWithFullSwipe = false //отключаем fullSwipe
        
        return conf
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 15
//    }
    
    
    // title for header если есть секции
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String{
//        return "section"
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
//        if section == 1 {
//            return 3
//        } else {
//            return 5
//        }
    }
    
    
    //кастомная ячейка
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // as! не проверяем так как уверены что это ячейка нашего класса
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! MailTableViewCell
        //cell.titleLabel.text = "text"
        //cell.subtitleLable.text = "subTitleLable"
        
        return cell
    }
    
    
    
    /* нативная ячейка
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell)
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: idCell)
        }
        
        if(indexPath.section == 0){
            cell!.textLabel?.text = "Mail Subject"
            cell!.detailTextLabel?.text = "detail text"
            cell!.imageView?.image = UIImage(named: "icon")
        }  else {
            cell!.textLabel?.text = "Mail msg"
            cell!.detailTextLabel?.text = "some text"
        }
        
        
        return cell!
    }
     */
    
    
    
    // Метод делегата. Отпределим высоту ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    
    // Метод делегата. Выбор ячейки когда на нее нажимаем
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("details\(indexPath.row)")
    }
    
}

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text) // распечатаем то что вводим
    }
}

