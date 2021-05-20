//
//  ViewController.swift
//  Vision-FaceDetection
//
//  Created by 杨帆 on 2021/4/2.
//

import UIKit
import Vision

class ViewController: UIViewController {
    // 人脸检测VNDetectFaceRectanglesRequest
    lazy var faceDetectionRequest: VNDetectFaceRectanglesRequest = {
        let faceRequest = VNDetectFaceRectanglesRequest { request, error in
            guard error == nil else {
                return
            }
            self.handleFaceDetection(request: request)
        }
        return faceRequest
    }()

    // 识别图片
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 500, height: 360))
    let image = UIImage(named: "family.png")!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        imageView.center = view.center
        view.addSubview(imageView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 创建VNImageRequestHandler
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        // 异步处理
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                // 执行
                try handler.perform([self.faceDetectionRequest])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController {
    // 回调
    func handleFaceDetection(request: VNRequest) {
        // 获取人脸数据
        guard let observations = request.results as? [VNFaceObservation]
        else {
            return
        }
        // 处理VNFaceObservation
        DispatchQueue.main.async {
            // 画出所有的人脸
            for face in observations {
                let view = UIView()
                view.layer.borderColor = UIColor.red.cgColor
                view.layer.borderWidth = 2
                // 需要注意坐标的转换，boundingBox的参考系是屏幕
                view.frame = self.transformRect(fromRect: face.boundingBox, toViewRect: self.imageView)
                // 将所有的人脸添加方框
                self.imageView.addSubview(view)
            }
        }
    }

    func transformRect(fromRect: CGRect, toViewRect: UIView) -> CGRect {
        var toRect = CGRect()
        toRect.size.width = fromRect.size.width * toViewRect.frame.size.width
        toRect.size.height = fromRect.size.height * toViewRect.frame.size.height
        toRect.origin.y = toViewRect.frame.height - (toViewRect.frame.height * fromRect.origin.y)
        toRect.origin.y = toRect.origin.y - toRect.size.height
        toRect.origin.x = fromRect.origin.x * toViewRect.frame.size.width
        return toRect
    }
}
