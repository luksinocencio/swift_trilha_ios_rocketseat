import Foundation
import SQLite3

final class DatabaseManager {
    static let shared = DatabaseManager()
    private var db: OpaquePointer?
    
    private init() {
        openDatabase()
        createTable()
    }
    
    private func openDatabase() {
        let fileURL = try! FileManager.default
            .url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil, create: false
            )
            .appendingPathComponent("clients.sqlite")
        
        if sqlite3_open(fileURL.path(), &db) != SQLITE_OK {
            print("Unable to open db")
        }
    }
    
    private func createTable() {
        let createTableSQL = """
            CREATE TABLE IF NOT EXISTS clients(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            contact TEXT NOT NULL,
            phone TEXT NOT NULL,
            cnpj TEXT NOT NULL,
            address TEXT NOT NULL,
            value REAL NOT NULL,
            due_date TEXT NOT NULL,
            is_recurring INTEGER NOT NULL,
            frequency TEXT NOT NULL,
            selected_day INTEGER NOT NULL
            );
            """
        
        if sqlite3_exec(db, createTableSQL, nil, nil, nil) != SQLITE_OK {
            print("Unable to create table")
        }
    }
    
    func saveClient(_ client: Client) -> Bool {
        let insertSQL = "INSERT INTO clients (name, contact, phone, cnpj, address, value, due_date, is_recurring, frequency, selected_day) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, NSString(string: client.name).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, NSString(string: client.contact).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, NSString(string: client.phone).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, NSString(string: client.cnpj).utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, NSString(string: client.address).utf8String, -1, nil)
            sqlite3_bind_double(statement, 6, client.value)
            sqlite3_bind_text(statement, 8, NSString(string: client.dueDate).utf8String, -1, nil)
            sqlite3_bind_int(statement, 7, client.isRecurring ? 1 : 0)
            sqlite3_bind_text(statement, 9, NSString(string: client.frequency).utf8String, -1, nil)
            
            if let day = client.selectedDay {
                sqlite3_bind_int(statement, 10, Int32(day))
            } else {
                sqlite3_bind_null(statement, 10)
            }
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        
        sqlite3_finalize(statement)
        return false
    }
    
    func getClients() -> [Client] {
        let querySQL = "SELECT * FROM clients"
        var statement: OpaquePointer?
        var clients: [Client] = []
        
        if sqlite3_prepare_v2(db, querySQL, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let name = String(cString: sqlite3_column_text(statement, 1))
                let contact = String(cString: sqlite3_column_text(statement, 2))
                let phone = String(cString: sqlite3_column_text(statement, 3))
                let cnpj = String(cString: sqlite3_column_text(statement, 4))
                let address = String(cString: sqlite3_column_text(statement, 5))
                let value = sqlite3_column_double(statement, 6)
                let dueDate = String(cString: sqlite3_column_text(statement, 7))
                let isRecurring = sqlite3_column_int(statement, 8) == 1
                let frequency = String(cString: sqlite3_column_text(statement, 9))
                let selectedDay = sqlite3_column_type(statement, 10) != SQLITE_NULL ? Int(sqlite3_column_int(statement, 10)) : nil
                
                let client = Client(
                    id: id,
                    name: name,
                    contact: contact,
                    phone: phone,
                    cnpj: cnpj,
                    address: address,
                    value: value,
                    dueDate: dueDate,
                    isRecurring: isRecurring,
                    frequency: frequency,
                )
                
                clients.append(client)
            }
        }
        
        sqlite3_finalize(statement)
        return clients
    }
    
    func getClients(by id: Int) -> Client? {
        let querySQL = "SELECT * FROM clients WHERE id = ?"
        var statement: OpaquePointer?
        var clients: [Client] = []
        
        if sqlite3_prepare_v2(db, querySQL, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let name = String(cString: sqlite3_column_text(statement, 1))
                let contact = String(cString: sqlite3_column_text(statement, 2))
                let phone = String(cString: sqlite3_column_text(statement, 3))
                let cnpj = String(cString: sqlite3_column_text(statement, 4))
                let address = String(cString: sqlite3_column_text(statement, 5))
                let value = sqlite3_column_double(statement, 6)
                let dueDate = String(cString: sqlite3_column_text(statement, 7))
                let isRecurring = sqlite3_column_int(statement, 8) == 1
                let frequency = String(cString: sqlite3_column_text(statement, 9))
                let selectedDay = sqlite3_column_type(statement, 10) != SQLITE_NULL ? Int(sqlite3_column_int(statement, 10)) : nil
                
                sqlite3_finalize(statement)
                
                return Client(
                    id: id,
                    name: name,
                    contact: contact,
                    phone: phone,
                    cnpj: cnpj,
                    address: address,
                    value: value,
                    dueDate: dueDate,
                    isRecurring: isRecurring,
                    frequency: frequency,
                )
            }
        }
        
        sqlite3_finalize(statement)
        return nil
    }
    
    func deleteClient(by id: Int) -> Bool {
        let deleteSQL = "DELETE FROM clients WHERE id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, deleteSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        sqlite3_finalize(statement)
        return false
    }
}
