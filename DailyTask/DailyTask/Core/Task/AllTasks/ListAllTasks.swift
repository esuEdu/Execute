//
//  ListAllTasks.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 04/10/23.
//

import Foundation
import UIKit

class ListAllTasks: UIViewController {
  
  var collectionView: UICollectionView!
  var collectionView2: UICollectionView!
  
  let stackViewForHeader: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    return stackView
  }()
  
  let createTask: UIButton = {
    let button = UIButton()
    button.setTitle("+ \(String(localized: "NewTaskKey"))", for: .normal)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    var config = UIButton.Configuration.filled()
    
    config.baseBackgroundColor = .systemBlue
    config.background.cornerRadius = 10
    
    let spacing: CGFloat = 5
    config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
    
    button.configuration = config
    
    return button
  }()
  
  let dateNow: LabelComponent = {
    
    let nowDate = Date.now
    let dateFormatter = DateFormatter()
    
    dateFormatter.locale = .current
    
    var language = ""
    
    if let preferredLanguage = Locale.preferredLanguages.first {
        let locale = Locale(identifier: preferredLanguage)
      let languageCode = locale.language.languageCode?.identifier // Código do idioma, por exemplo, "en" para inglês
      let regionCode = locale.region?.identifier // Código da região, por exemplo, "US" para Estados Unidos
      
      language = languageCode ?? ""
    }
    
    if language == "en" {
      dateFormatter.dateFormat = "dd, MMMM"
    } else if language == "pt" {
      dateFormatter.dateFormat = "dd 'de' MMMM"
    } else {
      dateFormatter.dateStyle = .medium
      dateFormatter.timeStyle = .none
    }
    
    let data = dateFormatter.string(from: nowDate)
    
    let label = LabelComponent(text: data, accessibilityLabel: data, font: .title1)
    label.translatesAutoresizingMaskIntoConstraints =  false
    label.textLabel.font = .boldTitle1
    return label
  }()
  
  let searchBar: UISearchBar = {
    let search = UISearchBar()
    search.placeholder = String(localized: "SearchTaskProjectKey")
    search.translatesAutoresizingMaskIntoConstraints = false
    search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    return search
  }()
  
  let projectName: LabelComponent = {
    let project = LabelComponent(text: "Titulo do projeto", accessibilityLabel: "")
    project.translatesAutoresizingMaskIntoConstraints = false
    return project
  }()
  
  let projectNameStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.backgroundColor = .systemGreen
    stackView.layer.cornerRadius = 10
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  let stackViewForTest: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
//    stackView.distribution = .fillProportionally
//    stackView.backgroundColor = .systemGreen
//    stackView.layer.cornerRadius = 10
    stackView.spacing = 20
//    stackView.isLayoutMarginsRelativeArrangement = true
//    stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  let testStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
//    stackView.distribution = .fillProportionally
//    stackView.backgroundColor = .systemGreen
//    stackView.layer.cornerRadius = 10
//    stackView.spacing = 20
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    setupConstraints()
  }
  
  func setUI(){
    
    view.backgroundColor = .systemBackground
    
    navigationController?.setNavigationBarHidden(true, animated: true)
    
    view.addSubview(stackViewForHeader)
    view.addSubview(searchBar)
    view.addSubview(stackViewForTest)
    
    searchBar.delegate = self
    
    stackViewForHeader.addArrangedSubview(dateNow)
    stackViewForHeader.addArrangedSubview(createTask)
    
    //view.addSubview(projectNameStackView)
    
    
    
    
    let layout = UICollectionViewFlowLayout()
    
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 15
    layout.minimumInteritemSpacing = 0
    layout.estimatedItemSize = CGSize(width: 340, height: 70)
    
//    collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(CustomCellCollectionView.self, forCellWithReuseIdentifier: "cell")
    
    stackViewForTest.addArrangedSubview(testStack)
    stackViewForTest.addArrangedSubview(collectionView)
    
    testStack.addArrangedSubview(projectNameStackView)
    projectNameStackView.addArrangedSubview(projectName)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      stackViewForHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
      stackViewForHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      stackViewForHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      stackViewForHeader.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -10),

        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7),
   
//      projectNameStackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
//      projectNameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//      projectNameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
     
      
//      collectionView.topAnchor.constraint(equalTo: projectNameStackView.bottomAnchor, constant: 19),
//      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//      collectionView.heightAnchor.constraint(equalToConstant: 235),
      
      
      projectNameStackView.heightAnchor.constraint(equalToConstant: 45),

      
      stackViewForTest.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
      stackViewForTest.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      
      stackViewForTest.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      stackViewForTest.heightAnchor.constraint(equalToConstant: 300),
    
 
      
    ])
  }
  
}

extension ListAllTasks: UISearchBarDelegate {
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      searchBar.setShowsCancelButton(true, animated: true)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      searchBar.setShowsCancelButton(false, animated: true)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      searchBar.endEditing(true)
  }
  
}

extension ListAllTasks: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 200
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCellCollectionView
    return cell
  }
  
}

#Preview{
  ListAllTasks()
}
