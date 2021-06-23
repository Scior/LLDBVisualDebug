//
//  DebugOverlayView.swift
//  LLDBVisualDebugSample
//
//  Created by Fujino Suita on 2021/06/22.
//

#if DEBUG
import CoreImage
import UIKit

final class DebugOverlayView: UIView {

    // MARK: - Enums

    private enum Mode: Int, CaseIterable {
        case normal
        case nega
        case flicker
    }

    // MARK: - Properties

    private let imageView = UIImageView()
    private let panGestureRecognizer = UIPanGestureRecognizer()
    private let tapGestureRecognizer = UITapGestureRecognizer()

    private var normalImage: UIImage?
    private var negaImage: UIImage?
    private var transformCache: CGAffineTransform = .identity
    private var mode: Mode = .normal
    private var timer: Timer?

    // MARK: - Lifecycle

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 0.5)

        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        imageView.alpha = 0.5

        panGestureRecognizer.addTarget(self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGestureRecognizer)

        tapGestureRecognizer.addTarget(self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }

    // MARK: - Methods

    func set(image: UIImage) {
        normalImage = image
        imageView.image = image

        guard let ciImage = CIImage(image: image),
            let filter = CIFilter(name: "CIColorInvert") else {
            return
        }

        filter.setValue(ciImage, forKey: kCIInputImageKey)
        if let outputImage = filter.outputImage.map(UIImage.init(ciImage:)) {
            negaImage = outputImage
        }
    }

    func set(data: Data) {
        guard let image = UIImage(data: data) else {
            return print("Broken data")
        }
        set(image: image)
    }

    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            layer.borderWidth = 2
        case .changed:
            let translation = sender.translation(in: self)
            transform = transformCache.translatedBy(x: translation.x, y: translation.y)
        case .ended:
            layer.borderWidth = 0
            transformCache = transform
        default:
            break
        }
    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        guard let nextMode = Mode(rawValue: (mode.rawValue + 1) % Mode.allCases.count) else {
            return assertionFailure("Invalid rawValue")
        }

        mode = nextMode
        imageView.alpha = mode == .flicker ? 1 : 0.5
        imageView.image = mode == .nega ? negaImage : normalImage
        imageView.isHidden = false
        
        if mode == .flicker {
            let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak imageView] _ in
                imageView?.isHidden.toggle()
            }
            self.timer = timer
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
}
#endif
