//
//  ViewController.swift
//  PDFKit-Demo
//
//  Created by 杨帆 on 2022/5/28.
//

import PDFKit
import UIKit

class ViewController: UIViewController {
    // 生成的PDF路径
    lazy var fileURL: URL = {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("image.pdf")
        return fileURL
    }()

    lazy var pdfView: PDFView = {
        let pdfView = PDFView(frame: UIScreen.main.bounds)
        pdfView.document = PDFDocument(url: fileURL)
        pdfView.autoScales = true
        return pdfView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.addSubview(pdfView)
    }

    // MARK: 生成PDF
    @IBAction func generatePDF(_ sender: Any) {
        // 创建PDFDocument
        let document = PDFDocument()
        // 插入图片
        for i in 0 ... 5 {
            if let image = UIImage(named: "\(i)"), let page = PDFPage(image: image) {
                // A4
                let bounds = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
                // 设置页大小
                page.setBounds(bounds, for: .mediaBox)
                // 页数从0开始
                document.insert(page, at: i)
            }
        }
        // 生成Data
        let data = document.dataRepresentation()
        // 写入PDF
        do {
            try data?.write(to: fileURL)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
