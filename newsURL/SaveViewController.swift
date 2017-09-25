import UIKit

class SaveViewController: UIViewController {
    
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myArticle: UITextView!
    @IBOutlet var myOG: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        myLabel.font = UIFont(name: "HiraMinProN-W3", size: 30)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
