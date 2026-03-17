import Foundation

final class ClientFormViewModel {
    private let databaseManager = DatabaseManager.shared
    private let notificationManager = NotificationManager.shared
    
    func saveClient(client: Client) -> Bool {
        let success = databaseManager.saveClient(client)
        
        if success {
            if client.isRecurring {
                notificationManager.scheduleClientReminders(for: client)
            } else {
                print("Cliente não colocou um lembrete")
            }
        }
        return success
    }
    
    func getAllClients() -> [Client] {
        return databaseManager.getClients()
    }
    
    func getClientById(id: Int) -> Client? {
        return databaseManager.getClient(by: id)
    }
    
    func deleteClient(by id: Int) -> Bool {
        notificationManager.cancelClientReminders(clientId: id)
        return databaseManager.deleteClient(by: id)
    }
}
