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
    
    func get(completion: @escaping ([AcademyStudentLiveCode]) -> Void) {
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completion([])
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion([])
                return
            }
            
            guard let json = data else {
                completion([])
                return
            }
        
            do {
                let students = try JSONDecoder().decode([AcademyStudentLiveCode].self, from: json)
                completion(students)
            } catch {
                print(error)
                completion([])
            }
        }
        
        dataTask.resume()
    }

    func post(newStudent : AcademyStudents, completion: @escaping (Bool) -> Void) {

    }
}
