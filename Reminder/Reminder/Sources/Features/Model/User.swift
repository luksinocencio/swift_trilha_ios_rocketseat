import Foundation

struct User: Codable {
    let email: String
    let isUserSaved: Bool
    let hasFaceIdEnabled: Bool
}
