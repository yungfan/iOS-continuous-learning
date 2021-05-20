//
//  ViewController.swift
//  Vision-BarCodesDetection
//
//  Created by 杨帆 on 2021/4/2.
//

import AVFoundation
import SafariServices
import UIKit
import Vision

class ViewController: UIViewController {
    // AVCaptureSession
    var captureSession = AVCaptureSession()

    // VNDetectBarcodesRequest
    lazy var detectBarcodeRequest = VNDetectBarcodesRequest { request, error in
        guard error == nil else {
            self.showAlert(withTitle: "扫描的码有错误", message: error?.localizedDescription ?? "error")
            return
        }
        self.processClassification(request)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 检查权限
        checkPermissions()
        // 设置摄像头扫描
        setupCameraScanView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 停止扫描
        captureSession.stopRunning()
    }
}

extension ViewController {
    // 检查权限
    private func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [self] granted in
                if !granted {
                    self.showPermissionsAlert()
                }
            }
        case .denied, .restricted:
            showPermissionsAlert()
        default:
            return
        }
    }

    // 设置扫描界面
    private func setupCameraScanView() {
        // 设置图像质量
        captureSession.sessionPreset = .hd1280x720

        // 后置摄像头
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)

        guard
            let device = videoDevice,
            let videoDeviceInput = try? AVCaptureDeviceInput(device: device),
            captureSession.canAddInput(videoDeviceInput) else {
            showAlert(
                withTitle: "相机出错",
                message: "手机摄像头出现问题")
            return
        }
        // 添加Input
        captureSession.addInput(videoDeviceInput)

        let captureOutput = AVCaptureVideoDataOutput()
        // 设置采样率
        // captureOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        // 设置AVCaptureVideoDataOutputSampleBufferDelegate，当缓冲区有新图像时代理方法调用
        captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
        // 添加OutPut
        captureSession.addOutput(captureOutput)

        // 设置预览层
        let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer.videoGravity = .resizeAspectFill
        cameraPreviewLayer.connection?.videoOrientation = .portrait
        cameraPreviewLayer.frame = view.frame
        view.layer.insertSublayer(cameraPreviewLayer, at: 0)

        // 开始扫描
        captureSession.startRunning()
    }
}

// MARK: - AVCaptureDelegation

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // 从缓冲区获取图像
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        // 用该图像生成VNImageRequestHandler
        let imageRequestHandler = VNImageRequestHandler(
            cvPixelBuffer: pixelBuffer,
            orientation: .right)

        do {
            // VNImageRequestHandler处理Request
            try imageRequestHandler.perform([detectBarcodeRequest])
        } catch {
            print(error)
        }
    }
}

// MARK: - Vision

extension ViewController {
    // Request回调
    func processClassification(_ request: VNRequest) {
        // 从results中获取Observation列表
        guard let barcodes = request.results else { return }
        DispatchQueue.main.async { [self] in
            if captureSession.isRunning {
                view.layer.sublayers?.removeSubrange(1...)

                // 循环分析Observation
                for barcode in barcodes {
                    guard
                        // 检查是否为符合要求的VNBarcodeObservation
                        let potentialQRCode = barcode as? VNBarcodeObservation,
                        potentialQRCode.symbology == .QR,
                        potentialQRCode.confidence > 0.9
                    else { return }
                    // 处理VNBarcodeObservation
                    observationHandler(confidence: potentialQRCode.confidence, payload: potentialQRCode.payloadStringValue)
                }
            }
        }
    }

    // MARK: - Handler

    func observationHandler(confidence: VNConfidence?, payload: String?) {
        guard
            let payloadString = payload,
            let url = URL(string: payloadString)
        else {
            return
        }

        let info = "\(payload ?? "empty")\n精度为\(confidence ?? 0)"
        // 如果是网址打开Safari
        if ["http", "https"].contains(url.scheme?.lowercased()) {
            print(info)
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            present(safariVC, animated: true)
        } else { // 直接显示内容
            showAlert(
                withTitle: "Info",
                message: info)
        }
    }
}

// MARK: - Helper

extension ViewController {
    private func showAlert(withTitle title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }

    private func showPermissionsAlert() {
        showAlert(
            withTitle: "摄像头权限",
            message: "请打开设置授予摄像头权限")
    }
}

// MARK: - SafariViewControllerDelegate

extension ViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print(#function)
        // 点击完成按钮后继续扫描
        captureSession.startRunning()
    }
}


