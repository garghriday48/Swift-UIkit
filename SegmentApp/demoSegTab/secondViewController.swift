

import UIKit

class secondViewController: UIViewController {

    @IBOutlet weak var secondImg: UIImageView!
    @IBOutlet weak var secondLblTitle: UILabel!
    @IBOutlet weak var secondLblCity: UILabel!
    
    var Image: UIImage!
    var titleLabel: String!
    var titleCity: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        secondImg.image = Image
        secondLblTitle.text = titleLabel
        secondLblCity.text = titleCity

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        let firstTVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
