//
//  Gasto.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 22/05/22.
//

import Foundation

class Gasto {
    
    internal init(idGasto: Int, cpfUsuarioFKG: String, nomeGasto: String, valorGasto: Double) {
        self.idGasto = idGasto
        self.cpfUsuarioFKG = cpfUsuarioFKG
        self.nomeGasto = nomeGasto
        self.valorGasto = valorGasto
    }
    
    let idGasto: Int
    let cpfUsuarioFKG: String
    let nomeGasto: String
    let valorGasto: Double
}
