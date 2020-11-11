//
//  infoViewController.swift
//  findmyfriend
//
//  Created by BIG on 9/11/2563 BE.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class signUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//    func validateFields() -> String? {
//
//        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
//
//            return "Please fill all field"
//
//        }
//
//        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in:.whitespacesAndNewlines)
//
//
//        return nil
//    }
    
    @IBAction func signUpTap(_ sender: Any) {
        let firstname = firstNameTextField.text!.trimmingCharacters(in:.whitespacesAndNewlines)
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().createUser(withEmail: email, password: pass){
           (result,err) in
            if err != nil {
                print(err)
            } else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["username":firstname,"email":email,"password":pass,"uid":result!.user.uid]) {(error) in
                }
                self.transitionToHome()
            }
        }
    }
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? homeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
