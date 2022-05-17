//
//  ControleViewController.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 04/05/22.
//

import UIKit

class ControleViewController: UIViewController {
    var nome: String?
    var cpf: String?
    
    @IBOutlet weak var nomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var dados = SQLiteCommands.filtra(cpf: cpf ?? "")
        do {
           try nomeLabel.text = dados?.get(SQLiteCommands.nomeUsuario) ?? ""
        } catch {
            nomeLabel.text = "Nome padrao"
        }
       
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
