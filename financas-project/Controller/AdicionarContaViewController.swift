//
//  AdicionarContaViewController.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 11/05/22.
//

import UIKit

class AdicionarContaViewController: UIViewController {
    
    @IBOutlet weak var nomeBancoTextField: UITextField!
    @IBOutlet weak var numContaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        SQLiteCommands.createTableConta()
        SQLiteCommands.presentRowsConta()
        
    }

    // MARK: - Conecta a base de dados e cria tabela
    private func createTable () {
        let database = SQLiteDatabase.sharedInstance
        database.createTable()
        
    }
    
    @IBAction func adicionarContaButton(_ sender: Any) {
        let idConta: Int = 0
        let idUsuarioFK: Int = 0
        let nomeBanco = nomeBancoTextField.text ?? ""
        let numConta = Int(numContaTextField.text!) ?? 0

        
        
        let contaValues = ContaBancaria(idConta: idConta, idUsuarioFK: idUsuarioFK, nomeBanco: nomeBanco, numConta: numConta)
        
        adicionarConta(contaValues)
        
    }
    
    private func adicionarConta (_ contaValues: ContaBancaria) {
        let contaAdicionada = SQLiteCommands.insertRowConta(contaValues)
        
        if contaAdicionada == true {
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Erro", message: "Já existe um usuário com este CPF", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel))
            present(alert, animated: true)
            return
        }
    }
}
    

