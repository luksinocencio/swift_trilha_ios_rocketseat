import Foundation

final class ClientFormViewModel {
    private let databaseManager = DatabaseManager.shared
    
    func saveClient(client: Client) {
        return databaseManager.saveClient(client)
    }
    
    func getAllClients() -> [Client] {
        return databaseManager.getClients()
    }
    
    func getClientById(id: Int) -> Client? {
        return databaseManager.getClients(by: id)
    }
    
    func deleteClient(id: Int) -> Bool {
        return databaseManager.deleteClient(by: id)
    }
}
