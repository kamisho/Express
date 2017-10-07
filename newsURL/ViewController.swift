import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var taskTableView: UITableView!
    
    var txt1 : String?
    var selectedIndex = 0
    var tasks:[Task] = []
    var saveDates : [Date] = []
    var tasksToShow:[String:[String]] = ["投稿記事":[]]
    var taskCategories:[String] = ["投稿記事"]
    
    
    // taskCategories[]に格納されている文字列がTableViewのセクションになる
    func numberOfSections(in tableView: UITableView) -> Int {
        return taskCategories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return taskCategories[section]
    }
    
    // tasksToShowにカテゴリー（tasksToShowのキーとなっている）ごとのnameが格納されている
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksToShow[taskCategories[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let sectionData = tasksToShow[taskCategories[indexPath.section]]
        let cellData = sectionData?[indexPath.row]
        
        cell.textLabel?.text = "\(cellData!)"
        
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // CoreDataからデータをfetchしてくる
        getData()
        
        // を再読み込みする
        taskTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
        
    }
    
    // コアデータ(作成と削除)
    func getData() {
        
        // データ保存時と同様にcontextを定義
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        _ = appDelegate.persistentContainer.viewContext
        
        //        let query : NSFetchRequest<Task> = Task.fetchRequest()
        
        
        do {
            
            // CoreDataからデータをfetchしてtasksに格納
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "saveDate", ascending: false)]
            
            tasks = try context.fetch(fetchRequest)
            
            // tasksToShow配列を空にする。（同じデータを複数表示しないため）
            for key in tasksToShow.keys {
                tasksToShow[key] = []
            }
            // 先ほどfetchしたデータをtasksToShow配列に格納する
            for task in tasks {
                tasksToShow["投稿記事"]?.append(task.name!)
//                saveDates.append(task.saveDate! as Date)
                
                print(tasksToShow)
                
            }
        } catch {
            print("Fetching Failed.")
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            // 削除したいデータのみをfetchする
            // 削除したいデータのcategoryとnameを取得
            let deletedCategory = taskCategories[indexPath.section]
            let deletedName = tasksToShow[deletedCategory]?[indexPath.row]
            // 先ほど取得したcategoryとnameに合致するデータのみをfetchするようにfetchRequestを作成
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name = %@", deletedName!, deletedCategory)
            // そのfetchRequestを満たすデータをfetchしてtask（配列だが要素を1種類しか持たない）に代入し、削除する
            do {
                let task = try context.fetch(fetchRequest)
                context.delete(task[0])
            } catch {
                print("Fetching Failed.")
            }
            
            // 削除したあとのデータを保存する
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            // 削除後の全データをfetchする
            getData()
        }
        // taskTableViewを再読み込みする
        taskTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "showDetail") as! UraListViewController
        
        // メンバ変数に行番号を保存
        selectedIndex = indexPath.row
        nextVC.sIndex = selectedIndex
        
        print(String(selectedIndex) + "が選択されました")
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    
    
    
    // if コメントアウト UraListに受け渡し不可
    // if コメントアウト解除 新規追加不可
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 次の画面をインスタンス化(as:ダウンキャスト型変換)
        
        if segue.identifier == "showDetail"{
        
        let dvc = segue.destination as! UraListViewController
        
        // 次の画面のプロパティに選択された行番号を指定
        dvc.sIndex = selectedIndex

            
        }
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
