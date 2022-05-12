//
//  ContaBancaria.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 11/05/22.
//

import Foundation
class ContaBancaria {
    internal init(idConta: Int, idUsuarioFK: Int, nomeBanco: String, numConta: Int) {
        self.idConta = idConta
        self.idUsuarioFK = idUsuarioFK
        self.nomeBanco = nomeBanco
        self.numConta = numConta
    }
    
    let idConta: Int
    let idUsuarioFK: Int
    let nomeBanco: String
    let numConta: Int
}
