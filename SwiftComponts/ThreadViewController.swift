//
//  ThreadViewController.swift
//  SwiftComponts
//
//  Created by boob on 2017/6/26.
//  Copyright © 2017年 YY.COM. All rights reserved.
//http://blog.csdn.net/offbye/article/details/50748440

import UIKit
import HBKit

class ThreadViewController: HBBaseTableViewController {
    
    override func cs_titles() -> [String] {
        return ["【0】GCD的介绍",
                "【1】获取系统存在的全局队列",
                "【2】主线程",
                "【3】添加任务到队列【同步队列、异步队列】",
                "【4】暂停或继续队列",
                "【5】dispatch_one 一次性执行",
                "【6】延迟调用",
                "【7】线程组，任务队列，与完成通知",
                "【8】dispatch_apply指定次数的block追加到指定队列中",
                "【9】信号，信号量",]
    }
    
    override func cs_selectAction(cs: HBCellStruct) {
        if cs.key_indexpath == self.key_indexpath(0, row: 0) {
             self.introgcd()
        }else if cs.key_indexpath == self.key_indexpath(0, row: 1) {
            self.createglobalgcd()
        }
        else if cs.key_indexpath == self.key_indexpath(0, row: 2) {
            self.createmainqueue()
        }
        else if cs.key_indexpath == self.key_indexpath(0, row: 4){
            self.pauseorrsume()
        }
        else if cs.key_indexpath == self.key_indexpath(0, row: 7){
            self.queuegroup()
        }
        else if cs.key_indexpath == self.key_indexpath(0, row: 6){
            self.delayrun()
        }
        else if cs.key_indexpath == self.key_indexpath(0, row: 5){
            self.sharinstance()
        }
        
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cs_loadcsdata()
        // Do any additional setup after loading the view.
    }
    
    func introgcd() -> () {
        let intro = "GCD是Apple开发的一个多核编程的解决方法，基本概念就是dispatch queue（调度队列），queue是一个对象，它可以接受任务，并将任务以先到先执行的顺序来执行。dispatch queue可以是并发的或串行的。GCD的底层依然是用线程实现，不过我们可以不用关注实现的细节。其优点有如下几点：\n（1）易用：GCD比thread更简单易用。基于block的特效使它能极为简单地在不同代码作用域之间传递上下文。 \n（2）效率：GCD实现功能轻量，优雅，使得它在很多地方比专门创建消耗资源的线程更加实用且快捷。\n（3）性能：GCD自动根据系统负载来增减线程数量，从而减少了上下文切换并增加了计算效率。\n（4）安全：无需加锁或其他同步机制。"
        
        print(intro)
        
    }
    func createglobalgcd() -> () {
        
        let globalqueue:DispatchQueue = DispatchQueue.global()
        globalqueue.async {
            for idx in 1..<10
            {
                sleep(1)
               print("GT\tA:\(idx)")
            }
        }
        globalqueue.sync {
            for idx in 1..<10
            {
                sleep(1)
                print("GT\tB:\(idx)")
            }
        }
        globalqueue.sync {
            for idx in 1..<10
            {
                sleep(1)
                print("GT\tC:\(idx)")
            }
        }
    }
    
    func createmainqueue() -> () {
        
        //主线程的操作都是同步的？？？ 测试结果是顺序执行
        
        let mainqueue:DispatchQueue = DispatchQueue.main
       
        for idx in 1..<10
        {
            sleep(1)
            print("GM\t   Z:\(idx)")
        }
        
         mainqueue.async {
            for idx in 1..<10
            {
                sleep(1)
                print("GM\t A:\(idx)")
            }
            
            for idx in 1..<10
            {
                sleep(1)
                print("GM\t   A:\(idx)")
            }
        }
        
        mainqueue.async {
            for idx in 1..<10
            {
                sleep(1)
                print("GM\t B:\(idx)")
            }
        }
        
        
    }
    
    
    //MARK: 暂停或执行队列
    func pauseorrsume() -> () {
        
//        DispatchQueue.init(label: "concurrentqueue1")
        
        //concurrent 并发线程
        //默认同步线程
//        let queue:DispatchQueue = DispatchQueue(label: "processQueueName")
        
        let queue:DispatchQueue = DispatchQueue(label: "processQueueName", attributes: .concurrent)
        
        queue.async {
            for idx in 1..<5
            {
                sleep(1)
                print("⚪GM\t A:\(idx)")
            }
        }
        
        queue.async {
            for idx in 1..<5
            {
                sleep(1)
                print("🔴GM\t B:\(idx)")
            }
        }
         let time = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: time) {
            queue.suspend()
            print("暂停")
        }
        
