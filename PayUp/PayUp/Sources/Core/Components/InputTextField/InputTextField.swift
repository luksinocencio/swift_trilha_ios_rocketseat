import UIKit

class InputTextFieldView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.labelMedium()
        label.textColor = Colors.textHeading
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.backgroundColor = Colors.backgroundTertiary
        field.textColor = Colors.textLabel
        field.font = Fonts.paragraphMedium()
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 1
        field.layer.borderColor = Colors.borderPrimary.cgColor
        field.setLeftPaddingPoints(12)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let calendarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.tintColor = Colors.textLabel
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let type: InputTextFieldType
    
    init(title: String, placeholder: String, type: InputTextFieldType = .normal) {
        self.type = type
        self.titleLabel.text = title
        super.init(frame: .zero)
        setupView(placeholder: placeholder)
        checkType()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Function(s).
    
    func setText(_ text: String) {
        self.textField.text = text
    }
    
    func getText() -> String? {
        return self.textField.text
    }
    
    // MARK: - Private Function(s).
    
    private func checkType() {
        if type == .date {
            textField.rightView = calendarButton
            textField.rightViewMode = .always
            
            calendarButton.addAction(.init(handler: {
                [weak self] _ in
                self?.presentDataPicker()
            }), for: .touchUpInside)
        }

    }
    
    private func setupView(placeholder: String) {
        addSubview(titleLabel)
        addSubview(textField)
        
        setupConstraints()
        setupTextField(placeholder: placeholder)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.heightAnchor.constraint(equalToConstant: 39),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupTextField(placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: Colors.textPlaceholder,
                .font: Fonts.paragraphSmall()
            ]
        )
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc
    private func textDidChange() {
        switch type {
        case .normal:
            break
        case .cellphone:
            maskPhoneNumber()
        case .cnpj:
            maskCNPJ()
        case .date:
            maskDate()
        }
    }
    
    private func maskPhoneNumber() {
        guard let text = textField.text else { return }
        let cleanPhoneNumber = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(##) #####-####"
        textField.text = applyMask(mask: mask, to: cleanPhoneNumber)
    }
    
    private func maskCNPJ() {
        guard let text = textField.text else { return }
        let cleanCNPJ = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "##.###.###/####-##"
        textField.text = applyMask(mask: mask, to: cleanCNPJ)
    }
    
    private func maskDate() {
        guard let text = textField.text else { return }
        let cleanDate = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "##/##/####"
        textField.text = applyMask(mask: mask, to: cleanDate)
    }
    
    private func applyMask(mask: String, to value: String) -> String {
        var result = ""
        var index = value.startIndex
        for ch in mask where index < value.endIndex {
            if ch == "#" {
                result.append(value[index])
                index = value.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        return result
    }
}

//MARK: - extension

extension InputTextFieldView {
    private func presentDataPicker() {
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
            self.textField.text = dateFormatter.string(from: picker.date)
        })
        
        if let viewController = self.parentViewController() {
            viewController.present(alert, animated: true)
        }
    }
}
