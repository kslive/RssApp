//
//  AllNewsController.swift
//  RssApp
//
//  Created by Eugene Kiselev on 22.09.2020.
//

import UIKit

class AllNewsController: UIViewController {
    
    var tableView = UITableView()
    var allNews = [News(nameNewsTitle: "News 1, News 1, News 1, News 1",
                        dateNewsTitle: "11:11",
                        contentNews: "Ранние годы жизни и образование Юрий Алексеевич Гагарин родился 9 марта 1934 года, по документам в деревне Клушино Гжатского района Западной области РСФСР (в настоящее время — Гагаринский район Смоленской области)[4][7], то есть по месту жительства (прописки) родителей. Фактическое место рождения — роддом города Гжатска[8] (переименованного в 1968 году в город Гагарин). По национальности русский. Является выходцем из рабочей среды: отец, Алексей Иванович Гагарин (14 (27) марта 1902[9]—30 августа 1973[10]), — плотник, мать, Анна Тимофеевна Матвеева (20 декабря 1903—12 июня 1984), работница молочно-товарной фермы[комм. 1][11], награждена орденами Трудового Красного Знамени и Дружбы Народов. Дед, Тимофей Матвеевич Матвеев (1871—1918), рабочий Путиловского завода, проживал в Санкт-Петербурге, в Автове, на Богомоловской (ныне Возрождения) улице в конце XIX века[12]. Тимофей Матвеевич Дом, В семье Гагариных было три сына и дочь. Юрий был третьим по старшинству. Детство Юрия прошло в деревне Клушино. 1 сентября 1941 года мальчик пошёл в школу, но 12 октября деревня оказалась в оккупации, и его учёба прервалась. Семью с малыми детьми немцы выгнали, а в доме устроили мастерскую. До начала зимы Гагарины выкопали небольшую землянку, накрыли дёрном, выложили печку. Немецкие солдаты избивали отца и заставляли его работать. Незадолго до отступления немцы угнали старшего брата Валентина и сестру Зою в Германию. Юра видел, как матери бежали за машиной, увозившей детей, а немцы отгоняли их прикладами. В дальнейшем Юрий Гагарин не упоминал о военных годах[13]. Почти полтора года деревня Клушино оставалась в оккупации, пока 9 апреля 1943 года её не освободила Красная армия. Учёба в школе возобновилась. 24 мая 1945 года семья Гагариных переехала в Гжатск. В мае 1949 года Юра окончил шестой класс Гжатской средней школы. Родители и учителя уговаривали его окончить семилетку в Гжатске, но Юрий хотел продолжить учёбу в Москве, где жили родственники. Попасть в Москву не удалось: пока родители готовили сына к отъезду, набор в московские ремесленные училища уже закончился. Только 30 сентября с помощью дяди, Савелия Ивановича Гагарина, Юрию удалось поступить в Люберецкое ремесленное училище № 10[14][15]. Одновременно Юрий поступил в вечернюю школу рабочей молодёжи. Во время учёбы, 16 декабря 1949 года, вступил в комсомол[16]. Седьмой класс вечерней школы окончил в мае 1951 года, а в июне окончил с отличием училище по специальности формовщик-литейщик[4][13]. В августе 1951 года Гагарин поступил в Саратовский индустриальный техникум на литейное отделение, где помимо учёбы проявил себя как хороший физкультурник и секретарь ДСО «Трудовые резервы»[16]. 25 октября 1954 года впервые пришёл в Саратовский аэроклуб ДОСААФ СССР. В 1955 году Юрий Гагарин добился значительных успехов, окончил с отличием учёбу и совершил первый самостоятельный полёт на самолёте Як-18. Всего в аэроклубе Юрий Гагарин выполнил 196 полётов и налетал 42 часа 23 мин[4]."),
                   News(nameNewsTitle: "News 2, News 2, News 2, News 2",
                        dateNewsTitle: "12:12",
                        contentNews: "News 2, News 2, News 2, News 2 News 2, News 2, News 2, News 2 News 2, News 2, News 2, News 2 News 2, News 2, News 2, News 2 "),
                   News(nameNewsTitle: "News 3, News 3, News 3, News 3",
                        dateNewsTitle: "13:13",
                        contentNews: "News 3, News 3, News 3, News 3 News 3, News 3, News 3, News 3 News 3, News 3, News 3, News 3 News 3, News 3, News 3, News 3 "),
                   News(nameNewsTitle: "News 4, News 4, News 4, News 4",
                        dateNewsTitle: "14:14",
                        contentNews: "News 4, News 4, News 4, News 4 News 4, News 4, News 4, News 4 News 4, News 4, News 4, News 4 News 4, News 4, News 4, News 4 ")]
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
        
        let newNews = News(nameNewsTitle: "News from Refresh", dateNewsTitle: "01:00", contentNews: "News from Refresh News from Refresh News from Refresh")
        allNews.append(newNews)
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc func addSource() {
        
        let alert = UIAlertController(title: "Enter Source (URL) with RSS", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            
            let newNews = News(nameNewsTitle: "News from URL", dateNewsTitle: "02:00", contentNews: "News from URL News from URL News from URL")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailNewsController = DetailNewsController()
        let news = allNews[indexPath.row]
        
        detailNewsController.set(news: news)
        
        if indexPath == tableView.indexPathForSelectedRow {
            
            detailNewsController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(detailNewsController, animated: true)
        }
    }
}

