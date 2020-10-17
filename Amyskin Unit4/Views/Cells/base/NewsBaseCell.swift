//
//  NewsBaseCell.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 27.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

class NewsBaseCell: UITableViewCell {
    
    static let inset: CGFloat = 16
    
    lazy var stackView = UIStackView()
    lazy var headerView = NewsHeaderView()
    lazy var containerView = UIView()
    lazy var footerView = NewsFooterView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        selectionStyle = .none
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        stackView.anchor(in: contentView, padding: Self.inset)
   
        
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(containerView)
        stackView.addArrangedSubview(footerView)
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        containerView.clipsToBounds = true
    }
    
    func configure(item: NewsItem, dateFormatter: DateFormatter) {
        headerView.configure(item: item, dateFormatter: dateFormatter)
        footerView.configure(item: item)
    }
    
}
