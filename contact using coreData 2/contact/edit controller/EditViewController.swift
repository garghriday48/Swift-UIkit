//
//  EditViewController.swift
//  contact
//
//  Created by Hriday on 03/03/23.
//

import UIKit

struct TextFieldModel1 {
    var phnTextField: [String]
    
    init(textData: [String]) {
        phnTextField = textData
    }
}

class EditViewController: UIViewController, UITextFieldDelegate {

//MARK: PROPERTIES
    
    @IBOutlet weak var editFirstName: UITextField!
    
    @IBOutlet weak var editSecondName: UITextField!
    
    @IBOutlet weak var editTableView: UITableView!
    
    @IBOutlet weak var personImage: UIImageView!
    
    private let allContacts: ContactData = ContactData()
    var contactToEdit: Contacts? = nil
    var identity2: UUID!
    
    
    var firstName: String?
    var secondName: String?
    var numbers: [String]?
    var index: IndexPath?
    
    var labelForNum = ["Home", "Work", "Extra"]
    var editCells: [EditTableViewCell2?] = [nil]
    
    var newFirstName: UITextField?
    var newSecondName: UITextField?
    
    var phoneTextField: UITextField?
    
    var someTextFIeld: UITextField!
    
    var dataModel1 = [TextFieldModel1]()
    
    var row: Int!
    
//MARK: METHODS

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        
        contactToEdit = allContacts.get(byIdentifier: identity2)
        firstName = contactToEdit?.firstName
        secondName = contactToEdit?.secondName
        numbers = contactToEdit?.mobile
        for _ in 0..<1 { dataModel1.append(TextFieldModel1( textData: numbers!)) }
        
        row = numbers!.count + 1
        
        editFirstName.text = firstName
        editSecondName.text = secondName
        
        newFirstName = editFirstName!
        newSecondName = editSecondName
        
