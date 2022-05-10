//
//  SQLiteDatabase.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 10/05/22.
//

import Foundation
import SQLite
class SQLiteDatabase {
    static let sharedInstance = SQLiteDatabase()
    var database: Connection?
    
    private init (){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirectory.appendingPathComponent("financas-project").appendingPathExtension("sqlite3")
            database = try Connection(fileURL.path)
            
            
        } catch {
            print("Erro conectando ao banco de dados: \(error)")
        }
    }
    func createTable() {
        
    }
    
}
