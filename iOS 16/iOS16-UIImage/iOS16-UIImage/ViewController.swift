//
//  ViewController.swift
//  iOS16-UIImage
//
//  Created by 杨帆 on 2022/8/23.
//

import Combine
import UIKit

class ViewController: UIViewController {
    // 可变色度
    lazy var variable: Double = 0 {
        didSet {
            // 新的构造函数，支持可变渲染
            let image = UIImage(systemName: "touchid", variableValue: variable, configuration: symbolConfig)
            imageView.image = image
        }
    }
    // 配置图标的渲染颜色
    let symbolConfig = UIImage.SymbolConfiguration(paletteColors: [.systemTeal, .systemGreen])
    var cancellables: [AnyCancellable] = []
    // Combine定时器
    let timer = Timer.publish(every: 0.2, on: .main, in: .common)
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "touchid", variableValue: 0, configuration: symbolConfig))
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.contentMode = .scaleAspectFit
        imageView.center = view.center
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 动态调整Variable图标
        timer
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                switch self.variable {
                case 0:
                    self.variable = 0.2
                case 0.2:
                    self.variable = 0.4
                case 0.4:
                    self.variable = 0.6
                case 0.6:
                    self.variable = 0.8
                case 0.8:
                    self.variable = 1.0
                case 1.0:
                    self.variable = 0.9
                case 0.9:
                    self.variable = 0.7
                case 0.7:
                    self.variable = 0.5
                case 0.5:
                    self.variable = 0.3
                case 0.3:
                    self.variable = 0.1
                default:
                    self.variable = 0
                }
            }
            .store(in: &cancellables)
    }
}
