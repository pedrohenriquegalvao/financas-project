//
//  ControleAdicionarViewModel.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 11/05/22.
//

import Foundation
class ControleAdicionarContaViewModel {
    private var contaValues: ContaBancaria?
    
    let idConta: Int?
    let cpfUsuarioFK: String?
    let nomeBanco: String?
    let numConta: Int?
   
    
    init (contaValues: ContaBancaria?) {
        self.contaValues = contaValues
        self.idConta = contaValues?.idConta
        self.cpfUsuarioFK = contaValues?.cpfUsuarioFK
        self.nomeBanco = contaValues?.nomeBanco
        self.numConta = contaValues?.numConta
        
    }
    
    
    
}
