//
//  Usuario.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 10/05/22.
//

import Foundation

class Usuario {
    
    internal init(nomeUsuario: String, cpf: String, dataNascimento: String, email: String) {
        self.nomeUsuario = nomeUsuario
        self.cpf = cpf
        self.dataNascimento = dataNascimento
        self.email = email
    }
    
    var nomeUsuario: String
    let cpf: String
    let dataNascimento: String
    var email: String
    
}
