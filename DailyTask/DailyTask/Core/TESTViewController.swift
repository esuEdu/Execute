import UIKit

class TESTViewController: UIViewController {
    
    let textField = TextFieldComponent()
    
    let scrollView = ScrollContainerComponent()
    let container = ContainerProjectsList(title: "Bom dia eh o caralho seu bando de merda", description: "Um dia o patinho feio será morto", percentage: "0")
    let container2 = ContainerProjectsList(title: "Bom noite", description: "Um dia botafogoo patinho feio será morto e o ganso inocente será o culpado", percentage: "66")
    let container3 = ContainerProjectsList(title: "Bom flamengodia", description: "Um dia o patinho feio será morto", percentage: "100")
    let container4 = ContainerProjectsList(title: "Bom noite", description: "Um dia o flamengopatinho feio será morto", percentage: "66")
    let container5 = ContainerProjectsList(title: "Bom dia", description: "Um dia o patinho feio será morto", percentage: "100")
    let container6 = ContainerProjectsList(title: "Bom noite", description: "Um dia vascoo patinho feio será morto", percentage: "66")
    let container7 = ContainerProjectsList(title: "Bom dia", description: "Um dia o vas patinho feio será morto", percentage: "0")
    let container8 = ContainerProjectsList(title: "Bom noite", description: "Umflamengo dia o patinho feio será morto", percentage: "66")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addNewElements(container)
        scrollView.addNewElements(container2)
        scrollView.addNewElements(container3)
        scrollView.addNewElements(container4)
        scrollView.addNewElements(container5)
        scrollView.addNewElements(container6)
        scrollView.addNewElements(container7)
        scrollView.addNewElements(container8)
        addAllConstraints()
        
        scrollView.contains("")
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
}

#Preview{
    TESTViewController()
}
