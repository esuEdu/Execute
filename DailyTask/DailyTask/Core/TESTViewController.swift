//
//  TESTViewController.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 30/09/23.
//

import UIKit
import CoreData

class TESTViewController: UIViewController {
    
    let icon: ModalSquareComponent = {
        let icon = ModalSquareComponent(text: "Bom dia", iconImage: UIImage(systemName: "pencil.tip" )!)
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubview(icon)
        addAllContraints()
        
        icon.addTarget(self, action: #selector(teste), for: .touchUpInside)
    }
    
    @objc func teste(){
        print("é deu ruim")
    }
    
    func addAllContraints(){
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            icon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            icon.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            icon.heightAnchor.constraint(equalToConstant: 300),
        ])
    }

}


    
#Preview{
    TESTViewController()
}
