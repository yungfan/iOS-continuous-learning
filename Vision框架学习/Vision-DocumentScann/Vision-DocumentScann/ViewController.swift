//
//  ViewController.swift
//  Vision-DocumentScann
//
//  Created by 杨帆 on 2021/4/2.
//

import UIKit
import Vision
import VisionKit

class ViewController: UIViewController {
    var documentCamera: VNDocumentCameraViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showDocumentScanner()
    }

    func showDocumentScanner() {
        // 创建 VNDocumentCameraViewController，设置代理。
        guard VNDocumentCameraViewController.isSupported else { print("Document scanning not supported"); return }
        documentCamera = VNDocumentCameraViewController()
        documentCamera?.delegate = self
        // 弹出 VNDocumentCameraViewController
        present(documentCamera!, animated: true, completion: nil)
    }
}

// 创建 VNDocumentCameraViewControllerDelegate，用于扫描回调处理
extension ViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        documentCamera?.dismiss(animated: true, completion: nil)
    }

    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        documentCamera?.dismiss(animated: true, completion: nil)
        documentCamera = nil
        // 取出扫描照片
        let img = scan.imageOfPage(at: 0)
        // 开始识别文字
        detectText(in: img)
    }
}

extension ViewController {
    func detectText(in image: UIImage) {
        guard let image = image.cgImage else {
            return
        }
        // 创建VNRecognizeTextRequest
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print("识别出现错误: \(error)")
            } else {
                // 回调
                self.handleDetectionResults(results: request.results)
            }
        }
        // 识别语言和精度
        request.recognitionLanguages = ["zh_CN", "en_US"]
        request.recognitionLevel = .accurate

        // 创建VNImageRequestHandler
        let handler = VNImageRequestHandler(cgImage: image, orientation: .up, options: [:])

        // 异步处理
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch let error {
                print("Error: \(error)")
            }
        }
    }

    func handleDetectionResults(results: [Any]?) {
        guard let results = results, results.count > 0 else {
            print("No text found")
            return
        }
        // 处理VNRecognizedTextObservation
        for result in results {
            if let observation = result as? VNRecognizedTextObservation {
                for text in observation.topCandidates(1) {
                    print(text.string) // 识别的文字
                    print(text.confidence) // 识别的精度
                    print(observation.boundingBox) // 识别的边框坐标
                    print("-----------------------------------------")
                }
            }
        }
    }
}
