//
//  DetailNewsCell.swift
//  RssApp
//
//  Created by Eugene Kiselev on 22.09.2020.
//

import UIKit

class DetailNewsCell: UITableViewCell {
    
    let constraint: CGFloat = 5
    var nameNewsTitle = UILabel()
    var dateNewsTitle = UILabel()
    var contentNewsTitle = UILabel()
    
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
    
    func configureTitles() {
        
        nameNewsTitle.numberOfLines = 0
        nameNewsTitle.font = .boldSystemFont(ofSize: 20)
        nameNewsTitle.adjustsFontSizeToFitWidth = true
        
        dateNewsTitle.numberOfLines = 1
        
        contentNewsTitle.numberOfLines = 0
        contentNewsTitle.font = .italicSystemFont(ofSize: 18)
        contentNewsTitle.adjustsFontSizeToFitWidth = true
    }
    
    func setTitlesConstraints() {
        
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
        contentNewsTitle.topAnchor.constraint(equalTo: topAnchor, constant: constraint).isActive = true
    }
}