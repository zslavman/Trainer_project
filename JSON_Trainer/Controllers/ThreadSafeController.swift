//
//  ThreadSafeController.swift
//  JSON_Trainer
//
//  Created by Zinko Viacheslav on 18.02.2021.
//  Copyright © 2021 Zinko Viacheslav. All rights reserved.
//

import UIKit

class ThreadSafeController: UIViewController {
    
    let queue = DispatchQueue(label: "arrayQueue", attributes: .concurrent) // (1) 9s
    //let queue = DispatchQueue(label: "arrayQueue")                        // (2) 12s
    private var _array = [Int]()
    private var array: [Int] {
        get {
            queue.sync {
                return _array
            }
        }
        set {
            queue.async(flags: .barrier) { // (1)
            //queue.sync {                 // (2)
                self._array = newValue
            }
        }
    }
    
    /**
     Обратите внимание, что у async метода установлен barrier флаг для записи. Это означает, что никакие другие блоки не могут быть запланированы из очереди, пока выполняется асинхронный / барьерный процесс. Мы продолжаем использовать этот  sync метод для чтения, но на этот раз все считыватели будут работать параллельно из-за атрибута concurrent queue
     
     Читатели все равно будут заблокированы, когда barrier процесс запущен. Даже если несколько блоков чтения уже работают параллельно, barrier процесс будет ждать завершения всех считывателей, прежде чем начать запись. Как только  barrier процесс будет завершен, читатели, стоящие за ним, снова смогут работать параллельно
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "PushMe", style: .plain,
                                                            target: self, action: #selector(onBttnTap))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.run()
        }
    }
    
    
    private func run() {
        TimeMeasure.start()
        DispatchQueue.concurrentPerform(iterations: 400001) {
            (index) in
            let last = array.last ?? 0
            array.append(last + 1)
            print(index)
        }
        TimeMeasure.stop()
    }
    
    
    @objc private func onBttnTap() {
        print(#function)
    }

}
    

//MARK: - Some

class Some {
    
    private let queue = DispatchQueue(label: "deckSearchThread", qos: .userInteractive, attributes: .concurrent)
    private var dispatchWorkItems = [DispatchWorkItem]()
    
    private func doSmth() {
        let group = DispatchGroup()
        let item1 = DispatchWorkItem(block: {
            //task1
        })
        let item2 = DispatchWorkItem(block: {
            //task2
        })
        dispatchWorkItems.append(item1)
        dispatchWorkItems.append(item2)
        queue.async(group: group, execute: item1)
        queue.async(group: group, execute: item2)
        group.wait()
        
    }
    
}
