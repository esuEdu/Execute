//
//  CreateModalView.swift
//  DailyTask
//
//  Created by Eduardo on 25/09/23.
//

import UIKit

class CreateModalView: UIViewController, UISheetPresentationControllerDelegate {
    
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .orange
        sheetPresentationController?.delegate = self
        sheetPresentationController?.selectedDetentIdentifier = .none
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.detents = [
            .medium()
            .large()
        ]
    }
}
