//
//  CadatroUsuarioViewModel.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 10/05/22.
//

import UIKit
class CadastroUsuarioViewModel {
    private var usuarioValues: Usuario?
    
    let idUsuario: Int?
    let nomeUsuario: String?
    let cpf: String?
    let dataNascimento: String?
    let email: String?
    
    init (usuarioValues: Usuario?) {
        self.usuarioValues = usuarioValues
        
        self.idUsuario = usuarioValues?.idUsuario
        self.nomeUsuario = usuarioValues?.nomeUsuario
        self.cpf = usuarioValues?.cpf
        self.dataNascimento = usuarioValues?.dataNascimento
        self.email = usuarioValues?.email
        
    }
    
    
    
}

