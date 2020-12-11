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
    }
    
    func get(completion: @escaping ([AcademyStudents]) -> Void) {
        
    }

    func post(newStudent : AcademyStudents, completion: @escaping (Bool) -> Void) {

    }
}
