import Lottie
import UIKit

class NewReceiptViewController: UIViewController {
    private let newReceiptView  = NewReceiptView()
    private let viewModel = NewReceiptViewModel()

    private let successAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "success")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.0
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.isHidden = true
        return animationView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = Colors.gray800
        view.addSubview(newReceiptView)
        view.addSubview(successAnimationView)
        setupConstraints()
        setupActions()
    }

    private func setupConstraints() {
        newReceiptView.translatesAutoresizingMaskIntoConstraints = false
        setupContentViewToBounds(contentView: newReceiptView)

        NSLayoutConstraint.activate([
            successAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            successAnimationView.heightAnchor.constraint(equalToConstant: 120),
            successAnimationView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func setupActions() {
        newReceiptView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        newReceiptView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    private func clearFieldsAndResetButton() {
        newReceiptView.remedyInput.textField.text = ""
        newReceiptView.timeInput.textField.text = ""
        newReceiptView.recurrenceInput.textField.text = ""
        newReceiptView.addButton.isEnabled = false
    }

    private func playSuccessAnimation() {
        successAnimationView.isHidden = false
        successAnimationView.play { [weak self] finished in
            if finished {
                self?.successAnimationView.isHidden = true
                self?.clearFieldsAndResetButton()
            }
        }
    }

    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc
    private func addButtonTapped() {
        let remedy = newReceiptView.remedyInput.getText()
        let time = newReceiptView.timeInput.getText()
        let recurrence = newReceiptView.recurrenceInput.getText()
        let takeNow = false
        playSuccessAnimation()
        viewModel.addReceipt(remedy: remedy, time: time, recurrence: recurrence, takeNow: takeNow)
    }
}
