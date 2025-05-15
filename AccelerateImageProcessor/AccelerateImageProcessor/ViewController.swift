//
//  ViewController.swift
//  AccelerateImageProcessor
//
//  Created by 杨帆 on 2025/5/15.
//

import Accelerate
import UIKit

class ViewController: UIViewController {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 259, height: 134))
        imageView.image = UIImage(named: "sample")
        imageView.center = view.center
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        blurImage()
    }

    func blurImage() {
        if let image = UIImage(named: "sample") {
            // 应用模糊效果
            if let blurredImage = ImageProcessor.applyGaussianBlur(to: image, withRadius: 30) {
                imageView.image = blurredImage
            } else {
                print("无法应用高斯模糊效果")
            }
        }
    }
}

// MARK: - Accelerate进行图像处理
class ImageProcessor {
    // MARK: 使用vImage对图像进行高斯模糊处理
    static func applyGaussianBlur(to image: UIImage, withRadius radius: Float) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        // 创建图像格式
        var format = vImage_CGImageFormat(
            bitsPerComponent: 8,
            bitsPerPixel: 32,
            colorSpace: Unmanaged.passRetained(CGColorSpaceCreateDeviceRGB()),
            bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue),
            version: 0,
            decode: nil,
            renderingIntent: .defaultIntent
        )
        // 创建vImage缓冲区
        var sourceBuffer = vImage_Buffer()
        var error = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, cgImage, vImage_Flags(kvImageNoFlags))
        guard error == kvImageNoError else { return nil }
        // 创建目标缓冲区
        var destinationBuffer = vImage_Buffer()
        destinationBuffer.data = malloc(sourceBuffer.rowBytes * Int(sourceBuffer.height))
        destinationBuffer.width = sourceBuffer.width
        destinationBuffer.height = sourceBuffer.height
        destinationBuffer.rowBytes = sourceBuffer.rowBytes
        guard destinationBuffer.data != nil else {
            free(sourceBuffer.data)
            return nil
        }
        // 计算卷积核大小，确保为奇数且至少为3
        let kernelSize = UInt32(max(3, Int(radius) | 1))
        // 应用高斯模糊
        error = vImageTentConvolve_ARGB8888(&sourceBuffer,
                                            &destinationBuffer,
                                            nil,
                                            0, 0,
                                            kernelSize, kernelSize,
                                            nil,
                                            vImage_Flags(kvImageEdgeExtend))
        guard error == kvImageNoError else {
            free(sourceBuffer.data)
            free(destinationBuffer.data)
            return nil
        }
        // 从vImage缓冲区创建新的CGImage
        guard let blurredImage = vImageCreateCGImageFromBuffer(&destinationBuffer,
                                                               &format,
                                                               nil,
                                                               nil,
                                                               vImage_Flags(kvImageNoFlags),
                                                               &error) else {
            free(sourceBuffer.data)
            free(destinationBuffer.data)
            return nil
        }
        // 释放内存
        free(sourceBuffer.data)
        free(destinationBuffer.data)
        if error != kvImageNoError {
            return nil
        }
        // 从CGImage创建UIImage
        return UIImage(cgImage: blurredImage.takeRetainedValue())
    }
}
