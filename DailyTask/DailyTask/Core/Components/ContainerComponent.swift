//
//  ContainerComponent.swift
//  DailyTask
//
//  Created by Eduardo on 27/09/23.
//

import UIKit

class ContainerComponent: UIView {

    let stackViewContainerTitle: UIStackView = {
        let stackViewContainerTitle = UIStackView()
        stackViewContainerTitle.axis = .horizontal
        stackViewContainerTitle.alignment = .fill
        stackViewContainerTitle.distribution = .fill
        return stackViewContainerTitle
    }()
    
    

}

#Preview(traits: .defaultLayout, body: {
    ContainerComponent()
})
