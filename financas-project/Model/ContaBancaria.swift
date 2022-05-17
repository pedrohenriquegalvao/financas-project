//
//  ContaBancaria.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 11/05/22.
//

import Foundation
class ContaBancaria {
    internal init(idConta: Int, cpfUsuarioFK: String, nomeBanco: String, numConta: Int) {
        self.idConta = idConta
        self.cpfUsuarioFK = cpfUsuarioFK
        self.nomeBanco = nomeBanco
        self.numConta = numConta
    }
    
    let idConta: Int
    let cpfUsuarioFK: String
    let nomeBanco: String
    let numConta: Int
}
