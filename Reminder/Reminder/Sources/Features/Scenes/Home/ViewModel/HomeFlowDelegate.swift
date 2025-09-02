import Foundation

public protocol HomeFlowDelegate: AnyObject {
    func navigateToRecipes()
    func navigateMyRecipes()
    func logout()
}
