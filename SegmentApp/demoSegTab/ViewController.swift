
import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var segOut: UISegmentedControl!
    
    var ahData:[AhmedabadModel] = []
    var baData:[BangloreModel] = []
    var muData:[MumbaiModel] = []
    var puData:[PuneModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
       ahData = [
        AhmedabadModel(city:"City :- Ahmedabad",img:  UIImage(imageLiteralResourceName: "a1"), title: "Navratri"),
        AhmedabadModel(city:"City :- Ahmedabad",img:   UIImage(imageLiteralResourceName: "a2"), title: "Rann Utsav"),
        AhmedabadModel(city:"City :- Ahmedabad",img:   UIImage(imageLiteralResourceName: "a3"), title: "Shamlaji Melo"),
        AhmedabadModel(city:"City :- Ahmedabad",img:   UIImage(imageLiteralResourceName: "a4"), title: "International Kite Festival (Uttarayan)"),
        ]
        
        muData = [
            MumbaiModel(city: "City :- Mumbai", img:   UIImage(imageLiteralResourceName: "m1"), title: "Banganga (Jan)"),
            MumbaiModel(city: "City :- Mumbai", img:   UIImage(imageLiteralResourceName: "m2"), title: "Elephanta festival (Feb)"),
            MumbaiModel(city: "City :- Mumbai", img:   UIImage(imageLiteralResourceName: "m3"), title: "Gudhi Padava (Mar-Apr)"),
            MumbaiModel(city: "City :- Mumbai",img:   UIImage(imageLiteralResourceName: "m4"), title: "Ganesh Chaturthi (Aug-Sep)"),
            MumbaiModel(city: "City :- Mumbai",img:   UIImage(imageLiteralResourceName: "m5"), title: "Diwali(Oct-Nov)")
        ]
        
        baData = [
            BangloreModel(city: "City :- Banglore", img:   UIImage(imageLiteralResourceName: "b1"), title: "Karaga Festival"),
            BangloreModel(city: "City :- Banglore", img:   UIImage(imageLiteralResourceName: "b2"), title: "Kadalekai Parishe Festival"),
            BangloreModel(city: "City :- Banglore", img:   UIImage(imageLiteralResourceName: "b3"), title: "Makar Sankranti"),
            
        ]
        
        puData = [
            PuneModel(city: "City :- Pune", img:   UIImage(imageLiteralResourceName: "p1"), title: "Makar Sankranti"),
            PuneModel(city: "City :- Pune", img:   UIImage(imageLiteralResourceName: "p2"), title: "Vasant Panchami"),
            PuneModel(city:"City :- Pune",img:   UIImage(imageLiteralResourceName: "p3"), title: "Holi"),
            
        ]
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }
    

    @IBAction func btnSegClick(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var value = 0
        switch segOut.selectedSegmentIndex{
        case 0:
            value = ahData.count
            break
        case 1:
            value = muData.count
            break
        case 2:
            value = baData.count
            break
        case 3:
            value = puData.count
            break
        default:
            break
        }
        return value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        switch segOut.selectedSegmentIndex{
        case 0:
            cell.lblTitle.text = ahData[indexPath.row].title
            cell.lblCity.text = ahData[indexPath.row].city
            cell.img.image = ahData[indexPath.row].img
        case 1:
            cell.lblTitle.text = muData[indexPath.row].title
            cell.lblCity.text = muData[indexPath.row].city
            cell.img.image = muData[indexPath.row].img
            
            break
        case 2:
            cell.lblTitle.text = baData[indexPath.row].title
            cell.lblCity.text = baData[indexPath.row].city
            cell.img.image = baData[indexPath.row].img
            
            break
        case 3:
            cell.lblTitle.text = puData[indexPath.row].title
            cell.lblCity.text = puData[indexPath.row].city
            cell.img.image = puData[indexPath.row].img
            
            break
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
        switch segOut.selectedSegmentIndex{
        case 0:
            secondVC.Image = ahData[indexPath.row].img
            secondVC.titleLabel = ahData[indexPath.row].title
            secondVC.titleCity = ahData[indexPath.row].city
            
            break
        case 1:
            secondVC.Image = muData[indexPath.row].img
            secondVC.titleLabel = muData[indexPath.row].title
            secondVC.titleCity = muData[indexPath.row].city
            
            break
        case 2:
            secondVC.Image = baData[indexPath.row].img
            secondVC.titleLabel = baData[indexPath.row].title
            secondVC.titleCity = baData[indexPath.row].city
            
            break
        case 3:
            secondVC.Image = puData[indexPath.row].img
            secondVC.titleLabel = puData[indexPath.row].title
            secondVC.titleCity = puData[indexPath.row].city
            
            break
        default:
            break
            
        }
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            switch segOut.selectedSegmentIndex{
            case 0:
                ahData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                break
            case 1:
                muData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                break
            case 2:
                baData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                break
            case 3:
                puData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                break
            default:
                break
                
            }
        }
        
        
    }
}













