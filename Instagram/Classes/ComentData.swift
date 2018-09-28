import UIKit
import Firebase
import FirebaseDatabase

class ComentData: NSObject {
    var id: String?
    var name: String?
    var coment: String?
    
    init(snapshot: DataSnapshot) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        self.name   = valueDictionary["name"] as? String
        self.coment = valueDictionary["coment"] as? String
    }
}
