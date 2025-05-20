import UIKit

class HomeViewController: UIViewController {
    let contentView: HomeView
    let flowDelegate: HomeFlowDelegate

    init(
        contentView: HomeView,
        flowDelegate: HomeFlowDelegate
    ) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
        checkForExistingData()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        let logoutButton = UIBarButtonItem(image: UIImage(named: "log-out-icon"), style: .plain, target: self, action: #selector(logoutAction))
        logoutButton.tintColor = Colors.primaryRedBase
        navigationItem.rightBarButtonItem = logoutButton
    }

    private func setup() {
        view.addSubview(contentView)
        self.view.backgroundColor = Colors.gray600
        contentView.delegate = self
        buildHierarchy()
        setupActionForNewRecipe()
    }

    private func buildHierarchy() {
        setupContentViewToBounds(contentView: contentView)
    }

    private func checkForExistingData() {
        if UserDefaultsManager.loadUser() != nil {
            contentView.nameTextField.text = UserDefaultsManager.loadUserName()
        }

        if let savedImage = UserDefaultsManager.loadProfileImage() {
            contentView.profileImage.image = savedImage
        }
    }

    private func setupActionForNewRecipe() {
        contentView.newPrescriptionButton.tapAction = { [weak self] in
            self?.didTapNewPrescriptionButton()
        }

        contentView.myPrescriptionsButton.tapAction = { [weak self] in
            self?.didTapMyReceiptsButton()
        }
    }

    @objc
    private func logoutAction() {
        UserDefaultsManager.removeUser()
        self.flowDelegate.logout()
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapProfileImage() {
        selectProfileImage()
    }

    func didTapNewPrescriptionButton() {
        flowDelegate.navigateToRecipes()
    }

    func didTapMyReceiptsButton() {
        flowDelegate.navigateMyRecipes()
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func selectProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }

    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            contentView.profileImage.image = editedImage
            UserDefaultsManager.saveProfileImage(image: editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            contentView.profileImage.image = originalImage
        }

        dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
