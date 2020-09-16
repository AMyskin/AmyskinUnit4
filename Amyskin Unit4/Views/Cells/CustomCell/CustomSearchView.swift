//
//  CustomSearchView.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 05.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit

protocol CustomSearchViewDelegate: class {
    func CustomSearch(chars: String)
}

class CustomSearchView: UIView, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var leftTextConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var centerXImageConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leftCancelButtonConstaint: NSLayoutConstraint!
    
    
    
    
    
    
    weak var delegate: CustomSearchViewDelegate?
    
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var searchImage: UIImageView!
   
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchFieldText: UITextField!
    
    @IBAction func cancelButtonPushed(_ sender: UIButton) {
        
        searchFieldText.endEditing(true)
   
   
    }
    
 

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        
 
        
        
        
        // Этот метод для себя оставил чтобы не забыть, фукционала в данном случае тут нет
        Bundle.main.loadNibNamed("CustomSearchView", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = .clear
        contentView.frame = self.bounds
        contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth]
        
        
        searchFieldText.placeholder = "Поиск"
        searchFieldText.text = ""
        
        searchFieldText.delegate = self
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        guard let text = textField.text else {return false}
        searchFieldText.endEditing(true)
        delegate?.CustomSearch(chars: text)
        return true
    }
    
    
    

    
    
    
    func textFieldDidChangeSelection(_ textField: UITextField){
        guard let text = textField.text else {return}
        delegate?.CustomSearch(chars: text)
    }
    
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
            searchFieldText.translatesAutoresizingMaskIntoConstraints = false
            searchImage.translatesAutoresizingMaskIntoConstraints = false
           
           
                   centerXImageConstraint.constant = -(bounds.width / 2 - 20)
                   leftTextConstraint.constant = searchImage.bounds.width + 15
                   leftCancelButtonConstaint.constant = -70
                   
                   UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: [], animations: {
                       self.layoutIfNeeded()
                   }, completion: nil)
        
        return true
        
    }
    
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        centerXImageConstraint.constant = 0
        leftTextConstraint.constant =  15
        leftCancelButtonConstaint.constant = 90
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: [], animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        return true
    }
    
    
    
}
