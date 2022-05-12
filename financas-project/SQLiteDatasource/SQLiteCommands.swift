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
    // -MARK: TABELA USUARIO
    static var tableUsuario = Table("Usuario")
    
    
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
            
            
            try database.run(tableUsuario.create(ifNotExists: true) { table in
                
                table.column(idUsuario, primaryKey: true)
                table.column(nomeUsuario)
                table.column(cpf, unique: true)
                table.column(dataNascimento)
                table.column(email, unique: true)
                print("Tabela criada")
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
            try database.run(tableUsuario.insert(
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
        print("AASAASFEWCEEWVWEWVWCSDCDSCSDC")
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        var usuarioArray = [Usuario]()
        tableUsuario = tableUsuario.order(idUsuario.desc)
        do {
            for usuario in try database.prepare(tableUsuario) {
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
    
    
    //-MARK: TABELA CONTABANCARIA
    
    static var tableConta = Table("Conta")
    
    static let idConta = Expression<Int>("idConta")
    static let idUsuarioFK = Expression<Int>("idUsuario")
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
                table.column(nomeBanco)
                table.column(numConta, unique: true)
                
                table.foreignKey(idUsuario, references: tableUsuario, idUsuario)
                print("Tabela criada")
            })
        } catch {
            print("A tabela ja existe: \(error)")
        }
    }
    
    static func insertRowConta(_ contaBancaria: ContaBancaria) -> Bool? {
        guard let database =
                SQLiteDatabase.sharedInstance.database else{
            print("Datastore connection error")
            return nil
        }
        do {
            try database.run(tableConta.insert(
                idUsuarioFK <- contaBancaria.idUsuarioFK,
                nomeBanco <- contaBancaria.nomeBanco,
                numConta <- contaBancaria.numConta
                ))
            return true
        } catch let Result.error(message,code,statement) where code == SQLITE_CONSTRAINT{
            print("Falha ao inserir a linha \(message) em \(String(describing: statement))")
            return false
        } catch let error {
            print("Falha ao inserir a linha \(error)")
            return false
        }
    }
    
    static func presentRowsConta() -> [ContaBancaria]? {
        print("pppppppppppppppp")
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        var contaArray = [ContaBancaria]()
        tableConta = tableConta.order(idConta.desc)
        print("ooooooooooooooooooo")
        do {
            for conta in try database.prepare(tableConta) {
                let idContaValue = conta[idConta]
                let idUsuarioFKValue = conta[idUsuarioFK]
                let nomeBancoValue = conta[nomeBanco]
                let numContaValue = conta[numConta]
                
                let contaObject = ContaBancaria(idConta: idContaValue, idUsuarioFK: idUsuarioFKValue, nomeBanco: nomeBancoValue, numConta: numContaValue)
                
                contaArray.append(contaObject)
                
                print("idConta \(conta[idConta]), idUsuarioFK: \(conta[idUsuarioFK]), nomeBanco \(conta[nomeBanco]), numConta: \(conta[numConta])")
                
            }
        } catch {
            print("Present row error: \(error)")
        }
        return contaArray
    }
    
    
    
}
