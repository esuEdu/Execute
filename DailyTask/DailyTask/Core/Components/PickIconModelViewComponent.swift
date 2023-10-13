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
    
    private var sheetDetents: Double = 491

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
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          return stackView
        }()
        
        let secondStack: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .horizontal
            stackView.distribution = .fillEqually
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          return stackView
        }()
        
        let thirdStack: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .horizontal
            stackView.distribution = .fillEqually
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          return stackView
        }()
        
        let fourthStack: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .horizontal
            stackView.distribution = .fillEqually
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          return stackView
        }()
        
        let fifthStack: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .horizontal
            stackView.distribution = .fillEqually
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          return stackView
        }()
        
        //First Stack Start
        
        let imageOneView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "lightbulb.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()

        let imageTwoView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageThreeView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "trophy.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageFourView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "pencil"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageFiveView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "paperclip"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        //First Stack End
        //Second Stack Start
    
        let imageSixView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "scribble.variable"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()

        let imageSevenView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "arrow.clockwise"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageEightView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageNineView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "books.vertical.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageTenView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "book.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        //Second Stack End
        //Third Stack Start
        
        let imageElevenView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "doc.text.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()

        let imageTwelveView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "doc.on.doc.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageThirteenView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "list.bullet.clipboard.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageFourteenView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "doc.append.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageFifteenView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "chart.bar.doc.horizontal.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        //Third Stack End
        //Fourth Stack Start
        
        let imageSixteenView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "folder.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()

        let imageSeventeenView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "tray.full.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageEighteenView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "tray.2.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageNineteenView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "person.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageTwentyView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "person.3.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        //Fourth Stack End
        //Fifth Stack Start
        
        let imageTwentyOneView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "rectangle.3.group.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()

        let imageTwentyTwoView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "questionmark.bubble.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageTwentyThreeView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "checkmark.bubble.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageTwentyFourView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "info.bubble.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
        let imageTwentyFiveView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "bubble.left.and.bubble.right.fill"))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.tertiaryBlue
            imageView.layer.cornerRadius = 10
            return imageView
        }()
        
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
