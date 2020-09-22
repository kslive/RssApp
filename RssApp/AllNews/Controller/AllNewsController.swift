//
//  AllNewsController.swift
//  RssApp
//
//  Created by Eugene Kiselev on 22.09.2020.
//

import UIKit

class AllNewsController: UIViewController {
    
    var tableView = UITableView()
    var allNews = [News(nameNewsTitle: "News 1, News 1, News 1, News 1", dateNewsTitle: "11:11"),
                   News(nameNewsTitle: "News 2, News 2, News 2, News 2", dateNewsTitle: "12:12"),
                   News(nameNewsTitle: "News 3, News 3, News 3, News 3", dateNewsTitle: "13:13"),
                   News(nameNewsTitle: "News 4, News 4, News 4, News 4", dateNewsTitle: "14:14")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        configureTableView()
    }
 
    // MARK: Help function
    
    func configureTableView() {
        
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(ContentsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: UITableViewDataSource

extension AllNewsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! ContentsCell
        let news = allNews[indexPath.row]
        
        cell.configure(for: news)
        
        return cell
    }
}

