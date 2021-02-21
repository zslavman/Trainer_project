//
//  QueueController.swift
//  JSON_Trainer
//
//  Created by Zinko Viacheslav on 21.02.2021.
//  Copyright © 2021 Zinko Viacheslav. All rights reserved.
//

import UIKit

class QueueController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Testing Queue"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Run", style: .plain,
                                                            target: self, action: #selector(onBttnTap))
        onBttnTap()
    }
    
    
    @objc private func onBttnTap() {
        print()
        run9()
    }
    
    private func run1() {
        let queue = DispatchQueue(label: "queue.google.com")
        queue.async {
            print("1", Thread.current)
        }
        queue.async {
            print("2", Thread.current)
        }
        queue.async {
            print("3", Thread.current)
        }
        queue.async {
            print("4", Thread.current)
        }
        print("5", Thread.current)
        /// 5 1 2 3 4 очень редко при загрузке 1 5 2 3 4 (ошибка?)
    }
    
    private func run2() {
        let queue = DispatchQueue(label: "queue.google.com", attributes: .concurrent)
        
        queue.async {
            print("1", Thread.current)
        }
        queue.async {
            print("2", Thread.current)
        }
        queue.async {
            print("3", Thread.current)
        }
        queue.async {
            print("4", Thread.current)
        }
        print("5", Thread.current)
        /// сначала 5, потом в любой последовательности
    }
    
    private func run3() {
        let queue = DispatchQueue(label: "queue.google.com")
        queue.sync {
            print("1")
        }
        queue.sync {
            print("2")
        }
        queue.sync {
            print("3")
        }
        queue.sync {
            print("4")
        }
        print("5")
        /// 1 2 3 4 5
    }
    
    private func run4() {
        let queue = DispatchQueue(label: "queue.google.com", attributes: .concurrent)
        queue.sync {
            print("1", Thread.current)
        }
        queue.async {
            print("2", Thread.current)
        }
        queue.sync {
            print("3", Thread.current)
        }
        queue.async {
            print("4", Thread.current)
        }
        print("5", Thread.current)
        /// 5 1 2 3 4
    }
    
    
    private func run5() {
        let queue = DispatchQueue(label: "queue.google.com")
        queue.async {
            print("1", Thread.current)
            
            DispatchQueue.main.async {
                print("2", Thread.current)
            }
            print("3", Thread.current)
        }
        queue.async {
            print("4", Thread.current)
        }
        print("5", Thread.current)
        /// 5 1 3 4 2
    }
    
    
    private func run6() {
        let queue = DispatchQueue(label: "queue.google.com")
        queue.async {
            print("1", Thread.current)
            
            queue.sync {
                // внешний блок ожидает завершения этого внутреннего блока,
                // внутренний блок не запускается до завершения внешнего блока
                // => deadlock
                print("2", Thread.current)
            }
            print("3", Thread.current)
        }
        queue.async {
            print("4", Thread.current)
        }
        print("5", Thread.current)
        /// 5 1, а дальше deadlock
    }
    
    private func run7() {
        let queue = DispatchQueue(label: "queue.google.com", attributes: .concurrent)
        queue.async {
            print("1", Thread.current)
            queue.async {
                print("2", Thread.current)
            }
            queue.sync {
                print("3", Thread.current)
            }
            DispatchQueue.main.async {
                print("4", Thread.current)
            }
            print("5", Thread.current)
        }
        /// 1 3 2 5 4 но не всегда
        
    }
    
    private func run8() {
        DispatchQueue.main.async {
            print("1", Thread.current)
            DispatchQueue.main.async {
                print("2", Thread.current)
            }
            DispatchQueue.main.async {
                print("3", Thread.current)
                DispatchQueue.main.async {
                    print("4", Thread.current)
                }
            }
            DispatchQueue.main.async {
                print("5", Thread.current)
            }
        }
        /// 1 2 3 5 4
    }
    
    
    private func run9() {
        let queue = DispatchQueue(label: "queue.google.com")
        queue.async {
            print("1", Thread.current)
            queue.async {
                print("2", Thread.current)
            }
            queue.async {
                print("3", Thread.current)
            }
            DispatchQueue.main.async {
                print("4", Thread.current)
            }
        }
        queue.async {
            print("5", Thread.current)
        }
        /// 1 5 2 3 4
    }

}
