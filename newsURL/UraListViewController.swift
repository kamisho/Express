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
    
    var tasks:[Task] = []
    var tasksToShow:[String:[String]] = ["投稿した記事":[]]
    var taskCategories:[String] = ["投稿した記事"]
    
    var text1:[String] = []
    var text2:[String] = []
    var text3:[String] = []
    
    
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
        
        myLabel.font = UIFont(name: "HiraMinProN-W3", size: 20)
        myArticle.font = UIFont(name: "HiraMinProN-W3", size: 15)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UraListViewController.urlTobu(_:)))
        myOG.addGestureRecognizer(tapGestureRecognizer)
        myOG.isUserInteractionEnabled = true
       
        
        // OGカード配置
        myOG.addLayoutSubview(embeddedView , andConstraints : embeddedView.top |+| 8 , embeddedView.right |-| 12 , embeddedView.left |+| 12 , embeddedView.bottom |-| 7.5)
        
        getData()
        
    }
    
    
    @IBAction func urlTobu(_ sender: UITapGestureRecognizer) {
        
        // safariに移動させるためにはstring: 以降に保存されたurlの変数？をだに入試なければならない
        // string: 以降にURLを直接書き込むとそのURLリンクに飛ぶ
        if let url = NSURL(string: "http://nexseed.net/"){
            UIApplication.shared.openURL(url as URL)
        }
    }

    
    
    func getData() {
        
        // データ保存時と同様にcontextを定義
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        _ = appDelegate.persistentContainer.viewContext
        
        let query : NSFetchRequest<Task> = Task.fetchRequest()
        
        //        let namePredicte = NSPredicate(format: "saveDate = %@", saveDate as CVarArg)
        //        query.predicate = namePredicte
        
        
        do {
            
            tasks = try context.fetch(query)
            
            // tasksToShow配列を空にする。（同じデータを複数表示しないため）
            for key in tasksToShow.keys {
                tasksToShow[key] = []
            }
            // 先ほどfetchしたデータをtasksToShow配列に格納する
            
            print(tasks)
            
            for task in tasks {
                //                tasksToShow["投稿した記事"]?.append(task.name!)
                
                text1.append(task.name!)
                text2.append(task.article!)
                text3.append(task.url!)
            }
            
            let num1 = text1.count - sIndex - 1
            myLabel.text = text1[num1]
            
            let num2 = text2.count - sIndex - 1
            myArticle.text = text2[num2]
            
            // embeddedView.loadURL()はあっている - 問題は()の中身
            // url自体が保存されているかも不安
            let num3 = text3.count - sIndex - 1
            embeddedView.loadURL(text3[num3])
            print(embeddedView.loadURL(text3[num3]))

            
        } catch {
            print("Fetching Failed.")
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
