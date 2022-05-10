//
//  SQLiteCommands.swift
//  financas-project
//
//  Created by Pedro Henrique Galvão dos Santos on 10/05/22.
//

import Foundation
import SQLite
import SQLite3

class SQLiteCommands {
    static var table = Table("Usuario")
    
    static let idUsuario = Expression<Int>("idUsuario")
    static let nomeUsuario = Expression<String>("nomeUsuario")
    static let cpf =  Expression<String>("cpf")
    static let dataNascimento = Expression<String>("dataNascimento")
    static let email = Expression<String>("email") 
    
    static func createTable() {
        guard let database = SQLiteDatabase.sharedInstance.database
            else {
                print("Datastore connection error")
            return
        }
        do {
            try database.run(table.create(ifNotExists: true) { table in
                
                table.column(idUsuario, primaryKey: true)
                table.column(nomeUsuario)
                table.column(cpf, unique: true)
                table.column(dataNascimento)
                table.column(email, unique: true)

            })
        } catch {
            print("A tabela ja existe: \(error)")
        }
    }
    
    static func insertRow(_ usuarioValues: Usuario) -> Bool? {
        guard let database =
                SQLiteDatabase.sharedInstance.database else{
            print("Datastore connection error")
            return nil
        }
        do {
            try database.run(table.insert(
                nomeUsuario <- usuarioValues.nomeUsuario,
                cpf <- usuarioValues.cpf,
                dataNascimento <- usuarioValues.dataNascimento,
                email <- usuarioValues.email))
            return true
        } catch let Result.error(message,code,statement) where code == SQLITE_CONSTRAINT{
            print("Falha ao inserir a linha \(message) em \(String(describing: statement))")
            return false
        } catch let error {
            print("Falha ao inserir a linha \(error)")
            return false
        }
    }
    static func presentRows() -> [Usuario]? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        var usuarioArray = [Usuario]()
        table = table.order(idUsuario.desc)
        do {
            for usuario in try database.prepare(table) {
                let idUsuarioValue = usuario[idUsuario]
                let nomeUsuarioValue = usuario[nomeUsuario]
                let cpfValue = usuario[cpf]
                let dataNascimentoValue = usuario[dataNascimento]
                let emailValue = usuario[email]
                
                let usuarioObject = Usuario(idUsuario: idUsuarioValue, nomeUsuario: nomeUsuarioValue, cpf: cpfValue, dataNascimento: dataNascimentoValue, email: emailValue)
                
                usuarioArray.append(usuarioObject)
                
                print("idUsuario \(usuario[idUsuario]), Nome: \(usuario[nomeUsuario]), CPF \(usuario[cpf]), Data Nasc: \(usuario[dataNascimento]), Email: \(usuario[email]) ")
                
            }
        } catch {
            print("Present row error: \(error)")
        }
        return usuarioArray
    }
}
