import UIKit

class TESTViewController: UIViewController {
    
    let textField = TextFieldComponent()
    
    let scrollView = ScrollContainerComponent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
//        addAllConstraints()
        
        scrollView.contains("")
    }
    
//    func addAllConstraints(){
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//        ])
//    }
    
}

#Preview{
    TESTViewController()
}
