//
//  PickIconModelViewComponent.swift
//  DailyTask
//
//  Created by Luca on 09/10/23.
//

import UIKit

protocol PickIconComponentDelegate: AnyObject{
    func buttonWasPressed(_ menuIcon: String)
}

class PickIconModalViewController: UIViewController {
    
    weak var delegate: PickIconComponentDelegate?
    
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    private var sheetDetents: Double = 391

    func setUpModalConfiguration(){
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.preferredCornerRadius = 10
        sheetPresentationController?.detents = [.custom(resolver: { context in
            return self.sheetDetents
        })]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpModalConfiguration()
        
        view.backgroundColor = UIColor.white
        
        let label = LabelComponent(text: "Icons", accessibilityLabel: "Icons",font: .title3)
        
        // Create UI elements and configure your view here
        let mainStack: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 10
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          return stackView
        }()
        
        let titleStack: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          return stackView
        }()
        
        let firstStack: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 20
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          return stackView
        }()
        
        let secondStack: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 20
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          return stackView
        }()
        
        let thirdStack: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 20
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          return stackView
        }()
        
        let fourthStack: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 20
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          return stackView
        }()
        
        let fifthStack: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 20
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          return stackView
        }()
        
        //First Stack Start
        
        let imageOneView = CustomIconButton(image: UIImage(systemName: "lightbulb.fill")!)
        
        let imageTwoView = CustomIconButton(image: UIImage(systemName: "star.fill")!)
        
        let imageThreeView = CustomIconButton(image: UIImage(systemName: "trophy.fill")!)
        
        let imageFourView = CustomIconButton(image: UIImage(systemName: "pencil")!)
        
        let imageFiveView = CustomIconButton(image: UIImage(systemName: "paperclip")!)
        
        //First Stack End
        //Second Stack Start
        
        let imageSixView = CustomIconButton(image: UIImage(systemName: "scribble.variable")!)
        
        let imageSevenView = CustomIconButton(image: UIImage(systemName: "arrow.clockwise")!)
        
        let imageEightView = CustomIconButton(image: UIImage(systemName: "magnifyingglass")!)
        
        let imageNineView = CustomIconButton(image: UIImage(systemName: "books.vertical.fill")!)
        
        let imageTenView = CustomIconButton(image: UIImage(systemName: "book.fill")!)
        
        //Second Stack End
        //Third Stack Start
        
        let imageElevenView = CustomIconButton(image: UIImage(systemName: "doc.text.fill")!)
        
        let imageTwelveView = CustomIconButton(image: UIImage(systemName: "doc.on.doc.fill")!)
        
        let imageThirteenView = CustomIconButton(image: UIImage(systemName: "list.bullet.clipboard.fill")!)
        
        let imageFourteenView = CustomIconButton(image: UIImage(systemName: "doc.append.fill")!)
        
        let imageFifteenView = CustomIconButton(image: UIImage(systemName: "chart.bar.doc.horizontal.fill")!)
        

        //Third Stack End
        //Fourth Stack Start
        
        let imageSixteenView = CustomIconButton(image: UIImage(systemName: "folder.fill")!)
        
        let imageSeventeenView = CustomIconButton(image: UIImage(systemName: "tray.full.fill")!)
        
        let imageEighteenView = CustomIconButton(image: UIImage(systemName: "tray.2.fill")!)
        
        let imageNineteenView = CustomIconButton(image: UIImage(systemName: "person.fill")!)
        
        let imageTwentyView = CustomIconButton(image: UIImage(systemName: "person.3.fill")!)
            
        
        //Fourth Stack End
        //Fifth Stack Start
        
        let imageTwentyOneView = CustomIconButton(image: UIImage(systemName: "rectangle.3.group.fill")!)
        
        let imageTwentyTwoView = CustomIconButton(image: UIImage(systemName: "questionmark.bubble.fill")!)
        
        let imageTwentyThreeView = CustomIconButton(image: UIImage(systemName: "checkmark.bubble.fill")!)
        
        let imageTwentyFourView = CustomIconButton(image: UIImage(systemName: "info.bubble.fill")!)
        
        let imageTwentyFiveView = CustomIconButton(image: UIImage(systemName: "bubble.left.and.bubble.right.fill")!)
        
        //Fifth Stack End

        let tapGestureOne = UITapGestureRecognizer(target: self, action: #selector(delegateOne(_:)))
                imageOneView.addGestureRecognizer(tapGestureOne)

        let tapGestureTwo = UITapGestureRecognizer(target: self, action: #selector(delegateTwo(_:)))
                imageTwoView.addGestureRecognizer(tapGestureTwo)
        
        let tapGestureThree = UITapGestureRecognizer(target: self, action: #selector(delegateThree(_:)))
                imageThreeView.addGestureRecognizer(tapGestureThree)

        let tapGestureFour = UITapGestureRecognizer(target: self, action: #selector(delegateFour(_:)))
                imageFourView.addGestureRecognizer(tapGestureFour)
        
        let tapGestureFive = UITapGestureRecognizer(target: self, action: #selector(delegateFive(_:)))
                imageFiveView.addGestureRecognizer(tapGestureFive)
        
        let tapGestureSix = UITapGestureRecognizer(target: self, action: #selector(delegateSix(_:)))
                imageSixView.addGestureRecognizer(tapGestureSix)

        let tapGestureSeven = UITapGestureRecognizer(target: self, action: #selector(delegateSeven(_:)))
                imageSevenView.addGestureRecognizer(tapGestureSeven)
        
        let tapGestureEight = UITapGestureRecognizer(target: self, action: #selector(delegateEight(_:)))
                imageEightView.addGestureRecognizer(tapGestureEight)

        let tapGestureNine = UITapGestureRecognizer(target: self, action: #selector(delegateNine(_:)))
                imageNineView.addGestureRecognizer(tapGestureNine)
        
        let tapGestureTen = UITapGestureRecognizer(target: self, action: #selector(delegateTen(_:)))
                imageTenView.addGestureRecognizer(tapGestureTen)
        
        let tapGestureEleven = UITapGestureRecognizer(target: self, action: #selector(delegateEleven(_:)))
                imageElevenView.addGestureRecognizer(tapGestureEleven)

        let tapGestureTwelve = UITapGestureRecognizer(target: self, action: #selector(delegateTwelve(_:)))
                imageTwelveView.addGestureRecognizer(tapGestureTwelve)
        
        let tapGestureThirteen = UITapGestureRecognizer(target: self, action: #selector(delegateThirteen(_:)))
                imageThirteenView.addGestureRecognizer(tapGestureThirteen)

        let tapGestureFourteen = UITapGestureRecognizer(target: self, action: #selector(delegateFourteen(_:)))
                imageFourteenView.addGestureRecognizer(tapGestureFourteen)
        
        let tapGestureFifteen = UITapGestureRecognizer(target: self, action: #selector(delegateFifteen(_:)))
                imageFifteenView.addGestureRecognizer(tapGestureFifteen)
        
        let tapGestureSixteen = UITapGestureRecognizer(target: self, action: #selector(delegateSixteen(_:)))
                imageSixteenView.addGestureRecognizer(tapGestureSixteen)

        let tapGestureSeventeen = UITapGestureRecognizer(target: self, action: #selector(delegateSeventeen(_:)))
                imageSeventeenView.addGestureRecognizer(tapGestureSeventeen)
        
        let tapGestureEighteen = UITapGestureRecognizer(target: self, action: #selector(delegateEighteen(_:)))
                imageEighteenView.addGestureRecognizer(tapGestureEighteen)

        let tapGestureNineteen = UITapGestureRecognizer(target: self, action: #selector(delegateNineteen(_:)))
                imageNineteenView.addGestureRecognizer(tapGestureNineteen)
        
        let tapGestureTwenty = UITapGestureRecognizer(target: self, action: #selector(delegateTwenty(_:)))
                imageTwentyView.addGestureRecognizer(tapGestureTwenty)
        
        let tapGestureTwentyOne = UITapGestureRecognizer(target: self, action: #selector(delegateTwentyOne(_:)))
                imageTwentyOneView.addGestureRecognizer(tapGestureTwentyOne)
        
        let tapGestureTwentyTwo = UITapGestureRecognizer(target: self, action: #selector(delegateTwentyTwo(_:)))
                imageTwentyTwoView.addGestureRecognizer(tapGestureTwentyTwo)
        
        let tapGestureTwentyThree = UITapGestureRecognizer(target: self, action: #selector(delegateTwentyThree(_:)))
                imageTwentyThreeView.addGestureRecognizer(tapGestureTwentyThree)
        
        let tapGestureTwentyFour = UITapGestureRecognizer(target: self, action: #selector(delegateTwentyFour(_:)))
                imageTwentyFourView.addGestureRecognizer(tapGestureTwentyFour)
        
        let tapGestureTwentyFive = UITapGestureRecognizer(target: self, action: #selector(delegateTwentyFive(_:)))
                imageTwentyFiveView.addGestureRecognizer(tapGestureTwentyFive)

        
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        firstStack.addArrangedSubview(imageOneView)
        firstStack.addArrangedSubview(imageTwoView)
        firstStack.addArrangedSubview(imageThreeView)
        firstStack.addArrangedSubview(imageFourView)
        firstStack.addArrangedSubview(imageFiveView)
        
        secondStack.addArrangedSubview(imageSixView)
        secondStack.addArrangedSubview(imageSevenView)
        secondStack.addArrangedSubview(imageEightView)
        secondStack.addArrangedSubview(imageNineView)
        secondStack.addArrangedSubview(imageTenView)
        
        thirdStack.addArrangedSubview(imageElevenView)
        thirdStack.addArrangedSubview(imageTwelveView)
        thirdStack.addArrangedSubview(imageThirteenView)
        thirdStack.addArrangedSubview(imageFourteenView)
        thirdStack.addArrangedSubview(imageFifteenView)
        
        fourthStack.addArrangedSubview(imageSixteenView)
        fourthStack.addArrangedSubview(imageSeventeenView)
        fourthStack.addArrangedSubview(imageEighteenView)
        fourthStack.addArrangedSubview(imageNineteenView)
        fourthStack.addArrangedSubview(imageTwentyView)
        
        fifthStack.addArrangedSubview(imageTwentyOneView)
        fifthStack.addArrangedSubview(imageTwentyTwoView)
        fifthStack.addArrangedSubview(imageTwentyThreeView)
        fifthStack.addArrangedSubview(imageTwentyFourView)
        fifthStack.addArrangedSubview(imageTwentyFiveView)

        titleStack.addArrangedSubview(label)
        titleStack.addArrangedSubview(closeButton)
        
        mainStack.addArrangedSubview(titleStack)
        mainStack.addArrangedSubview(firstStack)
        mainStack.addArrangedSubview(secondStack)
        mainStack.addArrangedSubview(thirdStack)
        mainStack.addArrangedSubview(fourthStack)
        mainStack.addArrangedSubview(fifthStack)
        view.addSubview(mainStack)
        
        mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16).isActive = true
        firstStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        // Add constraints for the close button
//        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        closeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredContentSize: CGSize {
            get {
                return CGSize(width: super.preferredContentSize.height, height: 100)
            }
            set {
                super.preferredContentSize = newValue
            }
        }
    
    @objc func delegateOne(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("lightbulb.fill")
        self.dismiss(animated: true, completion: nil)
    }

    @objc func delegateTwo(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("star.fill")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateThree(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("trophy.fill")
        self.dismiss(animated: true, completion: nil)
    }

    @objc func delegateFour(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("pencil")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateFive(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("paperclip")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateSix(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("scribble.variable")
        self.dismiss(animated: true, completion: nil)
    }

    @objc func delegateSeven(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("arrow.clockwise")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateEight(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("magnifyingglass")
        self.dismiss(animated: true, completion: nil)
    }

    @objc func delegateNine(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("books.vertical.fill")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateTen(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("book.fill")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateEleven(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("doc.text.fill")
        self.dismiss(animated: true, completion: nil)
    }

    @objc func delegateTwelve(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("doc.on.doc.fill")
        self.dismiss(animated: true, completion: nil)
    }

    @objc func delegateThirteen(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("list.bullet.clipboard.fill")
        self.dismiss(animated: true, completion: nil)
    }

    @objc func delegateFourteen(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("doc.append.fill")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateFifteen(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("chart.bar.doc.horizontal.fill")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateSixteen(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("folder.fill")
        self.dismiss(animated: true, completion: nil)
    }

    @objc func delegateSeventeen(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("tray.full.fill")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateEighteen(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("tray.2.fill")
        self.dismiss(animated: true, completion: nil)
    }

    @objc func delegateNineteen(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("person.fill")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateTwenty(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("person.3.fill")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateTwentyOne(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("rectangle.3.group.filll")
        self.dismiss(animated: true, completion: nil)
    }

    @objc func delegateTwentyTwo(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("questionmark.bubble.fill")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateTwentyThree(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("checkmark.bubble.fill")
        self.dismiss(animated: true, completion: nil)
    }

    @objc func delegateTwentyFour(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("info.bubble.fill")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func delegateTwentyFive(_ sender: UITapGestureRecognizer) {
        delegate?.buttonWasPressed("bubble.left.and.bubble.right.fill")
        self.dismiss(animated: true, completion: nil)
    }
}

#Preview{
    PickIconModalViewController()
}

class CustomIconButton: UIButton{
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.isLayoutMarginsRelativeArrangement = true
        sv.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    init(image: UIImage){
        super.init(frame: .zero)
        
        self.image.image = image
        
        addSubview(stackView)
        stackView.addArrangedSubview(self.image)
        backgroundColor = UIColor.tertiaryBlue
        layer.cornerRadius = 10
        addAllConstraints()
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
