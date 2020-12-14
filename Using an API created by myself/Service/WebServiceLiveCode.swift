//
//  WebServiceTest.swift
//  Using an API created by myself
//
//  Created by Gonzalo Ivan Santos Portales on 09/12/20.
//

import Foundation

class WebServiceLiveCode {
    
    var session : URLSession!
    let url = URL(string: "https://using-the-api.herokuapp.com/api/v1/customers-wallets")!
    
    init() {
        self.session = URLSession.shared
    }
    
    func get(completion: @escaping ([AcademyStudents]) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
          
            if let err = error {
                print(err)
                completion([])
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion([])
                return
            }
            
            do {
                let academyStudents = try JSONDecoder().decode([AcademyStudents].self, from: data!)
               
                completion(academyStudents)
            }
            catch let error{
                print(error)
            }
        }
        
        dataTask.resume()
    }

    func post(newStudent : AcademyStudents, completion: @escaping (Bool) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        
        guard let jsonData = try? JSONEncoder().encode(newStudent) else {return}
        
        let uploadTask = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            
            if let err = error {
                print(err)
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(false)
                return
            }
            
            completion(true)
        }
        
        uploadTask.resume()
        
        
    }
}
