import UIKit

class signinViewController: UIViewController {
    var isShowing = false
    var validation = Validation()
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var checkBoxButton: UIButton!
    @IBOutlet var signinButton: UIButton!
    @IBOutlet var lowerAreaButton: [UIButton]!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        emailTextField.layer.borderWidth = 2
        passwordTextField.layer.borderWidth = 2
        passwordTextField.isSecureTextEntry = true
        signinButton.layer.cornerRadius = 15
        signinButton.layer.borderWidth = 2
        signinButton.layer.borderColor = UIColor.black.cgColor
        
        let paddingViewEmail = UIView(frame: CGRectMake(0, 0, 10, self.emailTextField.frame.height))
        emailTextField.leftView = paddingViewEmail
        emailTextField.rightView = paddingViewEmail
        emailTextField.leftViewMode = UITextField.ViewMode.always
        emailTextField.rightViewMode = UITextField.ViewMode.always
        
        let paddingViewPass = UIView(frame: CGRectMake(0, 0, 10, self.passwordTextField.frame.height))
        passwordTextField.leftView = paddingViewPass
        passwordTextField.leftViewMode = UITextField.ViewMode.always
        let paddingViewPassRight = UIView(frame: CGRectMake(0, 0, 45, self.passwordTextField.frame.height))
        passwordTextField.rightView = paddingViewPassRight
        passwordTextField.rightViewMode = UITextField.ViewMode.always
        
        
        for button in lowerAreaButton{
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        if isShowing{
            isShowing = false
            sender.setImage(UIImage(named:"checkmarkempty"), for: .normal)
            
            passwordTextField.isSecureTextEntry = true
        }
        else{
            isShowing = true
            sender.setImage(UIImage(named:"checkmark"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        }
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
       guard let email = emailTextField.text, let password = passwordTextField.text
        else {
            return
        }
        
        let isValidateEmail = self.validation.emailValidate(emailID: email)
        let isValidatePassword = self.validation.passwordValidate(password: password)
        
        if(isValidateEmail != "Now enter password"){
            let alert = UIAlertController(title: "Error", message: isValidateEmail, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Return", style: UIAlertAction.Style.default, handler: { _ in
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: false, completion: nil)
            }
        }
        else{
            if(isValidatePassword != " next page coming soon........."){
                
                let alert1 = UIAlertController(title: "Error", message: isValidatePassword , preferredStyle: .alert)
                
                alert1.addAction(UIAlertAction(title: "Return", style: UIAlertAction.Style.default, handler: { _ in
                }))
                DispatchQueue.main.async {
                    self.present(alert1, animated: false, completion: nil)
                }
            }else{
                let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                self.navigationController?.pushViewController(firstVC, animated: true)
                
            
            }
        }
            
            
        }
        
    }

