//
//  TimeMeasure.swift
//  JSON_Trainer
//
//  Created by Zinko Viacheslav on 18.02.2021.
//  Copyright © 2021 Zinko Viacheslav. All rights reserved.
//

import UIKit

/// Measure time interval between 2 calls (start() and stop())
class TimeMeasure {
    
    private static var timeMark1: Double = 0
    
    /// Set 1-st time marker
    /// - Parameter descript: marker description if need (name of some method, e.g.)
    static func start(_ descript: String? = nil) {
        timeMark1 = Date().timeIntervalSince1970
        if let safeDescript = descript {
            print(safeDescript)
        }
    }
    
    
    /// Set 2-nd time marker
    /// - Parameter descript: marker description if need (name of some method, e.g.)
    static func stop(_ descript: String? = nil) {
        let timeMark2 = Date().timeIntervalSince1970
        let delta = timeMark2 - timeMark1
        let t2name = (descript == nil) ? "" : " for " + "'" + descript! + "'"
        print("execution time\(t2name) = \(delta)s")
    }
    
}
