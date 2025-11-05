import Foundation

final class CompanyViewModel {
    var companies: [CompanyItemModel] = []
    
    init(companies: [CompanyItemModel]) {
        self.companies = companies
    }
}
