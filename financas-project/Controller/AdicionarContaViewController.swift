//
//  AdicionarContaViewController.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 11/05/22.
//

import UIKit

class AdicionarContaViewController: UIViewController {
    var cpf: String?
    var nome: String?
    
    @IBOutlet weak var nomeBancoTextField: UITextField!
    @IBOutlet weak var numContaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        SQLiteCommands.createTableConta()
        //SQLiteCommands.deleteRowsConta()
        SQLiteCommands.presentRowsConta()
        
        
    }

    // MARK: - Conecta a base de dados e cria tabela
    private func createTable () {
        let database = SQLiteDatabase.sharedInstance
        database.createTable()
        
    }
    
    @IBAction func adicionarContaButton(_ sender: Any) {
        if (nomeBancoTextField.text == "" || numContaTextField.text == "") {
            let alert = UIAlertController(title: "Erro", message: "Preencha todos os campos para prosseguir", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel))
            present(alert, animated: true)
            return
        } else {
            let idConta: Int = 0
            let cpfUsuarioFK: String = cpf ?? ""
            let nomeBanco = nomeBancoTextField.text ?? ""
            let numConta = Int(numContaTextField.text!) ?? 0
            
            let contaValues = ContaBancaria(idConta: idConta, cpfUsuarioFK: cpfUsuarioFK, nomeBanco: nomeBanco, numConta: numConta)
    
            adicionarConta(contaValues)
        }

    }
    
    private func adicionarConta (_ contaValues: ContaBancaria) {
        let contaAdicionada = SQLiteCommands.insertRowConta(contaValues)
        print("ADICIONAR CONTA CHAMADO - AdicionarContaViewController")
        if contaAdicionada != true {
            let alert = UIAlertController(title: "Erro", message: "Este usuário já possui uma Conta", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: { action in self.performSegue(withIdentifier: "AddContaParaControle", sender: self)}))
            present(alert, animated: true)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "AddContaParaControle") {
            let displayVC = segue.destination as! ControleViewController
            displayVC.cpf = cpf
            displayVC.nome = nome
        }
    }
    
}
    

