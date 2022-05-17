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
        
        // Do any additional setup after loading the view.
       
    }
    @IBAction func btnLogin(_ sender: Any) {
        print("ä")
        SQLiteCommands.filtra(cpf: cpfTextField.text!)
        
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
            if (nomeTextField.text == "" || cpfTextField.text == "") {
                let alert = UIAlertController(title: "Erro", message: "Preencha os campos para prosseguir", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel))
                present(alert, animated: true)
            } else {
                let displayVC = segue.destination as! ControleViewController
                displayVC.nome = nomeTextField.text
                displayVC.cpf = cpfTextField.text
            }
            
        }
    }
    
    
    
    


}

