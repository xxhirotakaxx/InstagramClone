import UIKit
import Firebase
import SVProgressHUD

class ComentViewController: UIViewController {
    
    var roomId:String!
    
    @IBOutlet weak var comentTextField: UITextField!
    
    @IBAction func addComentButton(_ sender: Any) {
        let name = Auth.auth().currentUser?.displayName
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        roomId = appDelegate.roomId
        
        let postRef = Database.database().reference().child(Const.PostCome).child(roomId)
        let postDic = ["name": name, "coment": comentTextField.text]
        postRef.childByAutoId().setValue(postDic)
        
        SVProgressHUD.showSuccess(withStatus: "コメントしました")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
