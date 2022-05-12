//
//  SQLiteCommandsConta.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 11/05/22.
//

import Foundation
import SQLite
import SQLite3


class SQLiteCommandsConta {
   /* static var tableConta = Table("Conta")
    
    static let idConta = Expression<Int>("idConta")
    static let idUsuario = Expression<Int>("idUsuario")
    static let nomeBanco = Expression<String>("nomeBanco")
    static let numConta =  Expression<Int>("numConta")
    
    static func createTableConta() {
        
        guard let database = SQLiteDatabase.sharedInstance.database
            else {
                print("Datastore connection error")
            return
        }
        do {
            
            
            try database.run(tableConta.create(ifNotExists: true) { table in
                
                table.column(idConta, primaryKey: true)
                table.column(idUsuario)
                
                table.foreignKey(idUsuario, references: tableUsuario, idUsuario)
                print("Tabela criada")
            })
        } catch {
            print("A tabela ja existe: \(error)")
        }
    }*/
    
    
}
