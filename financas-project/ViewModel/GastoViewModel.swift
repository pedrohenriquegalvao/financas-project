//
//  GastoViewModel.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 22/05/22.
//

import Foundation
class GastoViewModel {
    private var gastoValues: Gasto?
    
    let idGasto: Int?
    let cpfUsuarioFKG: String?
    let nomeGasto: String?
    let valorGasto: Double?
   
    
    init (gastoValues: Gasto?) {
        self.gastoValues = gastoValues
        self.idGasto = gastoValues?.idGasto
        self.cpfUsuarioFKG = gastoValues?.cpfUsuarioFKG
        self.nomeGasto = gastoValues?.nomeGasto
        self.valorGasto = gastoValues?.valorGasto
        
    }
    
}
