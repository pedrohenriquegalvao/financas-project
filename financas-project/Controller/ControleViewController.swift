//
//  ControleViewController.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 04/05/22.
//

import UIKit

class ControleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var nome: String?
    var cpf: String?
    
    @IBOutlet weak var nomeLabel: UILabel!
    
    @IBOutlet weak var contaViewElement: UIView!
    
    @IBOutlet weak var nomeBancoLabel: UILabel!
    
    @IBOutlet weak var numContaLabel: UILabel!
    
    @IBOutlet weak var gastosCollectionView: UICollectionView!
    
    @IBOutlet weak var totalGastosLabel: UILabel!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        let dadosUsuario = SQLiteCommands.filtra(cpf: cpf ?? "")
        do {
            try nomeLabel.text = "Olá, \(dadosUsuario?.get(SQLiteCommands.nomeUsuario) ?? "Nome padrão")" 
        } catch {
            print(error)
        }
        
        let dadosConta = SQLiteCommands.filtraConta(cpf: cpf ?? "")
        
        do {
           try nomeBancoLabel.text = dadosConta?.get(SQLiteCommands.nomeBanco) ?? "Banco padrão"
            let numConta = SQLiteCommands.retornaNumConta(cpf: cpf ?? "")
            if (numConta == nil){
                numContaLabel.text! += ""
            }else{
                numContaLabel.text! += String(numConta!)
            }
            
            
        } catch {
            print(error)
        }
        
        gastosCollectionView.reloadData()
        
    }
    
    
    let images = ["familia", "alimentacao", "lazer", "educacao", "house"]
    //let buttons = ["Familia", "Alimentação", "Lazer", "Educação", "Casa"]
    var textoBotoes = Array<String>()
    var textoLabels = Array<String>()
    var tagBotoes = Array<Int>()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell
        
        textoBotoes = []
        tagBotoes = []
        textoLabels = []
        totalGastosLabel.text = ""
        var totalMensal = 0.0
        
        for gasto in SQLiteCommands.filtraGastos(cpf: cpf ?? "") {
            textoBotoes.append(gasto[SQLiteCommands.nomeGasto])
            textoLabels.append(String(gasto[SQLiteCommands.valorGasto]))
            tagBotoes.append(gasto[SQLiteCommands.idGasto])
            totalMensal += gasto[SQLiteCommands.valorGasto]
        }
        
        cell.image.image = UIImage(named: images[indexPath.row])
        cell.dbutton.setTitle(textoBotoes[indexPath.row], for: .normal)
        cell.dbutton.tag = tagBotoes[indexPath.row]
        cell.cellValorGasto.text = "Valor mensal: R$\(textoLabels[indexPath.row])"
        
        totalGastosLabel.text! += "Total de despesas fixas mensais: R$\(String(totalMensal))"
        
        SQLiteCommands.presentRowsGasto()
        cell.addButtonTapAction = {
                    // implement your logic here, e.g. call preformSegue()
                    
                self.performSegue(withIdentifier: "ControleParaGasto", sender: cell.dbutton)
                }
        //performSegue(withIdentifier: "ControleParaGasto", sender: cell.dbutton)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ControleParaAddConta") {
            let displayVC = segue.destination as! AdicionarContaViewController
            displayVC.cpf = cpf
            displayVC.nome = nome
        }
        if(segue.identifier == "ControleParaGasto") {
            let displayVC = segue.destination as! GastoViewController
            displayVC.cpf = cpf
            let buttonTag = sender as! UIButton
            displayVC.buttonTag = buttonTag.tag
        }
    }
    
}

class PostCell: UICollectionViewCell{
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dbutton: UIButton!
    @IBOutlet weak var cellValorGasto: UILabel!
    
    @IBAction func gastoButtonPressed(_ sender: Any?) {
        addButtonTapAction?()
    }
    
    var addButtonTapAction : (()->())?
    
    override func awakeFromNib() {
        background.layer.cornerRadius = 12
        image.layer.cornerRadius = 12
        dbutton.layer.cornerRadius = 12
        
    }
}
