//
//  ViewController.swift
//  Using an API created by myself
//
//  Created by Vinícius de Oliveira on 27/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableVIew: UITableView!
    var academyStudents = [AcademyStudents]()
    var webService = WebServiceLiveCode()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        fetchStudents()
    }
    
    @IBAction func addStudent(_ sender: Any) {
        addStudentAlert()
    }
    
    @IBAction func refreshList(_ sender: Any) {
        fetchStudents()
    }
    
    private func fetchStudents() {
        webService.get { (students) in
            DispatchQueue.main.async {
                self.academyStudents = students
                self.tableVIew.reloadData()
            }
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return academyStudents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell") as! StudentCellTableViewCell
        cell.setCell(data: academyStudents[indexPath.row])
        return cell
    }
}

extension ViewController {
    func addStudentAlert() {
        let alert = UIAlertController(title: "Adicionar Aluno",
                                      message: "",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Salvar", style: .default) { _ in
          
            let id = alert.textFields![0].text ?? "id"
            let name = alert.textFields![1].text ?? "name"
            let occupation = alert.textFields![2].text ?? "occupation"
            let team = alert.textFields![3].text ?? "team"

            let student = AcademyStudents(id: id, name: name, occupation: occupation, team: team)
            
            self.webService.post(newStudent: student) { (success) in
                if success {
                    self.fetchStudents()
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar",
                                         style: .cancel)
        
        alert.addTextField { textEmail in
          textEmail.placeholder = "Id"
        }
        
        alert.addTextField { textEmail in
          textEmail.placeholder = "Nome"
        }
        
        alert.addTextField { textEmail in
          textEmail.placeholder = "Cargo"
        }
        
        alert.addTextField { textEmail in
          textEmail.placeholder = "Time"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
