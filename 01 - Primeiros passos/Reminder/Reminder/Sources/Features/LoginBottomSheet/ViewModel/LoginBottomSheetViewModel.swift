import Foundation
import Firebase

class LoginBottomSheetViewModel {
    var successResult: (() -> Void)?
    
    func doAuth(usernameLogin: String, password: String) {
        Auth.auth().signIn(withEmail: usernameLogin, password: password) { [weak self] authResult, error in
            if let error = error {
                print("autenticacao nao foi com sucesso: \(error)")
            } else {
                self?.successResult?()
            }
        }
    }
}
