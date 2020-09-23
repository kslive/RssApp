//
//  DetailNewsController.swift
//  RssApp
//
//  Created by Eugene Kiselev on 22.09.2020.
//

import UIKit

class DetailNewsController: UIViewController {
    
    var tableView = UITableView()
    var allNews: News?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureTableView()
    }
    
    // MARK: Help function
    
    func configureTableView() {
        
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.separatorColor = .clear
        tableView.register(DetailNewsCell.self, forCellReuseIdentifier: "DetailNewsCell")
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func set(news: News) {
        
        allNews = news
    }
}

extension DetailNewsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailNewsCell", for: indexPath) as! DetailNewsCell
        
        if indexPath.row == 0 {
            
            cell.nameNewsTitle.text = allNews?.nameNewsTitle
            cell.dateNewsTitle.text = allNews?.dateNewsTitle
            
            tableView.rowHeight = 100
        } else {
            
            cell.contentNewsTitle.text = allNews?.contentNews
            
            tableView.rowHeight = 1700
        }
        
        return cell
    }
}
