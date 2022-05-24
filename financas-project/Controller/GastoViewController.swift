//
//  GastoViewController.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 24/05/22.
//

import UIKit

class GastoViewController: UIViewController {
    var cpf: String?
    var buttonTag: Int?
    
    @IBOutlet weak var nomeGastoLabel: UILabel!
    @IBOutlet weak var valorGastoTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SQLiteCommands.presentRowsGasto()
        let dadosGasto = SQLiteCommands.filtraGasto(idGasto: buttonTag!)
        do {
           try nomeGastoLabel.text = dadosGasto?.get(SQLiteCommands.nomeGasto) ?? "Nome padrão"
           try valorGastoTextField.text = String(dadosGasto!.get(SQLiteCommands.valorGasto))
        } catch {
            print(error)
        }
        
        
    }
    

    @IBAction func atualizarGastoPressed(_ sender: Any) {
        if (valorGastoTextField.text == ""){
            let alert = UIAlertController(title: "Erro", message: "Insira algum valor no campo para atualizar.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel))
            present(alert, animated: true)
            return
        } else {
            let novoValor = Double(valorGastoTextField.text!)
            let gastoAtualizado = SQLiteCommands.updateRowGasto(idGasto: buttonTag!, novoValor: novoValor!)
            if gastoAtualizado != true {
                let alert = UIAlertController(title: "Erro", message: "Não foi possível atualizar o gasto.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: { action in self.performSegue(withIdentifier: "GastoParaControle", sender: self)}))
                present(alert, animated: true)
                
            }
            
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GastoParaControle"){
            let displayVC = segue.destination as! ControleViewController
            displayVC.cpf = cpf
        }
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
