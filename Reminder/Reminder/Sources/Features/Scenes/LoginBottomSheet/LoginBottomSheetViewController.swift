import UIKit
import LocalAuthentication

// MVVM-C
class LoginBottomSheetViewController: UIViewController {
    let viewModel = LoginBottomSheetViewModel()
    let contentView: LoginBottomSheetView

    var handleAreaHeight: CGFloat = 50.0

    public weak var flowDelegate: LoginBottomSheetFlowDelegate?

    init(
        contentView: LoginBottomSheetView,
        flowDelegate: LoginBottomSheetFlowDelegate
    ) {
        self.flowDelegate = flowDelegate
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handlePanGesture()
        setupGesture()
        bindViewModel()
        contentView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setupUI() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        _ = contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }

    // MARK: - Private Function(s).

    private func setupGesture() {

    }

    private func handlePanGesture() {

    }
    
    private func presentSaveLoginAlert(email: String) {
        let alertController = UIAlertController(title: "Salvar Acesso", message: "Deseja salvar seu acesso?", preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Salvar", style: .default) { _ in
            self.askEnableFaceID(email: email)
        }

        let cancelAction = UIAlertAction(title: "Não", style: .cancel) { _ in
            self.flowDelegate?.navigateToHome()
        }

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    private func askEnableFaceID(email: String) {
        let context = LAContext()
        var error: NSError?
        
        let supportsBiometry = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if supportsBiometry {
            let alert = UIAlertController(
                title: "Habilitar o FaceID?",
                message: "Deseja habilitar o login por biometria ?",
                preferredStyle: .alert
            )
            
            let yesAction = UIAlertAction(title: "Sim", style: .default) { _ in
                let user = User(email: email, isUserSaved: true, hasFaceIdEnabled: true)
                UserDefaultsManager.saveUser(user: user)
                self.flowDelegate?.navigateToHome()
            }
            
            let noAction = UIAlertAction(title: "Não", style: .cancel) { _ in
                let user = User(email: email, isUserSaved: true, hasFaceIdEnabled: false)
                UserDefaultsManager.saveUser(user: user)
                self.flowDelegate?.navigateToHome()
            }
            
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            self.present(alert, animated: true)
        } else {
            let user = User(email: email, isUserSaved: true, hasFaceIdEnabled: false)
            UserDefaultsManager.saveUser(user: user)
            self.flowDelegate?.navigateToHome()
        }
        
    }

    private func presentErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Erro ao logar", message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Tentar novamente", style: .default)
        alertController.addAction(retryAction)
        self.present(alertController, animated: true)
    }

    // MARK: - Internal Function(s).

    func animateShow(completion: (() -> Void)? = nil) {
        self.view.layoutIfNeeded()
        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = .identity
            self.view.layoutIfNeeded()
        }) { _ in
            completion?()
        }
    }

    func bindViewModel() {
        viewModel.successResult = { [weak self] usernameLogin in
            self?.presentSaveLoginAlert(email: usernameLogin)
        }

        viewModel.errorResult = { [weak self] errorMessage in
            self?.presentErrorAlert(message: errorMessage)
        }
    }

    @objc
    private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        let keyboardHeight = keyboardFrame.height

        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -keyboardHeight / 1.7
        }
    }

    @objc
    private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
}

// MARK: - Extensions

extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
    func sendLoginData(user: String, password: String) {
        viewModel.doAuth(usernameLogin: user, password: password)
    }
}
