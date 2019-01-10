//
//  ViewController.swift
//  DrawingApp
//
//  Created by Raul Mena on 1/3/19.
//  Copyright © 2019 Raul Mena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let canvas = Canvas()
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange(button:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange(button:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange(button:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    
    @objc fileprivate func handleSliderChange(){
        canvas.setStrokeWidth(width: slider.value)
    }
    
    @objc func handleColorChange(button: UIButton){
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)
    }
    
    @objc fileprivate func handleUndo(){
        canvas.undo()
    }
    
    @objc fileprivate func handleClear(){
        canvas.clear()
    }
    
    
    override func loadView() {
        self.view = canvas
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvas.backgroundColor = .white
        setupLayout()

    }
    
    fileprivate func setupLayout(){
        
        let colorStackView = UIStackView(arrangedSubviews: [redButton, blueButton, yellowButton])
        colorStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [undoButton, clearButton, colorStackView, slider])
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
    }


}

