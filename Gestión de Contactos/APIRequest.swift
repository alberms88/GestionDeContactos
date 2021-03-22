//
//  loginController.swift
//  Gestión de Contactos
//
//  Created by user176683 on 12/03/21.
//

import Foundation

//enum APIError:Error {
//    case responseProblem
//    case decodingProblem
//    case encodingProblem
//}

enum MyResult<T,E:Error> {
    case succes(T)
    case failure(E)
}


class APIRequest {
    let resourceURL: URL
    
    init(endpoint: String) {
        //let resourceString = "http://localhost:8888/rutasAPI/public/api/\(endpoint)"
        
        let resourceString = "https://superapi.netlify.app/\(endpoint)"
        
        guard let resourceURL = URL(string: resourceString)else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save(_ userToSave: User, completion: @escaping(Result<User,Error>)->Void) {
        do{
            var urlRequest = URLRequest(url: resourceURL)
            
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userToSave)
            
            
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest){ data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                    let _ = data else {
                        //completion(.failure(.responseProblem))
                        completion(.failure(APIError.responseProblem))
                        return
                }
                
                do {
                    switch httpResponse.statusCode{
                
                case 200 ..< 300:
                    
                    print("Usuario registrado correctamente")
                    
                default:
                    print("No se ha podido registrar al usuario")
                    
                }
                }
            }
            
            dataTask.resume()
            
            
        }catch{
            completion(.failure(APIError.encodingProblem))
        }
    }
    
    //Login de usuario
    func login(endpoint: String, parameters: [String: Any],completion: @escaping (Result<Int, Error>) -> Void){
         
        let baseURl = "https://superapi.netlify.app/"
        guard let url = URL(string: baseURl + endpoint) else {
            completion(.failure(logInError.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        
 
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else{
        return
            
        }
        
        request.httpBody = httpBody
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request){(data, response, error) in
            
            DispatchQueue.main.async {
                guard let unWrappedResponse = response as? HTTPURLResponse else{
                    completion(.failure(NetworkingError.badResponse))
                    return
                }
                
                print(unWrappedResponse.statusCode)
                
                switch unWrappedResponse.statusCode{
                case 200 ..< 300:
                    print("success")
                
                default:
                    print("failure")
                }
                
                if let unwrappedError = error{
                    completion(.failure(unwrappedError))
                }
                if let unwrappedData = data{
                    
                    print(unwrappedData)
                    do {
                    
                        completion(.success(unWrappedResponse.statusCode))
                            
                    }catch {
                        completion(.failure(error))
                    }

                }
            }
        }
        task.resume()
    }
    
    
    
    enum logInError: Error{
        case badURL
        case badResponse
    }
    
    func getUsers(endpoint: String , completion: @escaping (Result<[String], Error>) -> Void){
       
    
        guard let url = URL(string: "https://superapi.netlify.app/" + endpoint) else {
            completion(.failure(logInError.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
           DispatchQueue.main.async {
                guard let unWrappedResponse = response as? HTTPURLResponse else{
                    completion(.failure(logInError.badResponse))
                    return
            }

                print(unWrappedResponse.statusCode)
                print("success get Users")

            }
//            if let response = response{
//                print(response)
//            }
            
            if let unwrappedData = data{
                print(unwrappedData)
            
                do{
                    let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                    print(json)

                    if let usuarios = try? JSONDecoder().decode([String].self, from: unwrappedData){

                        completion(.success(usuarios))

                   

                    }else{
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            completion(.failure(errorResponse))
                            //print(errorResponse)
                        }
                                
                }catch{
                    completion(.failure(error))
                    print("Ha ocurrido un error inesperado, intentelo de nuevo.")
                    print(error)
                }
            }
        }
        session.resume()
        
  
}

    
    /*func login(_ userLogin: User, completion: @escaping(Result<User,Error>)->Void) {
        do{
            var urlRequest = URLRequest(url: resourceURL)
            
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userLogin)
            
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    guard let unwrappedResponse = response as? HTTPURLResponse else{
                        
                        completion(.failure(NetworkingError.badResponse))
                        return
                    }
                    
                    print(unwrappedResponse.statusCode)
                    
                    switch unwrappedResponse.statusCode{
                        
                    case 200 ..< 300:
                        
                        print("Sesión iniciada")
                        completion(.success(unwrappedResponse.statusCode))
                        return
                    default:
                        print("No se ha podido iniciar sesión")
                    }
                    
                }
                
                
            }
            
            task.resume()
            
            
        }catch{
            completion(.failure(APIError.encodingProblem))
        }
    }*/
}

enum APIError:Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}
