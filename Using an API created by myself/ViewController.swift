//
//  ViewController.swift
//  Using an API created by myself
//
//  Created by Vinícius de Oliveira on 27/11/20.
//

import UIKit

let urlString = "https://using-the-api.herokuapp.com/api/v1/customers-wallets"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetch()
    }
    
    func fetch() {
        let url = URL(string: urlString)
        
        guard url != nil else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                do {
                    // Transforma o objeto json em objeto swift
                    let academyStudents = try JSONDecoder().decode([AcademyStudents].self, from: data!)
                    
                    // studant é um objeto em swift
                    for student in academyStudents {
                        print("name: \(student.name)")
                        print("ocuppation: \(student.occupation)")
                        print("team: \(student.team)\n")
                    }
                }
                catch let error{
                    print(error)
                }
            }
        }
        
        dataTask.resume()
    }
    
    func post(id: String, name: String, occupation: String, team: String) {
        
        let newStudent = AcademyStudents.init(id: id, name: name, occupation: occupation, team: team)
        let url = URL(string: urlString)
        
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        guard let jsonData = try? JSONEncoder().encode(newStudent) else { return }
        request.httpBody = jsonData
        let json = String(data: jsonData, encoding: .utf8)
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil else { return }
            guard data != nil else { return }
            
            do {
                let studentsData = try JSONEncoder().encode(json)
                print(studentsData)
            }
            catch let error {
                print(error)
            }
        }
        dataTask.resume()
    }

    @IBAction func postNewItem(_ sender: Any) {
        post(id: "141241413", name: "Mari", occupation: "Mentor", team: "Mentores")
        fetch()
    }
}

