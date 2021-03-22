//
//  loginController.swift
//  Gestión de Contactos
//
//  Created by user176683 on 12/03/21.
//

import Foundation

//struct User: Decodable {
//    let email: String
//    let password: String
//}

//final class User: Codable{
//    let id: Int?
//    let name: String
//    let email: String
//    let password: String
//}

class User: Codable{
    
    let user: String
    let pass: String
    
    init(user: String, pass: String) {
            self.user = user
            self.pass = pass
        }
}
