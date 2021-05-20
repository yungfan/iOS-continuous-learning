//
//  ViewController.swift
//  LottieView使用
//
//  Created by 杨帆 on 2020/3/1.
//  Copyright © 2020 杨帆. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //loadingView()
        
        successView()
    }
    
    func loadingView(){
        
        let animationView = AnimationView()
        let animation = Animation.named("loading")
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play { _ in
            
            self.view.backgroundColor = .red
            
        }
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        
    }
    
    func successView(){
        
        let animationView = AnimationView()
        let animation = Animation.named("success")
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play { _ in
            
            animationView.removeFromSuperview()
            self.view.backgroundColor = .red
            
        }
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        
    }
    
}

