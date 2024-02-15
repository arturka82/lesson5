//
//  ViewController.swift
//  lesson5
//
//  Created by GEDAKYAN Artur on 15.02.2024.
//

import UIKit

class ViewController: UIViewController {

    let presentButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        view.backgroundColor = .white
    }

    private func setupButton() {
        presentButton.setTitle("Present", for: .normal)
        presentButton.addTarget(self, action: #selector(presentPopupController), for: .touchUpInside)
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(presentButton)

        NSLayoutConstraint.activate([
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }

    @objc private func presentPopupController() {
        let popupController = PopupController()
        popupController.modalPresentationStyle = .popover
        popupController.preferredContentSize = CGSize(width: 300, height: 280)

        
        if let popoverController = popupController.popoverPresentationController {
            popoverController.sourceView = presentButton
            popoverController.sourceRect = presentButton.bounds
            popoverController.delegate = self
        }
        present(popupController, animated: true)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}


class PopupController: UIViewController {

    private var heightConstraint: NSLayoutConstraint?
    private let heightSegmentedControl = UISegmentedControl(items: ["280pt", "150pt"])

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
    }

    private func setupUI() {
        let containerView = UIView()
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = .systemGray3
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)

        heightSegmentedControl.selectedSegmentIndex = 0
        heightSegmentedControl.addTarget(self, action: #selector(heightChanged(_:)), for: .valueChanged)
        heightSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(heightSegmentedControl)

        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(closeButton)

        heightConstraint = containerView.heightAnchor.constraint(equalToConstant: 280)
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            heightConstraint!,
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            heightSegmentedControl.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 8),
            heightSegmentedControl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }

    @objc private func heightChanged(_ sender: UISegmentedControl) {
        heightConstraint?.constant = sender.selectedSegmentIndex == 0 ? 280 : 150
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}
