//
//  registroController.swift
//  Gestión de Contactos
//
//  Created by user176683 on 12/03/21.
//

import Foundation
import UIKit


class registerViewController: UIViewController {
    
    //    let URL_SAVE_TEAM = "http://localhost:8888/rutasAPI/public/api/users/register"
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if passField.text! != confirmPassField.text! {
             print("Las contraseñas no coinciden")
             return
         }else{
             
             let emailText = emailField.text!
             let passText = passField.text!
             
             let user = User(user: emailText, pass: passText)
             
             let postRequest = APIRequest(endpoint: "api/register")
             
             postRequest.save(user, completion: {result in
                 switch result{
                 case .success(let user):
                     print("El siguiente usuario ha sido enviado:\(user.user) ")
                 case .failure(let error):
                     print("Ha ocurrido un error \(error)")
                 }
             })
             
         }
    }
}
