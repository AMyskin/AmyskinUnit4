//
//  NewsPostCell.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 27.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

protocol NewsPostCellDelegate: class {
    func didTapShowMore(cell: NewsPostCell)
}

final class NewsPostCell: NewsBaseCell {
    
    weak var delegate: NewsPostCellDelegate?
    
    var isExpanded = false {
        didSet {
            updatePostLabel()
            updateShowMoreButton()
        }
    }
    
    //var textHightConstraint: NSLayoutConstraint?
    
    lazy var stackTextView = UIStackView()
    lazy var textView = UILabel()
    lazy var button = UIButton(type: .custom)
    //lazy var textButton = UIButton()
    
    override func setup() {
        super.setup()
        
        stackTextView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 17)
        updatePostLabel()
        
       // textHightConstraint = textView.heightAnchor.constraint(equalToConstant: 200)
       // textHightConstraint?.isActive = true
      
        
        containerView.addSubview(stackTextView)
        //stackTextView.anchor(in: containerView)
        
        NSLayoutConstraint.activate([
                stackTextView.topAnchor.constraint(equalTo: containerView.topAnchor),
                stackTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
               stackTextView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
               stackTextView.rightAnchor.constraint(equalTo: containerView.rightAnchor)
           ])
        
        
        stackTextView.addArrangedSubview(textView)
        setupButton()
        
        
        
        
        stackTextView.axis = .vertical
        stackTextView.spacing = 8
        stackTextView.alignment = .leading
        stackTextView.distribution = .fill
        
        
        
        
        
        
    }
    
    func setupButton() {
        
        updateShowMoreButton()
        
        //button.setTitle("Show more", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        //button.tintColor = UIColor.black
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                          //  button.layer.borderWidth = 1
                          //  button.layer.borderColor = UIColor.red.cgColor
        stackTextView.addArrangedSubview(button)
        
        
        button.layer.cornerRadius = 0.5 * button.bounds.size.height
        button.layer.shadowOffset = CGSize(width: 6, height: 6)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 6
        
        //button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        //button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        //button.clipsToBounds = true
        //button.backgroundColor = UIColor.systemGray
        
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        
        
        delegate?.didTapShowMore(cell: self)
        
        
    }
    private func updatePostLabel(){
        textView.numberOfLines = isExpanded ? 0 : 10
    }
    private func updateShowMoreButton() {
        let title = isExpanded ? "Show less..." : "Show more..."
        button.setTitle(title, for: .normal)
        
    }
    
    override func configure(item: NewsItem, dateFormatter: DateFormatter) {
        super.configure(item: item, dateFormatter: dateFormatter)
        
        textView.text = item.text
        //textView.numberOfLines = 0
        let textSize = getLabelSize(text: item.text ?? "", font: textView.font)
       
            
        button.isHidden = textSize.height < 200
        
        
    }
    
    func getLabelSize(text: String, font: UIFont) -> CGSize {
        let maxWidth = bounds.width - 16 * 2
        let textBlock = CGSize(width: maxWidth,
                               height: CGFloat.greatestFiniteMagnitude)
        
        let rect = text.boundingRect(
            with: textBlock,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        
        let width = Double(rect.width)
        let height = Double(rect.height)
        
        let size = CGSize(width: ceil(width), height: ceil(height))
        //        let size = CGSize(width: width, height: height)
        
        return size
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = ""
        isExpanded = false
        //textHightConstraint?.constant = 0
        //containerView.removeFromSuperview()


    }
    
}

extension UIView {
    
    func anchor (in view: UIView, padding: CGFloat = 0) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding)
        ])
    }
}
