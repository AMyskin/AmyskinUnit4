//
//  CharPicker.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 24.06.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit


protocol CharDelegate: class {
    func charPushed(char: String)
}

class CharPicker: UIView {
    
    weak var delegate: CharDelegate?
    
    var chars: [String] = "abcdefghijklmnopqrstuvwxyz".map { String($0) } {
        didSet {
            setupButtons()
        }
    }
    
    // MARK: - Views
    
    var buttons: [UIButton] = []
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var lastPressedButton: UIButton?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    

    
    private func setup() {
        setupButtons()
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        ])
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panRecognizer))
        addGestureRecognizer(pan)

    }
    
    private func setupButtons() {
        buttons.forEach { $0.removeFromSuperview() }
        buttons = []
        lastPressedButton = nil
        
        for char in chars {
            let button = UIButton(type: .system)
            button.setTitle(char.uppercased(), for: .normal)
            button.addTarget(self, action: #selector(charTapped), for: .touchDown)
            buttons.append(button)
            //            button.layer.borderWidth = 1
            //            button.layer.borderColor = UIColor.red.cgColor
            stackView.addArrangedSubview(button)
            button.heightAnchor.constraint(equalToConstant: 17).isActive = true
        }
    }
    
  

    
    @objc func panRecognizer(_ recognizer: UIPanGestureRecognizer) {
        
        let anchorPoint = recognizer.location(in: stackView)
        //print(anchorPoint)
        let buttonHeight = stackView.bounds.height / CGFloat(buttons.count)
        //print(buttonHeight)
        //print(buttons.count)
        var buttonIndex = Int(anchorPoint.y / buttonHeight)
        unhiglightButtons()
        if buttonIndex >= buttons.count {
            buttonIndex = buttons.count-1
        } else  if buttonIndex <= 0 {
            buttonIndex = 0
        }
        let button = buttons[buttonIndex]
        button.isHighlighted = true
        charTapped(button)
        
        if recognizer.state == .ended {
            unhiglightButtons()
        }
        

    }
    
    private func unhiglightButtons() {
        buttons.forEach { $0.isHighlighted = false }
    }

    
    @objc func charTapped(_ sender: UIButton) {
        guard lastPressedButton != sender else { return }
        lastPressedButton = sender
        let char = sender.title(for: .normal) ?? ""
        delegate?.charPushed(char: char)
        
        
    }
    
    
    
}
