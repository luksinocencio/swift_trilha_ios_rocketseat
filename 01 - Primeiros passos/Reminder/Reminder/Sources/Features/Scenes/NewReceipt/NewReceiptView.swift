import UIKit

class NewReceiptView: UIView {
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = Colors.gray100
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.heading
        label.textColor = Colors.primaryRedBase
        label.text = "Nova receita"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body
        label.textColor = Colors.gray200
        label.text = "Adicione a sua prescrição médica para receber lembretes de quando tomar seu medicamento."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Adicionar", for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.backgroundColor = Colors.primaryRedBase
        button.layer.cornerRadius = 12
        button.setTitleColor(Colors.gray800, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let remedyInput = Input(title: "Rémedio", placeholder: "Nome do medicamento")
    let timeInput = Input(title: "Horário", placeholder: "12:00")
    let recurrenceInput = Input(title: "Recorrência", placeholder: "Selecione")
    let takeNowCheckbox = CheckBox(title: "Tomar agora")
    
    let stackForm: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Metrics.small
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(stackForm)
        
        stackForm.addArrangedSubview(remedyInput)
        stackForm.addArrangedSubview(timeInput)
        stackForm.addArrangedSubview(recurrenceInput)
        stackForm.setCustomSpacing(48, after: recurrenceInput)
        stackForm.addArrangedSubview(takeNowCheckbox)
        
        addSubview(addButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.small),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.small),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            
            stackForm.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metrics.small),
            stackForm.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            stackForm.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            addButton.heightAnchor.constraint(equalToConstant: 56),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.large)
        ])
    }
}
