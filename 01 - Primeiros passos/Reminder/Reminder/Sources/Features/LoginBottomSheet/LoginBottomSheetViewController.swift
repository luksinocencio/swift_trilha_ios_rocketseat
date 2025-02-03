import UIKit

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
    
    private func setupUI() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    //MARK: - Private Function(s).
    
    private func setupGesture() {
        
    }
    
    private func handlePanGesture() {
        
    }
    
    //MARK: - Internal Function(s).
    
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
        viewModel.successResult = { [weak self] in
            self?.flowDelegate?.navigateToHome()
        }
    }
}

// MARK: - Extensions

extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
    func sendLoginData(user: String, password: String) {
        viewModel.doAuth(usernameLogin: user, password: password)
    }
}
