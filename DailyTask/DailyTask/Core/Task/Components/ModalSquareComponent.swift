//
//  ModalSquareComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 30/09/23.
//

import UIKit



class ModalSquareComponent: UIButton {

    let icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "backpack")
        icon.tintColor = .white
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    var label: UILabel = UILabel()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    init(text: String, iconImage: UIImage){
        super.init(frame: .zero)
        backgroundColor = .systemBlue
        layer.cornerRadius = 10
        icon.image = iconImage
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        addSubview(stackView)
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(label)
        addAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heightAnchor.constraint(equalTo: stackView.heightAnchor),
            icon.heightAnchor.constraint(equalToConstant: 40),
            icon.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
}

#Preview{
    ModalSquareComponent(text: "Teste", iconImage: UIImage(systemName: "checkmark.circle.fill")!)
}
