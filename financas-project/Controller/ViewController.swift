//
//  ViewController.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 28/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nomeTextField: UITextField!
    
    @IBOutlet weak var cpfTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SQLiteCommands.presentRows()
        cpfTextField.delegate = self
        // Do any additional setup after loading the view.
       
    }
    @IBAction func btnLogin(_ sender: Any) {
        if (nomeTextField.text == "" || cpfTextField.text == "") {
            let alert = UIAlertController(title: "Erro", message: "Preencha os campos para prosseguir", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel))
            present(alert, animated: true)
        } else {
        if (SQLiteCommands.filtra(cpf: cpfTextField.text!) == nil) {
            let alert = UIAlertController(title: "Erro", message: "Não há nenhum usuário com este CPF", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel))
            present(alert, animated: true)
            }
        }
        
        /*NSString *query=[NSString stringWithFormat:@"select * from Usuario where cpf=\"%@\"",cpfTextField.text];
        NSLog(@"%@",query);
        NSLog(@"%@",self.dbManager);
        NSArray* ary = [self.dbManager loadDataFromDB:query];

        if (ary.count){
              //Login successfully
              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"login successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
              [alert show];
          }else{
              //Invalid username and password
              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Unsuccessful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
              [alert show];
          } */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "LoginParaControle") {
                let displayVC = segue.destination as! ControleViewController
                displayVC.nome = nomeTextField.text
                displayVC.cpf = cpfTextField.text
        }
    }

}

extension ViewController: UITextFieldDelegate {
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