        //暂停之后加入的任务
        let time3 =  DispatchTime.now() + .seconds(6)
        DispatchQueue.main.asyncAfter(deadline: time3) {
            queue.async {
                for idx in 1..<5
                {
                    sleep(1)
                    print("🔵GM\t F:\(idx)")
                }
            }
        }
        
        
        let time2 =  DispatchTime.now() + .seconds(15)
        DispatchQueue.main.asyncAfter(deadline: time2) {
            queue.resume()
            print("继续")
            queue.async {
                for idx in 1..<5
                {
                    sleep(1)
                    print("🔶GM\t E:\(idx)")
                }
            }
            
        }
        //异步任务
        queue.async {
            for idx in 1..<5
            {
                sleep(1)
                print("🔷GM\t C:\(idx)")
            }
        }
        
        
    }
    
    //MARK: 线程组,通知 🔴⚪🔴🔵🔻🔶🔷🔸🔹✖✔
    func queuegroup() -> () {
        
        let workItem:DispatchWorkItem = DispatchWorkItem.init {
            for idx in 1..<10
            {
                print("🔴GM\t A:\(idx)")
                sleep(1)
            }
        }
        
        let workItem2:DispatchWorkItem = DispatchWorkItem.init {
            for idx in 1..<5
            {
                print("🔵GM\t B:\(idx)")
                sleep(1)
            }
        }
        
        let workItem3:DispatchWorkItem = DispatchWorkItem.init {
            for idx in 1..<20
            {
                print("⚪GM\t B:\(idx)")
//                usleep(500)
                sleep(1)
            }
        }
        
        let queue:DispatchQueue = DispatchQueue(label: "processQueueName", attributes: .concurrent)
        
//        let queue:DispatchQueue = DispatchQueue(label: "workitemqueue", qos: .default)
        //attributes: .concurrent,target: nil
        let group:DispatchGroup = DispatchGroup.init();
        
        
        workItem2.notify(queue: queue) {
            print("任务二完成")
        }
        
        workItem.notify(queue: queue) {
            print("任务一完成")
        }
        
        workItem3.notify(queue: queue) {
            print("任务三完成")
        }
        
        queue.async(group: group, execute: workItem)
        
        queue.async(group: group, execute: workItem2)
        
        queue.async(group: group, execute: workItem3)
        
        
        group.notify(queue: queue) {
            print("任务全部完成")
        }
        
    }
    // 0⃣1⃣2⃣3⃣4⃣5⃣6⃣7⃣8⃣9⃣🔟
    
    
    //MARK: 延迟调用
    func delayrun() -> () {
        
        let queue = DispatchQueue.init(label: "delayrun")
        
        print("❗3 秒后执行下面的代码")
        queue.asyncAfter(wallDeadline: DispatchWallTime.now() + DispatchTimeInterval.seconds(3), execute: {
            for idx in 1...5
            {
                print("⚪GM\t B:\(idx)")
                sleep(1)
            }
            print("任务完成！")
        })
        
    }
    
    //MARK: 执行一次
    func sharinstance() -> () {
        
         self.presentAlert(msg: "请用static let")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


class TheOneAndOnlyKraken {
    static let sharedInstance = TheOneAndOnlyKraken()
    private init() {} //This prevents others from using the default '()' initializer for this class.
}

