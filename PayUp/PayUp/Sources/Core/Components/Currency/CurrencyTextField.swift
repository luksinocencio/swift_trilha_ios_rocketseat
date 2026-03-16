import UIKit

final class CurrencyTextField: UIView {
    private let title: String
    private let placeholder: String
    
    private let currencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BRL ▼", for: .normal)
        button.titleLabel?.font = Fonts.paragraphMedium()
        button.setTitleColor(Colors.textLabel, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textField: InputTextFieldView = {
        let tf = InputTextFieldView(title: self.title, placeholder: self.placeholder, type: .currency)
        tf.rightView(currencyButton)
        tf.rightViewMode(.always)
        return tf
    }()
    
    init(title: String, placeholder: String) {
        self.title = title
        self.placeholder = placeholder
        super.init(frame: .zero)
        
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
    
    func getText() -> String? {
        return textField.getText()
    }
    
    func setText(_ v: String) {
        return textField.setText(v)
    }
    
    func getValue() -> Double {
        guard let text = textField.getText() else { return 0.0 }
        
        let cleanText = text.replacingOccurrences(of: "R$", with: "")
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: ",", with: ".")
            .replacingOccurrences(of: " ", with: "")
        
        return Double(cleanText) ?? 0.0
    }
    
    func setValue(_ value: Double) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        textField.setText(formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00")
    }
}
