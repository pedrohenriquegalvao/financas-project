//
//  CadastroViewController.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 04/05/22.
//

import UIKit

class CadastroViewController: UIViewController {

    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var dataNascimentoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SQLiteCommands.createTable()
        nomeTextField.becomeFirstResponder()
        cpfTextField.delegate = self
        SQLiteCommands.presentRows()
        
        SQLiteCommands.createTableGasto()
        SQLiteCommands.presentRowsGasto()
        //SQLiteCommands.deleteRowsUsuario()
        //SQLiteCommands.presentRows()
    }
    

    
    // MARK: - Conecta a base de dados e cria tabela
    private func createTable () {
        let database = SQLiteDatabase.sharedInstance
        database.createTable()
        
    }
    
    @IBAction func cadastrarButton(_ sender: Any) {
        if (nomeTextField.text == "" || cpfTextField.text == "" || cpfTextField.text!.count < 14 || dataNascimentoTextField.text == "" || emailTextField.text == "" ){
            let alert = UIAlertController(title: "Erro", message: "Preencha todos os campos para cadastrar-se", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel))
            present(alert, animated: true)
            return
        } else {
            let nomeUsuario = nomeTextField.text ?? ""
            let cpf = cpfTextField.text ?? ""
            let dataNascimento = dataNascimentoTextField.text ?? ""
            let email = emailTextField.text ?? ""
            
            let usuarioValues = Usuario(nomeUsuario: nomeUsuario, cpf: cpf, dataNascimento: dataNascimento, email: email)
            
            cadastrarUsuario(usuarioValues)
            
            cadastrarGastos(cpf)
        }
    }
    
    // MARK: Criar novo usuario
    private func cadastrarUsuario (_ usuarioValues: Usuario) {
        let usuarioAdicionado = SQLiteCommands.insertRow(usuarioValues)
        
        // Verificar se o email e CPF ja existe na tabela
        if usuarioAdicionado == true {
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Erro", message: "Já existe um usuário com este CPF", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel))
            present(alert, animated: true)
            return
        }
    }
    
    private func cadastrarGastos (_ cpf: String) {
        let gastoFamiliaValues = Gasto(idGasto: 0, cpfUsuarioFKG: cpf, nomeGasto: "Família", valorGasto: 1000.00)
        let gastoFamiliaAdicionado = SQLiteCommands.insertRowGasto(gastoFamiliaValues)
        print("FAMILIA ADICIONADO")
        let gastoAlimentacaoValues = Gasto(idGasto: 1, cpfUsuarioFKG: cpf, nomeGasto: "Alimentação", valorGasto: 1000.00)
        let gastoAlimentacaoAdicionado = SQLiteCommands.insertRowGasto(gastoAlimentacaoValues)
        print("ALIMENTAÇÃO ADICIONADO")
        let gastoLazerValues = Gasto(idGasto: 2, cpfUsuarioFKG: cpf, nomeGasto: "Lazer", valorGasto: 1000.00)
        let gastoLazerAdicionado = SQLiteCommands.insertRowGasto(gastoLazerValues)
        print("LAZER ADICIONADO")
        let gastoEducacaoValues = Gasto(idGasto: 3, cpfUsuarioFKG: cpf, nomeGasto: "Educação", valorGasto: 1000.00)
        let gastoEducacaoAdicionado = SQLiteCommands.insertRowGasto(gastoEducacaoValues)
        print("EDUCAÇÃO ADICIONADO")
        let gastoCasaValues = Gasto(idGasto: 4, cpfUsuarioFKG: cpf, nomeGasto: "Casa", valorGasto: 1000.00)
        let gastoCasaAdicionado = SQLiteCommands.insertRowGasto(gastoCasaValues)
        print("CASA ADICIONADO")
        if gastoFamiliaAdicionado == true && gastoAlimentacaoAdicionado == true && gastoLazerAdicionado == true && gastoEducacaoAdicionado == true && gastoCasaAdicionado == true {
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Erro", message: "Erro ao inserir algum dos Gastos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel))
            present(alert, animated: true)
            return
        }
    }
    
}

extension CadastroViewController: UITextFieldDelegate {
    // -MARK: Validação do CPF
    private func format (with mask: String, cpf:String) -> String {
        let numbers = cpf.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "XXX.XXX.XXX-XX", cpf: newString)
        return false
    }
}
