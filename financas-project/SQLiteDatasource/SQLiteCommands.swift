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
                
                table.column(nomeUsuario)
                table.column(cpf, primaryKey: true)
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
        print("PRESENT ROWS CHAMADO")
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        var usuarioArray = [Usuario]()
        tableUsuario = tableUsuario.order(cpf.desc)
        do {
            print("APRESENTAR USUARIO")
            for usuario in try database.prepare(tableUsuario) {
                let nomeUsuarioValue = usuario[nomeUsuario]
                let cpfValue = usuario[cpf]
                let dataNascimentoValue = usuario[dataNascimento]
                let emailValue = usuario[email]
                
                let usuarioObject = Usuario(nomeUsuario: nomeUsuarioValue, cpf: cpfValue, dataNascimento: dataNascimentoValue, email: emailValue)
                
                usuarioArray.append(usuarioObject)
                
                print("Nome: \(usuario[nomeUsuario]), CPF \(usuario[cpf]), Data Nasc: \(usuario[dataNascimento]), Email: \(usuario[email]) ")
                
            }
        } catch {
            print("Present row error: \(error)")
        }
        return usuarioArray
    }
    
    static func filtra(cpf:String) -> Row? {
        print("ALOHA")
        do {
            print("CU")

            let query = SQLiteCommands.tableUsuario.filter(SQLiteCommands.cpf == cpf)
            print(query.asSQL())
            var data = try SQLiteDatabase.sharedInstance.database!.pluck(query)
            print(data ?? "")
            print(try data?.get(nomeUsuario) ?? "")
            return data
            
        } catch {
            print("Get by Id Error : (error)")
            return nil
            
        }
        
    }
    
    static func deleteRowsUsuario(){
        print("DELETE CHAMADO")
        
        guard let database = SQLiteDatabase.sharedInstance.database
            else {
                print("Datastore connection error")
            return
        }
        
        do {
            try database.run(tableUsuario.limit(3).delete())
            print("LINHA DELETADA")
        }catch {
            print(error)
        }
        
    }
    
    
    //-MARK: TABELA CONTABANCARIA
    
    static var tableConta = Table("Conta")
    
    static let idConta = Expression<Int>("idConta")
    static let cpfUsuarioFK = Expression<String>("cpfUsuarioFK")
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
                table.column(cpfUsuarioFK, unique: true)
                table.column(nomeBanco)
                table.column(numConta)
                
                table.foreignKey(cpfUsuarioFK, references: tableUsuario, cpf)
                print("Tabela Conta criada")
            })
        } catch {
            print("A tabela conta ja existe: \(error)")
        }
    }
    
    static func insertRowConta(_ contaBancaria: ContaBancaria) -> Bool? {
        print("INSERT ROW CONTA CHAMADO - SQLiteCommands")
        guard let database =
                SQLiteDatabase.sharedInstance.database else{
            print("Datastore connection error")
            return nil
        }
        do {
            print("Fazendo")
            try database.run(tableConta.insert(
                cpfUsuarioFK <- contaBancaria.cpfUsuarioFK,
                nomeBanco <- contaBancaria.nomeBanco,
                numConta <- contaBancaria.numConta
                ))
            return true
        } catch let Result.error(message,code,statement) where code == SQLITE_CONSTRAINT{
            print("1- Falha ao inserir a linha \(message) em \(String(describing: statement))")
            return false
        } catch let error {
            print("2- Falha ao inserir a linha \(error)")
            return false
        }
    }
    
    static func presentRowsConta() -> [ContaBancaria]? {
        print("PRESENT ROWS CONTA CHAMADO")
    
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        var contaArray = [ContaBancaria]()
        tableConta = tableConta.order(idConta.desc)
        do {
            print("APRESENTAR CONTA: ")
            for conta in try database.prepare(tableConta) {
                let idContaValue = conta[idConta]
                let cpfUsuarioFKValue = conta[cpfUsuarioFK]
                let nomeBancoValue = conta[nomeBanco]
                let numContaValue = conta[numConta]
                
                let contaObject = ContaBancaria(idConta: idContaValue, cpfUsuarioFK: cpfUsuarioFKValue, nomeBanco: nomeBancoValue, numConta: numContaValue)
                
                contaArray.append(contaObject)
                
                print("idConta \(conta[idConta]), cpfUsuarioFK: \(conta[cpfUsuarioFK]), nomeBanco \(conta[nomeBanco]), numConta: \(conta[numConta])")
            
            }
        } catch {
            print("Present row error: \(error)")
        }
        return contaArray
    }
    
    
    
    static func filtraConta(cpf:String) -> Row? {

        do {
            let query = SQLiteCommands.tableConta.filter(SQLiteCommands.cpfUsuarioFK == cpf)
            print(query.asSQL())
            var data = try SQLiteDatabase.sharedInstance.database!.pluck(query)
            print(data ?? "")
            print(try data?.get(nomeBanco) ?? "")
            return data
            
        } catch {
            print("Get by Id Error : (error)")
            return nil
            
        }
        
    }
    
    static func retornaNumConta(cpf:String) -> Int? {

        do {
            let query = SQLiteCommands.tableConta.filter(SQLiteCommands.cpfUsuarioFK == cpf)
            print(query.asSQL())
            var data = try SQLiteDatabase.sharedInstance.database!.pluck(query)
            print(data ?? "")
            print(try data?.get(nomeBanco) ?? "")
            return try? data?.get(numConta) ?? 9999
            
        } catch {
            print("Erro ao retornar numero da conta")
            return nil
            
        }
        
    }
    
    
    static func deleteRowsConta(){
        print("DELETE CONTA CHAMADO")
        
        guard let database = SQLiteDatabase.sharedInstance.database
            else {
                print("Datastore connection error")
            return
        }
        
        do {
            try database.run(tableConta.limit(1).delete())
            print("LINHA DELETADA")
        }catch {
            print(error)
        }
        
    }
    
    
    //-MARK: TABELA GASTO
    static var tableGasto = Table("Gasto")
    
    static let idGasto = Expression<Int>("idGasto")
    static let cpfUsuarioFKG = Expression<String>("cpfUsuarioFKG")
    static let nomeGasto = Expression<String>("nomeGasto")
    static let valorGasto =  Expression<Double>("valorGasto")
    
    static func createTableGasto() {
        
        guard let database = SQLiteDatabase.sharedInstance.database
            else {
                print("Datastore connection error")
            return
        }
        do {
            
            
            try database.run(tableGasto.create(ifNotExists: true) { table in
                
                table.column(idGasto, primaryKey: true)
                table.column(cpfUsuarioFKG)
                table.column(nomeGasto)
                table.column(valorGasto)
                
                table.foreignKey(cpfUsuarioFKG, references: tableUsuario, cpf)
                print("Tabela Gasto criada")
            })
        } catch {
            print("A tabela gasto ja existe: \(error)")
        }
    }
    
    static func insertRowGasto(_ gasto: Gasto) -> Bool? {
        print("INSERT ROW GASTO CHAMADO - SQLiteCommands")
        guard let database =
                SQLiteDatabase.sharedInstance.database else{
            print("Datastore connection error")
            return nil
        }
        do {
            print("Fazendo")
            try database.run(tableGasto.insert(
                cpfUsuarioFKG <- gasto.cpfUsuarioFKG,
                nomeGasto <- gasto.nomeGasto,
                valorGasto <- gasto.valorGasto
                ))
            return true
        } catch let Result.error(message,code,statement) where code == SQLITE_CONSTRAINT{
            print("1- Falha ao inserir a linha \(message) em \(String(describing: statement))")
            return false
        } catch let error {
            print("2- Falha ao inserir a linha \(error)")
            return false
        }
    }
    
    static func presentRowsGasto() -> [Gasto]? {
        print("PRESENT ROWS GASTO CHAMADO")
    
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        var gastoArray = [Gasto]()
        tableGasto = tableGasto.order(idGasto.desc)
        do {
            print("APRESENTAR GASTO: ")
            for gasto in try database.prepare(tableGasto) {
                let idGastoValue = gasto[idGasto]
                let cpfUsuarioFKGValue = gasto[cpfUsuarioFKG]
                let nomeGastoValue = gasto[nomeGasto]
                let valorGastoValue = gasto[valorGasto]
                
                let gastoObject = Gasto(idGasto: idGastoValue, cpfUsuarioFKG: cpfUsuarioFKGValue, nomeGasto: nomeGastoValue, valorGasto: valorGastoValue)
                
                gastoArray.append(gastoObject)
                
                print("idGasto \(gasto[idGasto]), cpfUsuarioFKG: \(gasto[cpfUsuarioFKG]), nomeGasto: \(gasto[nomeGasto]), valorGasto: \(gasto[valorGasto])")
            
            }
        } catch {
            print("Erro ao apresentar as linhas de Gasto: \(error)")
        }
        return gastoArray
    }
    
    static func filtraGasto(cpf:String) -> Array<Row> {
        print("FILTRA GASTO CHAMADO")
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return Array<Row>()
        }
        
        do {
            let query = SQLiteCommands.tableGasto.filter(SQLiteCommands.cpfUsuarioFKG == cpf)
            print(query.asSQL())
            let all = Array(try database.prepare(query))
            //print(all)
            return all
            
        } catch {
            print("Get by Id Error : (error)")
            return Array<Row>()
            
        }
        
    }
    
    
}
