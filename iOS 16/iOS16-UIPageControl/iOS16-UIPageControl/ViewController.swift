//
//  ViewController.swift
//  iOS16-UIPageControl
//
//  Created by 杨帆 on 2022/8/23.
//

import UIKit

class ViewController: UIViewController {
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 200, height: 500))
        pageControl.center = view.center
        pageControl.numberOfPages = 6
        // 设置方向
        pageControl.direction = .bottomToTop
        // 指示器的图片
        pageControl.preferredIndicatorImage = UIImage(systemName: "star")?
            .withTintColor(.red, renderingMode: .alwaysOriginal)
        // 当前页的图片
        pageControl.preferredCurrentPageIndicatorImage = UIImage(systemName: "star.fill")?
            .withTintColor(.red, renderingMode: .alwaysOriginal)
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(pageControl)
    }
}

