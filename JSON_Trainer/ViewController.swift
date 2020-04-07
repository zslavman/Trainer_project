//
//  ViewController.swift
//  JSON_Trainer
//
//  Created by Zinko Viacheslav on 07.04.2020.
//  Copyright © 2020 Zinko Viacheslav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Testing smth."
        view.backgroundColor = .gray
        setupLayout()
    }
    
    private func setupLayout() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Btn1", style: .plain,
                                                           target: self, action: #selector(onLeftBttnTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Btn2", style: .plain,
                                                            target: self, action: #selector(onRightBttnTap))
    }
    
    @objc private func onLeftBttnTap() {
        print(#function)
    }
    
    @objc private func onRightBttnTap() {
        print(#function)
    }

}

