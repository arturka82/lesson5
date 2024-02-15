//
//  ViewController.swift
//  lesson5
//
//  Created by GEDAKYAN Artur on 15.02.2024.
//

import UIKit

class ViewController: UIViewController {
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Показать", for: .normal)
        button.addAction(
            UIAction { _ in
                self.presentPopover(self, PopupViewController(), sender: self.button, size: CGSize(width: 300, height: 280))
            },
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
}

extension UIViewController: UIPopoverPresentationControllerDelegate {
    func presentPopover(_ parentViewController: UIViewController, _ viewController: UIViewController, sender: UIView, size: CGSize, arrowDirection: UIPopoverArrowDirection = .up) {
        viewController.preferredContentSize = size
        viewController.modalPresentationStyle = .popover
        if let pres = viewController.presentationController {
            pres.delegate = parentViewController
        }
        parentViewController.present(viewController, animated: true)
        if let pop = viewController.popoverPresentationController {
            pop.sourceView = sender
            pop.sourceRect = sender.bounds
            pop.permittedArrowDirections = arrowDirection
        }
    }

    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

final class PopupViewController: UIViewController {
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .black
        button.addAction(
            UIAction { _ in
                self.dismiss(animated: true, completion: nil)
            },
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["280pt", "150pt"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addAction(
            UIAction { _ in
                self.preferredContentSize = CGSize(width: 300, height: segmentedControl.selectedSegmentIndex == 0 ? 280 : 150)
            },
            for: .valueChanged
        )
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: segmentedControl.centerYAnchor, constant: 0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
    }
}
