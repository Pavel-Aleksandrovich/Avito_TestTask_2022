//
//  ListEmployeesTableCell.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import UIKit

final class ListEmployeesTableCell: UITableViewCell {
    
    static let id = String(describing: ListEmployeesTableCell.self)
    
    private let nameLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    private let skillsLabel = UILabel()
    private let vStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListEmployeesTableCell {
    
    func setModel(_ model: ListEmployeesViewModel) {
        nameLabel.text = model.employeeName
        phoneNumberLabel.text = model.phoneNumber
        skillsLabel.text = model.skills
    }
}

// MARK: - Config Appearance
private extension ListEmployeesTableCell {
    
    func configAppearance() {
        nameLabel.numberOfLines = 0
        
        phoneNumberLabel.numberOfLines = 0
        
        skillsLabel.numberOfLines = 0
        
        vStackView.axis = .vertical
        vStackView.alignment = .center
        vStackView.distribution = .fill
        vStackView.spacing = 10
    }
}

// MARK: - Make Constraints
private extension ListEmployeesTableCell {
    
    func makeConstraints() {
        addSubview(vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            vStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        vStackView.addArrangedSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        vStackView.addArrangedSubview(phoneNumberLabel)
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        vStackView.addArrangedSubview(skillsLabel)
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}
