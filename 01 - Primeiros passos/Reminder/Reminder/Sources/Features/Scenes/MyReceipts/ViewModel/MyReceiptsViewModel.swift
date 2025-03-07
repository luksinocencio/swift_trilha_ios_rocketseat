import Foundation

class MyReceiptsViewModel {
    func fetchData() -> [Medicine] {
        return DBHelper.shared.fetchReceipts()
    }
    
    func deleteReceipt(byId id: Int) {
        DBHelper.shared.deleteReceipt(byId: id)
    }
}
