import UIKit

class ViewController: UIViewController,UISearchBarDelegate, UISearchControllerDelegate{
    
    
    
    //MARK: PROPERTIES
    
    @IBOutlet var searchBarText: UISearchBar!
    var filteredData = [Contacts]()
    var alphabets = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    @IBOutlet var myTable: UITableView!
    
    @IBOutlet weak var searchBar: NSLayoutConstraint!
    
    
    private let allContacts: ContactData = ContactData()
    var contactArray = [Contacts]()
    
    var staticData = Data()
    var sectionTitle = [String]()
    var contactDict = [String:[Contacts]]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewWillAppear(_ animated: Bool) {
        staticData.makeArray()
        contactArray = staticData.contactsArray
        makeDict(in: contactArray)
        
        self.myTable.reloadData()
    }
    
    //MARK: METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        
        self.navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCountry))
        configureSearchController()
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Search Contacts"
        
    }
    
    func makeDict(in contact: [Contacts]){
        
        var section = [String]()
        var cond = false
        for i in contact{
            for j in 0..<10{
                if String(i.getFullName().prefix(1)) == String(j){
                    cond = true
                }
            }
            if i.getFullName() != "" && cond == false{
                section.append(String(i.getFullName().prefix(1)))
            }

        }
        
        sectionTitle = Array(Set(section))
        sectionTitle.sort()
        sectionTitle.append("#")

        
        
        for stitle in sectionTitle{
            contactDict[stitle] = [Contacts]()
        }
        
        for cont in contact{
            var cond = false
            for i in 0..<10{
                if String(cont.getFullName().prefix(1)) == String(i){
                    contactDict["#"]?.append(cont)
                    cond = true
                }
            }
            if cont.getFullName() != "" && cond == false{
                contactDict[String(cont.getFullName().prefix(1))]?.append(cont)
            }
            else if cond == false{
                contactDict["#"]?.append(cont)
            }
            
        }
        for (key, _) in contactDict {
            contactDict[key] = contactDict[key]?.sorted(by: {
                if key != "#"{
                    return $0.getFullName().uppercased() < $1.getFullName().uppercased()
                }
                else{
                    if $0.getFullName() == "" && $1.getFullName() == ""{
                       return $0.mobile[0] < $1.mobile[0]
                    }
                    else{
                       return $0.getFullName() < $1.getFullName()
                    }
                }
                
            })
        }
        
    }
    
    
    
    //MARK: for + button
    @objc func addCountry(){
        performSegue(withIdentifier: "addSegue", sender: nil)
    }

    //MARK: Unwind segue from addViewController
    @IBAction func unwindToFirst(_ sender: UIStoryboardSegue){}
}
    
         
         
         
//MARK: Extension of Viewcontroller class where all tableView methods are present

extension ViewController:UITableViewDataSource, UITableViewDelegate {
    
         
         //MARK: for number of rows in sections in table
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return contactDict[sectionTitle[section]]?.count ?? 0
         }
         
    
        //MARK: To display cell in tableview
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         let fullName = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].getFullName()
             if fullName != ""{
                 cell.textLabel?.text = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].getFullName()
             }
             else{
                 cell.textLabel?.text = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].mobile[0]
             }
         return cell
         }
    
         //MARK: for number of sections in table
         func numberOfSections(in tableView: UITableView) -> Int {
         return sectionTitle.count
         }
         
         //MARK: to display all the sections on the right side
         func sectionIndexTitles(for tableView: UITableView) -> [String]? {
         return alphabets
         }
    
         func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
             guard let mainTitle = sectionTitle.firstIndex(where: { $0 == title}) else{
                 guard let secondTitle = sectionTitle.firstIndex(where: { $0 > title }) else{
                     return 0
                 }
                 return secondTitle - 1
             }
             return mainTitle
         }
    
         //MARK: to display section name on header
         func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return sectionTitle[section]
         }
         
         //MARK: Method to perform action when selecting row
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
             secondVC.coName = (contactDict[sectionTitle[indexPath.section]]?[indexPath.row].getFullName(),contactDict[sectionTitle[indexPath.section]]![indexPath.row].mobile)
             secondVC.fName = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].firstName
            secondVC.sName = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].secondName
             secondVC.indexp = (indexPath,self)
             secondVC.identity = contactDict[sectionTitle[indexPath.section]]![indexPath.row].id
         self.navigationController?.pushViewController(secondVC, animated: true)
         
         
         }
}
      
//MARK: Extension of Viewcontroller class where all Search Bar methods are present

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if searchText != ""{
            filteredData = contactArray.filter{$0.getFullName().contains(searchText)}
            makeDict(in: filteredData)
            myTable.reloadData()
        }
        else{
           filteredData = contactArray
           makeDict(in: filteredData)
        myTable.reloadData()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredData = contactArray
        makeDict(in: filteredData)
     myTable.reloadData()
    }
}
extension UIViewController{
    func hideKeyboard(){
        let tapping = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tapping.cancelsTouchesInView = false
        view.addGestureRecognizer(tapping)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
