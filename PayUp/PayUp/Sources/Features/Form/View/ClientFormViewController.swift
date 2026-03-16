import UIKit

final class ClientFormViewController: UIViewController {
    private let mode: ClientFormMode
    private let viewModel = ClientFormViewModel()
    private var hasInitializedPosition = false
    private lazy var contentView = ClientFormView(mode: mode)
    
    init(mode: ClientFormMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !hasInitializedPosition else { return }
        
        hasInitializedPosition = true
        contentView.containerView.transform = CGAffineTransform(translationX: 0,
                                                                 y: contentView.containerView.bounds.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.contentView.containerView.transform = .identity
        }
    }
}

extension ClientFormViewController: ClientFormViewDelegate {
    func didTapCancel() {
        dismiss(animated: true)
    }
    
    func didTapSave() {
        dismiss(animated: true)
        guard let client = contentView.getClientData() else {
            showAlert(title: "ERRO", message: "Dados inseridos inválidos. Verifique os campos e tente novamente.")
            return
        }
        
        let success = viewModel.saveClient(client: client)
        
        if success {
            dismiss(animated: true)
        } else {
            showAlert(title: "ERRO", message: "Não foi possível salvar o cliente, erro ao inserir no banco de dados!")
        }
    }
    
    func didTapDelete() {
        let alert = UIAlertController(title: "Excluir cliente",
                                      message: "Tem certeza que deseja excluir este cliente?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Excluir", style: .destructive) { _ in
            // TODO: Implementar lógica de deletar
            self.dismiss(animated: true)
        })
        present(alert, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
