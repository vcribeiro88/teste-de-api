//
//  WebServiceTest.swift
//  Using an API created by myself
//
//  Created by Gonzalo Ivan Santos Portales on 09/12/20.
//

import Foundation

class WebServiceTest {
    
    var session : URLSession!
    let url = URL(string: "https://using-the-api.herokuapp.com/api/v1/customers-wallets")!
    
    init() {
        // Inicialize aqui uma sessão (básica) com propriedade Shared da classe URLSession
    }
    
    //MARK: Agora você vai criar o escopo da função GET
    // a função get() recebe uma função que será executada assim que se obtiver a resposta do servidor
    func get(completion: @escaping ([AcademyStudents]) -> Void) {
        // Crie uma constante "dataTask" e inicie chamando a função .dataTask do objeto da session
        // Esta função dataTask recebe duas informações 1) url 2) Uma função que vai ser executada quando receber a resposta do servidor.
        
        
            //MARK:Ações dentro da Função:
                // Verifique se tem erro, se tiver ele retorna uma lista vazia, senão ele continua com o programa
        
                // Verifique se tem uma resposta http, se tiver ele vê se o código dessa resposta está entre 200 e 299, se tiver, continua o programa, senão
        
                // Crie um bloco do/catch por que a função decode() pode jogar um erro.
                        // Dentro do bloco "do": -> decodifique o objeto JSON para um objeto Swift
                            // Chame o parâmetro "completion" para enviar os dados recebidos para a interface do usuário.
        
                        // Dentro do "catch": ->  A função decode() pode jogar um erro, e então o pegamos ali no catch e printamos
        
        
        // Sobre a contante "dataTask: -> lembre-se que toda task inicia no estado suspended, para mudar para o estado running chamamos a função resume()
    }
    
    // Aqui você cria o escopo da função "POST"
    // a função post() recebe um estudante para ser enviado ao servidor e uma closure que vai ser executada assim que se obtiver a resposta do servidor
    func post(newStudent : AcademyStudents, completion: @escaping (Bool) -> Void) {
        /*
         Como nós queremos fazer uma operação POST, devemos criar um request
         -> Crie uma var "request" e inicie um objeto do tipo URLRequest com a (url) que definimos acima
        */
        
        
         // -> Defina o método Http "POST" para a request
         
         // -> Defina o formato dos dados que vamos enviar

        
        /* -> Transforme nosso objeto swift para um objeto do tipo JSON
         Obs.: Lembre-se que a codificação pode jogar um erro, portanto use guard let ou do/catch para pegar e tratar o erro
         */
        
        /*
        ->Crie uma constante "uploadTask" e inicie chamando a função .uploadTask do objeto da session
        Esta função :uploadTask" recebe três informações 1) URlRequest 2) Nosso objeto já no codificado no formato JSON 3) Uma função que vai ser executada quando receber a resposta do servidor.
        */
        
        
                //MARK:Ações dentro da Função:
                    // Verifique se tem erro, se tiver, retorna "FALSE" no parâmetro "completion" da função, senão ele continua com o programa
    
                    // Verifique se tem uma resposta http, se tiver ele vê se o código dessa resposta está entre 200 e 299, se tiver, continua o programa, senão retorna "FALSE" no parâmetro "completion"da função.
                    
                    // Após passar por todas as verificacões, chame o parâmetro "completion" da função com valor da true, indicando que a operacão foi bem sucedida.
        
        
        // Sobre a contante "uploadTask: -> lembre-se que toda task inicia no estado suspended, para mudar para o estado running chamamos a função resume()
    }
}

