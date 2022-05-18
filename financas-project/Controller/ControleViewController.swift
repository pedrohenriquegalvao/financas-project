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
    
    @IBOutlet weak var contaViewElement: UIView!
    
    @IBOutlet weak var nomeBancoLabel: UILabel!
    
    @IBOutlet weak var numContaLabel: UILabel!
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        var dadosUsuario = SQLiteCommands.filtra(cpf: cpf ?? "")
        do {
           try nomeLabel.text = dadosUsuario?.get(SQLiteCommands.nomeUsuario) ?? "Nome padrão"
        } catch {
            print(error)
        }
        
        var dadosConta = SQLiteCommands.filtraConta(cpf: cpf ?? "")
        
        do {
           try nomeBancoLabel.text = dadosConta?.get(SQLiteCommands.nomeBanco) ?? "Banco padrão"
            let numConta = SQLiteCommands.retornaNumConta(cpf: cpf ?? "")
            if (numConta == nil){
                numContaLabel.text = "9999"
            }else{
                numContaLabel.text! += String(numConta!)
            }
            
            
        } catch {
            print(error)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ControleParaAddConta") {
            let displayVC = segue.destination as! AdicionarContaViewController
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
