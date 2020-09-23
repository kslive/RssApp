//
//  DetailNewsCell.swift
//  RssApp
//
//  Created by Eugene Kiselev on 22.09.2020.
//

import UIKit

class DetailNewsCell: UITableViewCell {
    
    private let constraint: CGFloat = 5
    private var nameNewsTitle = UILabel()
    private var dateNewsTitle = UILabel()
    var contentNewsTitle = UILabel()
    var titleNameAndDate: News! {
        didSet {
            
            nameNewsTitle.text = titleNameAndDate.nameNewsTitle
            dateNewsTitle.text = titleNameAndDate.dateNewsTitle
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameNewsTitle)
        addSubview(dateNewsTitle)
        addSubview(contentNewsTitle)
        
        configureTitles()
        setTitlesConstraints()        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Help function
    
    private func configureTitles() {
        
        nameNewsTitle.numberOfLines = 0
        nameNewsTitle.font = .boldSystemFont(ofSize: 20)
        nameNewsTitle.adjustsFontSizeToFitWidth = true
        
        dateNewsTitle.numberOfLines = 1
        
        contentNewsTitle.numberOfLines = 0
        contentNewsTitle.adjustsFontSizeToFitWidth = true
    }
    
    private func setTitlesConstraints() {
        
        nameNewsTitle.translatesAutoresizingMaskIntoConstraints = false
        nameNewsTitle.topAnchor.constraint(equalTo: topAnchor, constant: constraint).isActive = true
        nameNewsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constraint).isActive = true
        nameNewsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: constraint).isActive = true
        
        dateNewsTitle.translatesAutoresizingMaskIntoConstraints = false
        dateNewsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constraint).isActive = true
        dateNewsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: constraint).isActive = true
        dateNewsTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: constraint - 10).isActive = true
        
        contentNewsTitle.translatesAutoresizingMaskIntoConstraints = false
        contentNewsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constraint).isActive = true
        contentNewsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: constraint).isActive = true
        contentNewsTitle.heightAnchor.constraint(equalTo: heightAnchor, constant: UITableView.automaticDimension).isActive = true
    }
}
