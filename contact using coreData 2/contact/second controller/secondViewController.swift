

import UIKit

//protocol doneButton{
//    func comingBack(fname: String, sname: String, phnNum: [String])
//}

class secondViewController: UIViewController {
    
    
//MARK: PROPERTIES
    
    @IBOutlet var contactName: UILabel!
    
    @IBOutlet weak var messageBox: UIView!
    @IBOutlet weak var phoneBox: UIView!
    @IBOutlet weak var mailBox: UIView!
    
    
    @IBOutlet weak var phoneTableView: UITableView!
    
    private let allContacts: ContactData = ContactData()
    var updatedContact: Contacts? = nil
    
    var coName: (String?,[String])?
    var indexp: (IndexPath,ViewController)?
    var text: UITextField?
    var identity: UUID!
    
    var aNameText: UITextField?
    var aMobileText: UITextField?
    
    var labelArray = ["home", "work", "extra"]
    
    var fName: String?
    var sName: String?
    
    
//MARK: METHODS
    override func viewWillAppear(_ animated: Bool) {
        updatedContact = allContacts.get(byIdentifier: identity)
        fName = updatedContact?.firstName ?? ""
        sName = updatedContact?.secondName ?? ""
        coName?.1 = updatedContact?.mobile ?? [""]
        identity = updatedContact?.id
        contactName.text = String((fName ?? "") + " " + (sName ?? ""))
        phoneTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteContact)),
            UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editContact)),
            
        ]
        contactName.text = String((fName ?? " ") + " " + (sName ?? " "))
        
        
        messageBox.layer.cornerRadius = 10
        phoneBox.layer.cornerRadius = 10
        mailBox.layer.cornerRadius = 10
        
        phoneTableView.layer.cornerRadius = 10
        
    }
    override func viewDidLayoutSubviews() {
        phoneTableView.heightAnchor.constraint(equalToConstant:CGFloat((3)*60)).isActive = true
    }
    
    //MARK: To delete contact
    @objc func deleteContact(){

        let alert2 = UIAlertController(title: "Delete", message: "Are you Sure?", preferredStyle: .alert)
        
        let remove = UIAlertAction(title: "Remove", style: .default){ (deleteAction) in
            
            self.allContacts.delete(record: self.identity)
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        alert2.addAction(remove)
        alert2.addAction(cancel)
        
        self.present(alert2, animated: true, completion: nil)
        
    }
    
    //MARK: Function to send data to edit controller
    @objc func editContact(){
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        editVC.identity2 = identity
        
        navigationController?.pushViewController(editVC, animated: true)
        
    }
}
 
//MARK: Extension of Second view controller

extension secondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (coName?.1.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = phoneTableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! SecondTableViewCell
        //cell.layer.backgroundColor = CG
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = phoneTableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! SecondTableViewCell
        cell.numberType.text = labelArray[indexPath.row]
        print(coName?.1.count)
        cell.phoneNumber.text = coName?.1[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        phoneTableView.reloadRows(at: [indexPath], with: .fade)
    }
    //MARK: Method to set height for rows in tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
