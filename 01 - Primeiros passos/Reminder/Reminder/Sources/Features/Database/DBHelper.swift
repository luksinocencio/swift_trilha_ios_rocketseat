import Foundation
import SQLite3

class DBHelper {
    static let shared = DBHelper()
    private var db: OpaquePointer?
    let dbPath = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
        .appendingPathComponent("Reminder.sqlite")
    
    private init() {
        openDatabase()
        createTable()
    }
    
    private func openDatabase() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Reminder.sqlite")
        
        print(fileURL)
        
        if sqlite3_open(fileURL.path(), &db) != SQLITE_OK {
            print("Erro ao abrir o banco de dados")
        }
    }
    
    private func createTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS Receipts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            remedy TEXT,
            time TEXT,
            recurrence TEXT,
            takeNow INTEGER
        );
        """
        
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Tabela criada com sucesso")
            } else {
                print("Erro ao criar tabela")
            }
        } else {
            print("CreateTable statement não conseguiu executar")
        }
        sqlite3_finalize(statement)
    }
    
    func insertReceipt(remedy: String, time: String, recurrence: String, takeNow: Bool) {
        let insertQuery = "INSERT INTO Receipts (remedy, time, recurrence, takeNow) VALUES (?, ?, ?, ?);"
        var statement: OpaquePointer?
        
        if (sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, (remedy as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (recurrence as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, (takeNow ? 1 : 0))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Receita inserida com sucesso !")
            } else {
                print("Falha ao inserir receita na tabela")
            }
        } else {
            print("INSERT statement falhou")
        }
        sqlite3_finalize(statement)
    }
    
    func fetchReceipts() -> [Medicine] {
        let fetchQuery = "SELECT remedy, time, reccurence FROM Receipts;"
        var statement: OpaquePointer?
        var receipts: [Medicine] = []
        
        if sqlite3_prepare(db, fetchQuery, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let remedy = String(cString: sqlite3_column_text(statement, 0))
                let time = String(cString: sqlite3_column_text(statement, 1))
                let reccurence = String(cString: sqlite3_column_text(statement, 2))
                let medicines = Medicine(remedy: remedy, time: time, recurrence: reccurence)
                
                receipts.append(medicines)
                
            }
        } else {
            print("SELECT statement failed")
        }
        
        sqlite3_finalize(statement)
        return receipts
    }
}
