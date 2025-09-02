import Foundation
import Firebase

class LoginBottomSheetViewModel {
    var successResult: ((String) -> Void)?
    var errorResult: ((String) -> Void)?

    func doAuth(usernameLogin: String, password: String) {
        Auth.auth().signIn(withEmail: usernameLogin, password: password) { [weak self] _, error in
            if let error = error {
                self?.errorResult?(error.localizedDescription)
            } else {
                self?.successResult?(usernameLogin)
            }
        }
    }
}
