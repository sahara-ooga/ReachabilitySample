//
//  ViewController.swift
//  PlayReachability
//
//  Created by yuu ogasawara on 2017/06/06.
//  Copyright © 2017年 stv. All rights reserved.
//  参考：https://github.com/ashleymills/Reachability.swift

import UIKit

class ViewController: UIViewController {

    var reachability:AMReachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureReachability()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        reachability?.stopNotifier()
    }

    func configureReachability() {
        
        //Swift３でReachabilityクラスの初期化の記述が変更された。
        reachability = AMReachability()
        
        //接続可能性を調べる
        guard let reachability = reachability else {
            return
        }
        
        if reachability.isReachable == true {
            print("インターネット接続あり")
        } else {
            print("インターネット接続なし")
        }
        
        //接続ステータスが変化した時の挙動の設定の仕方
        //ここではクロージャを使用している。Notificationを使ったやり方はGithub参照。
        reachability.whenReachable = { reachability in
            
            //このクロージャはバックグラウンドで実行されるので、
            //UI周りは明示的にメインスレッドで実行するように指定する
            DispatchQueue.main.async {
                
                print("インターネット接続ありになった時の処理")

                //Wifiであるかどうかも検出できる
                if reachability.isReachableViaWiFi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
                print("")
            }
            
        }
        
        reachability.whenUnreachable = { reachability in
            
            DispatchQueue.main.async {
                
                print("Not reachable")
                print("インターネット接続なしになった時の処理")
                print("")
            }
        }
        
        //通信状況の監視を開始
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
 
    }
}

