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
        
        return allClients.filter { $0.dueDate == todayString }
    }
    
    func getCompanyModelsFromClients() -> [CompanyItemModel] {
        let clients = getAllClients()
        
        return clients.map { CompanyItemModel(name: $0.name) }
    }
    
    func getTotalValueForToday() -> Double {
        getTodayClients().reduce(0, { $0 + $1.value })
    }
    
    func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
}
