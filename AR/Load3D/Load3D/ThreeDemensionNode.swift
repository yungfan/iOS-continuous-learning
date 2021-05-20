//
//  ThreeDemensionNode.swift
//  Load3D
//
//  Created by 杨帆 on 2019/5/8.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit
import SceneKit

class ThreeDemensionNode: SCNNode {
    override init(){
        super.init()
        // 加载dae文件
        loadDAE()
        // 加载obj文件
        //loadOBJ()
        // 加载scn文件
        //loadSCN()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadDAE(){
        
        guard  let url = Bundle.main.url(forResource: "indoor plant_02", withExtension: "dae") else {
            fatalError("dae not exit.")
        }
        
        guard let customNode = SCNReferenceNode(url: url) else {
            fatalError("load dae error.")
        }
        
        customNode.load()
        
        self.addChildNode(customNode)
    }
    
    func loadOBJ(){
        
        guard  let url = Bundle.main.url(forResource: "indoor plant_02", withExtension: "obj") else {
            fatalError("obj not exit.")
        }
        
        guard let customNode = SCNReferenceNode(url: url) else {
            fatalError("load obj error.")
        }
        
        customNode.load()
        
        self.addChildNode(customNode)
    }
    
    //Xcode为我们提供了转化工具 选中obj文件-Editor-Covert to...
    func loadSCN(){
        
        guard  let url = Bundle.main.url(forResource: "indoor plant_02", withExtension: "scn") else {
            fatalError("scn not exit.")
        }
        
        guard let customNode = SCNReferenceNode(url: url) else {
            fatalError("load scn error.")
        }
        
        customNode.load()
        
        self.addChildNode(customNode)
    }
}

