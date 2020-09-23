//
//  DetailNewsController.swift
//  RssApp
//
//  Created by Eugene Kiselev on 22.09.2020.
//

import UIKit

class DetailNewsController: UIViewController {
    
    private var tableView = UITableView()
    private var allNews: News?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureTableView()
    }
    
    // MARK: Help function
    
    private func configureTableView() {
        
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.separatorColor = .clear
        tableView.register(DetailNewsCell.self, forCellReuseIdentifier: "DetailNewsCell")
        tableView.pin(to: view)
    }
    
    private func setTableViewDelegates() {
        
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
        
        if let allNews = allNews {
            
            if indexPath.row == 0 {
                
                cell.titleNameAndDate = allNews
            } else {
                
                cell.contentNewsTitle.text = allNews.contentNews
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return 110
        } else {
            return UITableView.automaticDimension
        }
    }
}
