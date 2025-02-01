import Foundation
import Firebase

class LoginBottomSheetViewModel {
    func doAuth(usernameLogin: String, password: String) {
        Auth.auth().signIn(withEmail: usernameLogin, password: password) { [weak self] authResult, error in
            if let error = error {
                print("autenticacao nao foi com sucesso: \(error)")
            } else {
                print(authResult?.user, "Sucesso na autenticacao")
            }
        }
    }
}
