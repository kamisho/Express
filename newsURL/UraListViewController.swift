//
//  UraListViewController.swift
//  newsURL
//
//  Created by Kamiya Shogo on 2017/10/03.
//  Copyright © 2017年 Shogo Kamiya. All rights reserved.
//

import UIKit
import URLEmbeddedView
import MisterFusion
import CoreData

class UraListViewController: UIViewController {

    // override func prepare から引き継いでいる
    var txt1 : String?
    var txt2 : String?
    var txt3 : String?

    let myApp = UIApplication.shared.delegate as! AppDelegate
    var sIndex = -1
    var saveDate : Date = Date()
    var embeddedView = URLEmbeddedView()

    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myArticle: UITextView!
    @IBOutlet var myOG: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        makeKeybord()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "urlTobu:")
        myOG.addGestureRecognizer(tapGestureRecognizer)
        myOG.isUserInteractionEnabled = true
        
        // テキスト配置
        myLabel.font = UIFont(name: "HiraMinProN-W3", size: 20)
        myLabel.text = txt2
        
        // 記事配置
        myArticle.font = UIFont(name: "HiraMinProN-W3", size: 15)
        myArticle.text = txt3
        
        // OGカード配置
        myOG.addLayoutSubview(embeddedView , andConstraints : embeddedView.top |+| 8 , embeddedView.right |-| 12 , embeddedView.left |+| 12 , embeddedView.bottom |-| 7.5)
        
//        embeddedView.loadURL(txt1!)
        
    }
    
    @IBAction func urlTobu(_ sender: UITapGestureRecognizer) {
        
        if let url = NSURL(string: myApp.newsURL){
            UIApplication.shared.openURL(url as URL)
        }

        
    }
   
    
    // キーボードを閉じる関数
    func makeKeybord(){
        // 仮のサイズでツールバー生成
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(DetailViewController.commitButtonTapped))
        
        kbToolBar.items = [spacer, commitButton]
        myArticle.inputAccessoryView = kbToolBar
    }
    
    func commitButtonTapped (){
        self.view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
