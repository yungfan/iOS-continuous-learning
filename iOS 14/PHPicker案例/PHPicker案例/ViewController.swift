//
//  ViewController.swift
//  PHPicker案例
//
//  Created by 杨帆 on 2020/7/4.
//

import PhotosUI
import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgFirst: UIImageView!

    @IBOutlet var imgSecond: UIImageView!

    private var picker: PHPickerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        conifgPicker()
    }

    func conifgPicker() {
        var configuration = PHPickerConfiguration()

        // 0表示不限制
        configuration.selectionLimit = 0

        // 设置能选择的类型
        configuration.filter = PHPickerFilter.any(of: [.videos, .livePhotos, .images])

        picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        present(picker, animated: true)
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        guard !results.isEmpty else { return }
        // 取第一张
        let firstItemProvider = results.first?.itemProvider
        if let itemProvider = firstItemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.imgFirst.image = image
                    }
                }
            }
        }

        // 取最后一张
        let lastItemProvider = results.last?.itemProvider
        if let itemProvider = lastItemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.imgSecond.image = image
                    }
                }
            }
        }
    }
}
