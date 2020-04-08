//
//  ViewController.swift
//  JSON_Trainer
//
//  Created by Zinko Viacheslav on 07.04.2020.
//  Copyright © 2020 Zinko Viacheslav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    internal var parsed = [PurchModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Testing smth."
        view.backgroundColor = .gray
        setupLayout()
        autoRunExe()
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
    
    private func autoRunExe() {
        run2()
    }
    
    
///*********************************************
    
    
    internal func run2() {
        let allCases = DeckTypes.allCases
        let allRaws = DeckTypes.allCases.map{ $0.rawValue }
        print()
    }
    
    
      
   
    
}
    
enum DeckTypes: Int, CaseIterable {
    case universal = 100 // 0
    case portrait   // 1
    case resource   // 2
    case text       // 3
    case photo      // 4
    case plot       // 5
    case mixed      // 6
    case art_reprod // 7
  
    var descript: String {
        switch self.rawValue {
        case 0: return "универсальная"
        case 1: return "портретная"
        case 2: return "ресурсная"
        case 3: return "текстовая"
        case 4: return "фотоколода"
        case 5: return "сюжетная"
        case 6: return "смешанная"
        case 7: return "репродукции картин"
        default: return "123"
        }
    }
}
