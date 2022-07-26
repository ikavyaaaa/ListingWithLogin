//
//  BaseViewController.swift
//  LisitingWithLogin
//
//  Created by Kavya on 25/07/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    let serviceObject = ServiceConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    //For shaking tetxfield
    func shakeTextField(textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 10, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 10, y: textField.center.y))
        textField.layer.add(animation, forKey: "position")
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    func ShowAlert(TitleString : String, MessageString : String, buttonTitle: String = "OK") {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: TitleString, message: MessageString, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default) {
                UIAlertAction in
                print("OK Pressed")
            }
            alert.addAction(okAction)
            self.present(alert, animated:true, completion: nil)
        }
    }
}