        [editFirstName, editSecondName].forEach({$0?.addTarget(self, action: #selector(textEditing), for: .editingChanged)})
        
        personImage.layer.cornerRadius = 100
        editFirstName.layer.cornerRadius = 10
        editSecondName.layer.cornerRadius = 10
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneContact))
        navigationItem.rightBarButtonItem?.isEnabled = false
        editTableView.isEditing = true
        editTableView.allowsSelectionDuringEditing = true
        
        
        let center:NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardShown(notificaton:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardHidden(notificaton:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func textEditing( _ textField: UITextField){
        if textField.text == firstName && textField == editFirstName{
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        else if textField.text == secondName && textField == editSecondName{
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }

    override func viewDidLayoutSubviews() {
        editTableView.heightAnchor.constraint(equalToConstant:CGFloat(200)).isActive = true
    }
    
    //MARK: Method to perform Done button action
    @objc func doneContact(){
        self.view.endEditing(true)
        
        let updateFirstName = newFirstName!.text
        let updateSecondName = newSecondName!.text

        var newArray: [String] = []
        for val in dataModel1[0].phnTextField{
            if val != ""{
                newArray.append(val)
            }
        }
        let phnNumber = newArray
        allContacts.update(contact: Contacts(firstName: updateFirstName!, secondName: updateSecondName!, mobile: phnNumber, id: identity2))
            
        dismiss(animated: true, completion: nil)

        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardShown(notificaton:Notification){
        let info:NSDictionary = notificaton.userInfo! as NSDictionary
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.height - keyboardSize.height
        let editingTextFieldY = someTextFIeld.convert(someTextFIeld.bounds, to: self.view).minY
        if self.view.frame.minY >= 0{
            if editingTextFieldY > keyboardY - 20{
                UIView.animate(withDuration: 0.25, delay: 0.0) {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY - (keyboardY - 100)), width: self.view.bounds.width, height: self.view.bounds.height)
                }
            }
        }
    }
    
    //MARK: objc method when keyboard is hidden
    @objc func keyboardHidden(notificaton:Notification){
        UIView.animate(withDuration: 0.25, delay: 0.0) {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        someTextFIeld = textField
    }
    
    //MARK: method to hide keyboard when return button pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        
    
}

//MARK: Extension of Edit view controller
extension EditViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if row - 1 == indexPath.row {
            let cell = editTableView.dequeueReusableCell(withIdentifier: "addNumber1", for: indexPath) as! EditTableViewCell1
            cell.addPhoneLabel.text = "Add phone"
            return cell
        }
        else{
            let secondCell = editTableView.dequeueReusableCell(withIdentifier: "infoNumber1", for: indexPath) as! EditTableViewCell2
            editCells.insert(secondCell, at: 0)
            secondCell.editPhoneLabel.text = labelForNum[indexPath.row]
            secondCell.editPhoneTextField.text = dataModel1[0].phnTextField[indexPath.row]
            secondCell.editPhoneTextField.delegate = self
            secondCell.editPhoneTextField.tag = indexPath.row
            phoneTextField = secondCell.editPhoneTextField
            return secondCell
        }
        
        return UITableViewCell()
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if row - 1 == indexPath.row {
            if numbers!.count < 3{
                navigationItem.rightBarButtonItem?.isEnabled = true
                dataModel1[0].phnTextField.append("")
                row += 1
            }
            else if dataModel1[0].phnTextField.count == 3{
                let action = UIAlertController(title: "Phone Numbers", message: "Can have 3 phone numbers", preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "OK", style: .default)
                action.addAction(okAction)
                self.present(action, animated: true)
            }
            else if dataModel1[0].phnTextField == numbers!{
                navigationItem.rightBarButtonItem?.isEnabled = false
            }
            
            editTableView.reloadData()
        }
        
    }
    
    //MARK: Method to specify editing styles of each cell
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if row - 1 == indexPath.row {
            return .insert
            
        }
        return .delete
        
    }
    
    //MARK: Method to perform actions based on editing styles
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert {
            if dataModel1[0].phnTextField.count < 3{
                dataModel1[0].phnTextField.append("")
                navigationItem.rightBarButtonItem?.isEnabled = true
                row += 1
            }
            else if dataModel1[0].phnTextField.count == 3{
                let action = UIAlertController(title: "Phone Numbers", message: "Can have 3 phone numbers", preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "OK", style: .default)
                action.addAction(okAction)
                self.present(action, animated: true)
            }
            else if dataModel1[0].phnTextField == numbers!{
                navigationItem.rightBarButtonItem?.isEnabled = false
            }
            
            editTableView.reloadData()
        }
        
        else if editingStyle == .delete{
            self.view.endEditing(true)
            navigationItem.rightBarButtonItem?.isEnabled = true
            row -= 1
            editCells.remove(at: row)
            dataModel1[0].phnTextField.remove(at: indexPath.row)
            editTableView.reloadData()
            
            if dataModel1[0].phnTextField == numbers!{
                navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let index = NSIndexPath(row: textField.tag,section : 0)
        if editFirstName.text == "" && editSecondName.text == "" && phoneTextField?.text == ""{
            navigationItem.rightBarButtonItem?.isEnabled = false
        }else{
            if textField != editFirstName && textField != editSecondName{
                if textField.text == dataModel1[0].phnTextField[index.row]{
                    navigationItem.rightBarButtonItem?.isEnabled = false
                }
                else{
                    navigationItem.rightBarButtonItem?.isEnabled = true
                }
            }
        }
         
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index = NSIndexPath(row: textField.tag,section : 0)
        if textField != editFirstName && textField != editSecondName{
            if let _ = editTableView.cellForRow(at: index as IndexPath) as? EditTableViewCell2{
                if textField.tag == index.row{
                    dataModel1[0].phnTextField[index.row] = (textField.text ?? numbers![index.row])
                }
            }
        }
    }
}
