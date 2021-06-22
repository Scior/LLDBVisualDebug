extension UIView {
    func takeSnapshot() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }

    func convertToPNGData() -> Data {
        return takeSnapshot()!.pngData()!
    }
}
