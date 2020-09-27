//
//  NewsPostCell.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 27.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

final class NewsPostCell: NewsBaseCell {
    
    var textHightConstraint: NSLayoutConstraint?
    
    lazy var stackTextView = UIStackView()
    lazy var textView = UILabel()
    lazy var button = UIButton(type: .system)
    //lazy var textButton = UIButton()
    
    override func setup() {
        super.setup()
        
        stackTextView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 17)
        textView.numberOfLines = 0
        
        textHightConstraint = textView.heightAnchor.constraint(equalToConstant: 200)
        textHightConstraint?.isActive = true
      
        
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
        stackTextView.alignment = .fill
        stackTextView.distribution = .fill
        
        
        
        
        
        
    }
    
    func setupButton() {
        
        
        
        button.setTitle("Show more", for: .highlighted)
        button.tintColor = UIColor.systemBlue
        button.backgroundColor = UIColor.systemGray
        button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
                            button.layer.borderWidth = 1
                            button.layer.borderColor = UIColor.red.cgColor
        stackTextView.addArrangedSubview(button)
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
       // button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        //contentView.layoutIfNeeded()
        let textSize = getLabelSize(text: textView.text ?? "", font: textView.font)
        if sender.isSelected {
            
           
            textHightConstraint?.constant = textSize.height
            
            button.setTitle("Show less", for: .normal)
            //contentView.layoutIfNeeded()
        } else {

            textHightConstraint?.constant = 200
            
            button.setTitle("Show more", for: .normal)
 
            
            //contentView.layoutIfNeeded()
        }
        
        
        
        
    }
    
    override func configure(item: NewsItem, dateFormatter: DateFormatter) {
        super.configure(item: item, dateFormatter: dateFormatter)
        
        textView.text = item.text
        //textView.numberOfLines = 0
        let textSize = getLabelSize(text: item.text ?? "", font: textView.font)
        if textSize.height < 200 {
            textHightConstraint?.constant = textSize.height
            
            button.isHidden = true
        } else {
            textHightConstraint?.constant = 200
            
            
            button.isHidden = false
        }
        
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
        textHightConstraint?.constant = 0
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
