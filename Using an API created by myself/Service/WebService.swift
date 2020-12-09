//
//  WebService.swift
//  Using an API created by myself
//
//  Created by Gonzalo Ivan Santos Portales on 08/12/20.
//

import Foundation

class WebService {
    
    var session : URLSession!
    let url = URL(string: "https://using-the-api.herokuapp.com/api/v1/customers-wallets")!
    
    init() {
        self.session = URLSession.shared
    }
    
    // a função get() recebe uma closure que será executada assim que se obtiver a resposta do servidor
    func get(completion: @escaping ([AcademyStudents]) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Verificando se tem erro, se tiver ele retorna uma lista vazia, senão ele continua com o programa
            if let _ = error {
                completion([])
                return
            }
            
            // Verifica se tem uma resposta http, se tiver ele vê se o código dessa resposta está entre 200 e 299, se tiver, continua o programa, senão
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion([])
                return
            }
            
            // precisamos estrar em um do/catch por que a função decode() pode jogar um erro, e então o pegamos ali no catch e printamos
            do {
                // Transforma o objeto json em um objeto swift
                let academyStudents = try JSONDecoder().decode([AcademyStudents].self, from: data!)
               
                // Retorna a lista de estudantes que foi decodificada da resposta do servidor
                completion(academyStudents)
            }
            catch let error{
                print(error)
            }
        }
        
        dataTask.resume() // lembrando que toda task inicia no estado suspended, para mudar para o estado running chamamos a função resume()
    }
    
    // a função post() recebe um estudante para ser enviado ao servidor e uma closure que vai ser executada assim que se obtiver a resposta do servidor
    func post(newStudent : AcademyStudents, completion: @escaping (Bool) -> Void) {
        // como nós queremos fazer uma operação POST, devemos customizar uma request para isso
        var request = URLRequest(url: url) // essa request é a request HTTP que será enviada para o servidor
        request.httpMethod = "POST" // o método que vamos usar
        request.setValue("application/json", forHTTPHeaderField: "Content-type") // o formato dos dados que estamos enviando
   
        guard let jsonData = try? JSONEncoder().encode(newStudent) else { return } // codificando o nosso student para json
        
        let uploadTask = URLSession.shared.uploadTask(with: request, from: jsonData) { (data, response, error) in
            // Verificando se tem erro, se tiver ele retorna false, senão ele continua com o programa
            if let _ = error {
                completion(false)
                return
            }
            
            // Verifica se tem uma resposta http, se tiver ele vê se o código dessa resposta está entre 200 e 299, se tiver, continua o programa, senão ele retorna false
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(false)
                return
            }
            
            // se chegou até aqui é pq ocorreu tudo bem com o envio de dados, então ele retorna true
            completion(true)
        }
        
        uploadTask.resume() // lembrando que toda task inicia no estado suspended, para mudar para o estado running chamamos a função resume()
    }
}
