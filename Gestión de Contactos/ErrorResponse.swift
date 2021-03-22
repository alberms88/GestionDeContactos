//
//  ErrorResponse.swift
//  Gestión de Contactos
//
//  Created by user176683 on 12/03/21.
//

import Foundation

struct ErrorResponse: Decodable, LocalizedError{
    let reason : String
    var errorDescription: String? {return reason}
}
  
