//
//  ImageBuffer.swift
//  LLDBVisualDebugSample
//
//  Created by Fujino Suita on 2021/06/22.
//

#if DEBUG
import Foundation

final class ImageBuffer {
    typealias Pointer = UnsafeMutablePointer<UInt8>
    private let size: Int
    let pointer: Pointer

    init(size: Int) {
        self.size = size
        pointer = Pointer.allocate(capacity: size)
    }

    deinit {
        pointer.deallocate()
    }

    func getData() -> Data {
        let bufferPointer = UnsafeMutableBufferPointer(start: pointer, count: size)
        return .init(buffer: bufferPointer)
    }
}
#endif

