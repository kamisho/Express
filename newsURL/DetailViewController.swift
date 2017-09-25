import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var myURL: UILabel!
    @IBOutlet var myTitle: UILabel!
    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var myTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myURL.font = UIFont(name: "HiraMinProN-W3", size: 25)
        myTitle.font = UIFont(name: "HiraMinProN-W3", size: 25)
        
        urlTextField.placeholder = "URL入力"
        titleTextField.placeholder = "タイトル入力"

        
    }
    
    
    @IBAction func submitBtn(_ sender: UIButton) {
     
        let urlName = urlTextField.text!
        
        if urlName == ""{
            dismiss(animated: true, completion: nil)

        
        let alertController = UIAlertController(title: "URLを入力してください", message: "", preferredStyle: .alert)
        
        // アラートにOKボタン追加
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
            // アラート表示
            present(alertController , animated: true , completion: nil)

            return
        }
        
        
        let titleName = titleTextField.text!
        
        if titleName == ""{
            dismiss(animated: true, completion: nil)
        
        let alertController = UIAlertController(title: "タイトルを入力してください", message: "", preferredStyle: .alert)
        
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alertController , animated : true , completion : nil)
        
            return
            
        }
        
        
        let textView = myTextView.text
        
        if textView == ""{
            dismiss(animated: true, completion: nil)
        
        let alertController = UIAlertController(title: "記事を入力してください", message: "", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
            present(alertController , animated : true , completion : nil)
        
            return
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
