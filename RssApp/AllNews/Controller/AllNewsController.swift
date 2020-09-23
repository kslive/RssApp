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
    private let reuseIdentifier = "NewsCell"
    var ddd = [String]()
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
        tableView.rowHeight = 150
        tableView.register(ContentsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.pin(to: view)
        
        tableView.addSubview(refreshControl)
    }
    
    private func configureNavigationController() {
        
        title = "News"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addSource))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Chose", style: .plain, target: self, action: #selector(choseSource))
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
    
    @objc private func choseSource() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let sourceOne = UIAlertAction(title: "Новости компании, finam.ru", style: .default) { [weak self] _ in
            
            
            let url = "https://www.finam.ru/net/analysis/conews/rsspoint"
            self?.fetchData(url: url)
            self?.tableView.reloadData()
        }
        let sourceTwo = UIAlertAction(title: "banki.ru", style: .default) { [weak self] _ in
            
            let url = "https://www.banki.ru/xml/news.rss"
            self?.fetchData(url: url)
            self?.tableView.reloadData()
        }
        let sourceThree = UIAlertAction(title: "Новости мировых рынков", style: .default) { [weak self] _ in
            
            let url = "https://www.finam.ru/international/advanced/rsspoint"
            self?.fetchData(url: url)
            self?.tableView.reloadData()
        }
        let sourceFour = UIAlertAction(title: "Облигации: Новости", style: .default) { [weak self] _ in
            
            let url = "https://bonds.finam.ru/news/today/rss.asp"
            self?.fetchData(url: url)
            self?.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(sourceOne)
        actionSheet.addAction(sourceTwo)
        actionSheet.addAction(sourceThree)
        actionSheet.addAction(sourceFour)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
}

// MARK: UITableViewDataSource

extension AllNewsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let allNews = allNews else { return 0 }
        
        return allNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ContentsCell
        
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

