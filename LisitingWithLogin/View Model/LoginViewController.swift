//
//  LoginViewController.swift
//  LisitingWithLogin
//
//  Created by Kavya on 25/07/22.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if (txtUserName.text!.count == 0) || (txtUserName.text!.count == 0) {
            self.shakeTextField(textField: txtUserName)
            return
        } else if (txtUserName.text!.count > 0) || (txtPassword.text!.count > 0){
            loginActionService()
        } else{
            self.shakeTextField(textField: txtUserName)
        }
    }
    
    func loginActionService() {
        serviceObject.GetSucessCase() { (response) in
            for (_, value) in response {
                if value as! Int == 1 {
                    DispatchQueue.main.async {
                        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                } else {
                    self.ShowAlert(TitleString: "Warning", MessageString: "Login Failed")
                }
            }
        }
    }
    
}
