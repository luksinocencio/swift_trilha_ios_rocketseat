import UIKit

final class InputTextFieldView: UIView {
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
    
    private let type: InputTextFieldType
    
    init(
        title: String,
        placeholder: String,
        type: InputTextFieldType = .normal,
        autoCorrect: UITextAutocorrectionType = .default,
        autoCapitalization: UITextAutocapitalizationType = .words,
        keyboardType: UIKeyboardType = .default
    ) {
        self.type = type
        self.titleLabel.text = title
        self.textField.autocorrectionType = autoCorrect
        self.textField.autocapitalizationType = autoCapitalization
        self.textField.keyboardType = keyboardType
        
        super.init(frame: .zero)
        setupView(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        case .currency:
            maskCurrency()
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
    
    private func maskCurrency() {
        guard let text = textField.text else { return }
        
        let digits = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let doubleValue = (Double(digits) ?? 0) / 100.0
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.maximumFractionDigits = 2
        
        if let formatted = formatter.string(from: NSNumber(value: doubleValue)) {
            textField.text = formatted
        }
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
    
    func setText(_ text: String) {
        self.textField.text = text
    }
    
    func getText() -> String? {
        return self.textField.text
    }
}
