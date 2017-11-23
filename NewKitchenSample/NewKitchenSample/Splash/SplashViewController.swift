import UIKit

class SplashViewController: UIViewController {
    
    // enum - 列挙体
    enum ResultKey : String{
        case information = "Information"
        case coupon = "Coupon"
        case menu = "Menu"
        case news = "News"
        case review = "Review"
        case like = "Like"
    }
    
    // private の変数宣言 - 辞書型
    private var results = Dictionary<ResultKey , Bool>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 関数を定義してから読み込まれる
        self.createUserId()
        self.refresh()
    }
    
    private func createUserId(){
        
        let saveData = SaveData.shared
        let saveData.userId.characters.count == 0 {
            saveData.userId = UIDevice.current.identifierForVendor?.uuidString ?? ""
            saveData.save()
        }
    }
    
    private func refresh(){
        self.results.removeAll()
        
        InformationRequester.shared.fetch(completion : {weak self] (result)} in self )
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
