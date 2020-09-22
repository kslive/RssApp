//
//  ContentsCell.swift
//  RssApp
//
//  Created by Eugene Kiselev on 22.09.2020.
//

import UIKit

class ContentsCell: UITableViewCell {
    
    let constraint: CGFloat = 5
    var nameNewsTitle = UILabel()
    var dateNewsTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameNewsTitle)
        addSubview(dateNewsTitle)
        
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
    }
    
    func setTitlesConstraints() {
        
        nameNewsTitle.translatesAutoresizingMaskIntoConstraints = false
        nameNewsTitle.topAnchor.constraint(equalTo: topAnchor, constant: constraint).isActive = true
        nameNewsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constraint).isActive = true
        nameNewsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: constraint).isActive = true
        
        dateNewsTitle.translatesAutoresizingMaskIntoConstraints = false
        dateNewsTitle.topAnchor.constraint(equalTo: topAnchor, constant: nameNewsTitle.frame.height + 30).isActive = true
        dateNewsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constraint).isActive = true
        dateNewsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: constraint).isActive = true
    }
    
    func configure(for model: News) {
        
        nameNewsTitle.text = model.nameNewsTitle
        dateNewsTitle.text = model.dateNewsTitle
    }
}
