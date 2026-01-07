import UIKit

final class DatePickerTextField: UIView {
    private let title: String
    private let placeholder: String
    
    private let calendarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.tintColor = Colors.textLabel
        button.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            button.widthAnchor.constraint(equalToConstant: 24),
//            button.heightAnchor.constraint(equalToConstant: 24)
//        ])
        return button
    }()
    
    private lazy var textField: InputTextFieldView = {
        let tf = InputTextFieldView(title: self.title, placeholder: self.placeholder, type: .date)
        tf.rightView(calendarButton)
        tf.rightViewMode(.always)
        return tf
    }()
    
    init(title: String, placeholder: String) {
        self.title = title
        self.placeholder = placeholder
        super.init(frame: .zero)
        calendarButton.addTarget(self, action: #selector(calendarTapped), for: .touchUpInside)
        
        addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func calendarTapped() {
        presentDataPicker()
    }
    
    func presentDataPicker() {
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        alert.view.addSubview(picker)
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 8),
            picker.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -8),
            picker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 8),
            picker.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        alert.addAction(.init(title: "Ok", style: .default) { _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            self.textField.setText(dateFormatter.string(from: picker.date))
        })
        
        if let viewController = self.parentViewController() {
            viewController.present(alert, animated: true)
        }
    }
    
    func setText(_ text: String) {
        self.textField.setText(text)
    }
    
    func getText() -> String? {
        return self.textField.getText()
    }
}
