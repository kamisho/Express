import UIKit
import URLEmbeddedView
import MisterFusion
import CoreData

class SaveViewController: UIViewController {
    // override func prepare から引き継いでいる
    var txt1 : String?
    var txt2 : String?
    var txt3 : String?
    
    var tasks:[Task] = []
    var tasksToShow:[String:[String]] = ["投稿した記事":[]]
    var taskCategories:[String] = ["投稿した記事"]

    var text1:[String] = []
    var text2:[String] = []
    var text3:[String] = []
    
    var sIndex = -1
    var saveDate : Date = Date()
    
    let myApp = UIApplication.shared.delegate as! AppDelegate

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

        myLabel.font = UIFont(name: "HiraMinProN-W3", size: 20)
        myLabel.text = txt2
        
        myArticle.font = UIFont(name: "HiraMinProN-W3", size: 15)
        myArticle.text = txt3
        
        myOG.addLayoutSubview(embeddedView , andConstraints : embeddedView.top |+| 8 , embeddedView.right |-| 12 , embeddedView.left |+| 12 , embeddedView.bottom |-| 7.5)
        
        embeddedView.loadURL(txt1!)
        
    }
    
    @IBAction func urlTobu(_ sender: UITapGestureRecognizer) {
        
        if let url = NSURL(string: txt1!){
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    
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
        
    }
}
