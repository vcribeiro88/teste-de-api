//
//  ViewController.swift
//  Using an API created by myself
//
//  Created by Vinícius de Oliveira on 27/11/20.
//

import UIKit

let urlString = "http://localhost:8080/api/v1/customers-wallets"

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
                    let customersList = try JSONDecoder().decode(CustomerWallets.self, from: data!)
                    print(customersList)
                }
                catch let error{
                    print(error)
                }
            }
        }
        
        dataTask.resume()
    }
    
    func post(id: String, name: String, occupation: String, state: String) {
        let parameters = [
            "id": id,
            "name": name,
            "occupation": occupation,
            "state": state
        ]
        let url = URL(string: urlString)
        
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        catch let error {
            print(error)
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : String] {
                    print(json)
                }
            }
            catch let error {
                print(error)
            }
        }
        dataTask.resume()
//        do {
//            let jsonData = try JSONEncoder().encode(newCustomerWallet)
//            request.httpBody = jsonData
//        }
//        catch {
//            print(error)
//        }
    }

    @IBAction func postNewItem(_ sender: Any) {
        post(id: "141241413", name: "Vinícius", occupation: "Engenheiro de software", state: "PA")
        fetch()
    }
}

