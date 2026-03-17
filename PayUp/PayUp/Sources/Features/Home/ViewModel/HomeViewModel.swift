import Foundation

final class HomeViewModel {
    private let databaseManager = DatabaseManager.shared
    
    func getAllClients() -> [Client] {
        return databaseManager.getClients()
    }
    
    func getTodayClients() -> [Client] {
        let allClients = getAllClients()
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let todayString = dateFormatter.string(from: today)
        
        return allClients.filter { client in
            return client.dueDate == todayString
        }
    }
    
    func getCompanyModelsFromClients() -> [CompanyItemModel] {
        let clients = getAllClients()
        
        return clients.map { client in
            CompanyItemModel(name: client.name)
        }
    }
    
    func getTotalValueForToday() -> Double {
        let todayClients = getTodayClients()
        
        return todayClients.reduce(0) { total, client in
            total + client.value
        }
    }
    
    func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
    
    func getClientByName(_ name: String) -> Client? {
        let allClients = getAllClients()
        return allClients.first { $0.name == name }
    }
}
