//
//  SecondCell.swift
//  JSON_Trainer
//
//  Created by Zinko Viacheslav on 14.02.2021.
//  Copyright © 2021 Zinko Viacheslav. All rights reserved.
//

import UIKit


class SecondCell: UICollectionViewCell, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(color: UIColor) {
        backgroundColor = color
    }
    
}
