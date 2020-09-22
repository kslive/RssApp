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
    // pull to refresh
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationController()
    }
    
    // MARK: Help function
    
    func configureTableView() {
        
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(ContentsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.pin(to: view)
        
        tableView.addSubview(refreshControl)
    }
    
    func configureNavigationController() {
        
        title = "News"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addSource))
    }
    
    func setTableViewDelegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        let newNews = News(nameNewsTitle: "News from Refresh", dateNewsTitle: "01:00")
        allNews.append(newNews)
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc func addSource() {
        
        let alert = UIAlertController(title: "Enter Source (URL) with RSS", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            
            let newNews = News(nameNewsTitle: "News from URL", dateNewsTitle: "02:00")
            self?.allNews.append(newNews)
            
            self?.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { textField in
            
            textField.placeholder = "Enter URL"
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
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

