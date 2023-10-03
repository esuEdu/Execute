//
//  TESTViewController.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 30/09/23.
//

import UIKit
import CoreData

// How to scroll up side while keyboard appears in swift 5

class TESTViewController: UIViewController {
  
  
    let container = ContainerProjectsList(title: "Pmceffnfrintmeinrnruirniefrugmmvnfjnvnjnjfnjdnfjdnfdjnfdjndjfnfdjfndjfdjfndj", description: "PmceffnfrintmeinrnruirniefrugmmvnfjnvnjnjfnjdnfjdnfdjnfdjndjfnfdjfndPmceffnfrintmeinrnruirniefrugmmvnfjnvnjnjfnjdnfjdnfdjnfdjndjfnfdjfndjfdjfndjPmceffnfrintmeinrnruirniefrugmmvnfjnvnjnjfnjdnfjdnfdjnfdjndjfnfdjfndjfdjfndjPmceffnfrintmeinrnruirniefrugmmvnfjnvnjnjfnjdnfjdnfdjnfdjndjfnfdjfndjfdjfndjPmceffnfrintmeinrnruirniefrugmmvnfjnvnjnjfnjdnfjdnfdjnfdjndjfnfdjfndjfdjfndjPmceffnfrintmeinrnruirniefrugmmvnfjnvnjnjfnjdnfjdnfdjnfdjndjfnfdjfndjfdjfndjPmceffnfrintmeinrnruirniefrugmmvnfjnvnjnjfnjdnfjdnfdjnfdjndjfnfdjfndjfdjfndjPmceffnfrintmeinrnruirniefrugmmvnfjnvnjnjfnjdnfjdnfdjnfdjndjfnfdjfndjfdjfndjjfdjfndj", percentage: "10")
    
//    let scrollView: UIScrollView = {
//        let sv = UIScrollView()
//        sv.backgroundColor = .systemYellow
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        return sv
//    }()
//    
//    let contentView: UIStackView = {
//        let view = UIStackView()
//        view.backgroundColor = .systemCyan
//        view.axis = .vertical
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    let subview1: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        view.backgroundColor = .systemRed
//        return view
//    }()
//       
//    let subview2: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.heightAnchor.constraint(equalToConstant: 500).isActive = true
//        view.backgroundColor = .systemMint
//        return view
//    }()
//       
//    let subview3: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        view.backgroundColor = .systemPurple
//        return view
//    }()
//    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
      
      view.addSubview(container)
      container.translatesAutoresizingMaskIntoConstraints =  false
        
        NSLayoutConstraint.activate([
          
          container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          container.topAnchor.constraint(equalTo: view.topAnchor),
        
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
//        contentView.addArrangedSubview(subview1)
//        contentView.addArrangedSubview(subview2)
//        contentView.addArrangedSubview(subview3)
        
        
    }

}


    
#Preview{
    TESTViewController()
}
