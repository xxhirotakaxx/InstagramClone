import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class WatchComentViewController: UIViewController,
                                 UITableViewDelegate,
                                 UITableViewDataSource {
    var coments: [ComentData] = []
    var roomId: String!

    @IBOutlet weak var tableView: UITableView!
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.allowsSelection = false
        
        let nib = UINib(nibName: "ComentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UIScreen.main.bounds.width + 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        roomId = appDelegate.roomId
        
        let postsRef = Database.database().reference().child(Const.PostCome).child(String(roomId))
        postsRef.observe(.childAdded, with: {(snapshot) in
            let comentData = ComentData(snapshot: snapshot)
            self.coments.insert(comentData, at: 0)
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ComentTableViewCell
        cell.setComentData(coments[indexPath.row])
        
        return cell
    }

}
