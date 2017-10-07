import UIKit
import CoreData
import URLEmbeddedView
import MisterFusion

class DetailViewController: UIViewController {
    @IBOutlet var myURL: UILabel!
    @IBOutlet var myTitle: UILabel!
    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var myTextView: UITextView!
    
    var task : [String] = []
    let myApp = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        makeKeybord()
        
        myURL.font = UIFont(name: "HiraMinProN-W3", size: 20)
        myTitle.font = UIFont(name: "HiraMinProN-W3", size: 20)
        
        let embeddedView = URLEmbeddedView()
        embeddedView.loadURL(myApp.newsURL)

        urlTextField.placeholder = "URL入力"
        titleTextField.placeholder = "タイトル入力"
        
    }
    
    
    @IBAction func plusBtn(_ sender: UIButton) {
        
        // アラート表示
        // TextFieldに何も入力されていない場合は何もせずに1つ目のビューへ戻ります。
        let urlName = urlTextField.text
        
        if urlName == "" {
            dismiss(animated: true, completion: nil)
            
            let alertController = UIAlertController(title: "URLを入力してください", message: "" , preferredStyle: .alert)
            
            // アラートにOKボタンを追加
            // handler : OKボタンが押された時に行いたい処理を指定する場所
            alertController.addAction(UIAlertAction(title: "OK" , style: .default, handler:nil))
            
            // アラートを表示する
            present(alertController , animated: true , completion : nil)
            
            return
            
        }
        
        let titleName = titleTextField.text
        if titleName == "" {
            dismiss(animated: true, completion: nil)
            
            let alertController = UIAlertController(title: "タイトルを入力してください", message: "" , preferredStyle: .alert)
            
            
            // アラートにOKボタンを追加
            // handler : OKボタンが押された時に行いたい処理を指定する場所
            alertController.addAction(UIAlertAction(title: "OK" , style: .default, handler:nil))
            
            
            // アラートを表示する
            present(alertController , animated: true , completion : nil)
            
            return
            
        }


        let articleName = myTextView.text
        if articleName == "" {
            dismiss(animated: true, completion: nil)
            
            let alertController = UIAlertController(title: "記事を入力してください", message: "" , preferredStyle: .alert)
            
            // アラートにOKボタンを追加
            // handler : OKボタンが押された時に行いたい処理を指定する場所
            alertController.addAction(UIAlertAction(title: "OK" , style: .default, handler:nil))
            
            
            // アラートを表示する
            present(alertController , animated: true , completion : nil)
            
            return
            
        }
        
        // context(データベースを扱うのに必要)を定義。
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // taskにTask(データベースのエンティティです)型オブジlェクトを代入します。
        // このとき、Taskがサジェストされない（エラーになる）場合があります。
        // 詳しい原因はわかりませんが、Runするか、すべてのファイルを保存してXcodeを再起動すると直るので色々試してみてください。
        
        let task = NSEntityDescription.entity(forEntityName: "Task", in: viewContext)
        
        let newRecord = NSManagedObject(entity: task!, insertInto: viewContext)
        // 先ほど定義したTask型データのname、categoryプロパティに入力、選択したデータを代入します。
        
        newRecord.setValue(titleTextField.text, forKey: "name")
        newRecord.setValue(myTextView.text, forKey: "article")
        newRecord.setValue(Date(), forKey: "saveDate")
        newRecord.setValue(urlTextField.text , forKey: "url")
        
        // 上で作成したデータをデータベースに保存します。
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //        dismiss(animated: true, completion: nil)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var SaveViewController = segue.destination as! SaveViewController
        SaveViewController.txt1 = urlTextField.text
        SaveViewController.txt2 = titleTextField.text
        SaveViewController.txt3 = myTextView.text
        
    }
    
    @IBAction func cancelBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
   
    // textViewのキーボードを下げる関数
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
        myTextView.inputAccessoryView = kbToolBar
    }
    
    func commitButtonTapped (){
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
