//
//  loginController.swift
//  Gestión de Contactos
//
//  Created by user176683 on 12/03/21.
//

import Foundation
import UIKit

class loginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!

    let alertService = AlertService()
    let request = APIRequest(endpoint: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginButton(_ sender: Any) {
        let name : String = emailTextField.text!
        let pass : String = passTextField.text!
        
        let parameters = ["user":name, "pass":pass]
        
        if name == ""{
            print("Usuario vacio")
            
            let alert = UIAlertController(title: "Error", message: "Nombre de Usuario invalido", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
            
            return
        }
        else if pass == ""{
            print("Contraseña vacia")
            
            let alert = UIAlertController(title: "Error", message: "Contraseña invalida", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
            
            return}else{
                
        request.login(endpoint: "api/login", parameters: parameters) { [weak self] (result) in
            
            
            switch result{
                
            case.success(200):
                
                print("OK")
                self?.performSegue(withIdentifier: "ListView", sender: nil)
                
            case.failure(let error):
                
                guard let alert = self?.alertService.alert(message: error.localizedDescription) else {
                        return
                        }
                self?.present(alert,animated: true)
              
                
            case.success(_):
                
                print("Usuario incorrecto")
            }
                
        }
    }

}
}
