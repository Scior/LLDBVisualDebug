//
//  ViewController.swift
//  LLDBVisualDebugSample
//
//  Created by Fujino Suita on 2021/06/18.
//

import UIKit

final class ViewController: UIViewController {
    private let imageView = UIImageView() // TODO: Place an image
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 48),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])

        stackView.axis = .vertical
        stackView.distribution = .equalCentering

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 48),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 48),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48)
        ])

        for number in 1...3 {
            let button = UIButton()
            button.backgroundColor = .init(white: 0.8, alpha: 1)
            button.layer.cornerRadius = 4
            button.layer.masksToBounds = true
            button.setTitle("Button \(number)", for: .normal)

            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 48).isActive = true
            stackView.addArrangedSubview(button)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        // ブレークポイント置く用
        super.viewDidAppear(animated)
    }
}
