//
//  AllNewsController.swift
//  RssApp
//
//  Created by Eugene Kiselev on 22.09.2020.
//

import UIKit

class AllNewsController: UIViewController {
    
    private var tableView = UITableView()
    private var allNews: [News]?
    private var url = "https://www.finam.ru/net/analysis/conews/rsspoint"
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
        
        fetchData(url: url)
    }
    
    
    // MARK: Help function
    
    private func configureTableView() {
        
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(ContentsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.pin(to: view)
        
        tableView.addSubview(refreshControl)
    }
    
    private func configureNavigationController() {
        
        title = "News"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addSource))
    }
    
    private func setTableViewDelegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchData(url: String) {
        
        let newsParser = NewsParser()
        
        
        newsParser.parseNews(url: url) { [weak self] allNews in
            
            self?.allNews = allNews
            
            OperationQueue.main.addOperation {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .bottom)
            }
        }
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        fetchData(url: url)
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc private func addSource() {
        
        let alert = UIAlertController(title: "Enter Source (URL) with RSS", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            
            guard let url = alert.textFields?.first?.text, !url.isEmpty else { return }
            
            self?.url = url
            self?.fetchData(url: url)
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
        
        guard let allNews = allNews else { return 0 }
        
        return allNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! ContentsCell
        
        if let news = allNews?[indexPath.row] {
            
            cell.configure(for: news)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailNewsController = DetailNewsController()
        
        if let news = allNews?[indexPath.row] {
            
            detailNewsController.set(news: news)
        }
        
        if indexPath == tableView.indexPathForSelectedRow {
            
            detailNewsController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(detailNewsController, animated: true)
        }
    }
}

