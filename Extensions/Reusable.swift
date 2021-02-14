//
//  Reusable.swift
//  JSON_Trainer
//
//  Created by Zinko Viacheslav on 14.02.2021.
//  Copyright © 2021 Zinko Viacheslav. All rights reserved.
//

import Foundation


protocol Reusable: class {
    static var reuseID: String { get }
}

extension Reusable {
    static var reuseID: String {
        let identif = String(reflecting: self).replacingOccurrences(of: "JSON_Trainer.", with: "")
        return identif
    }
}
