//
//  ViewController.swift
//  Tutorial-1
//
//  Created by Samantha Garcia on 12/14/18.
//  Copyright © 2018 Samantha Garcia. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add debug options
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        //Track position and rotation at all times
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }

    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    //Stops tracking position and rotation
    func restartSession () {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        //Rerun the session
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    @IBAction func add(_ sender: Any) {
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.03))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
//        let cylinderNode = SCNNode(geometry: SCNCylinder(radius: 0.05, height: 0.05))
//        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        //Position in shape
        let node = SCNNode()
        //Different kinds of shapes
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.1, height: 0.3)
//        node.geometry = SCNCylinder(radius: 0.2, height: 0.2)
//        node.geometry = SCNSphere(radius: 0.2)
//        node.geometry = SCNTube(innerRadius: 0.2, outerRadius: 0.3, height: 0.5)
//        node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.2)
//        node.geometry = SCNPlane(width: 0.2, height: 0.2)
//        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        
        //Bezier Curve
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0.0, y: 0.0))
//        path.addLine(to: CGPoint(x: 0.0, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
//        let shape = SCNShape(path: path, extrusionDepth: 0.2)
//        node.geometry = shape
        
        //Shape - gives you a sphere is measurement / 3
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        //Sceneview needs source of light
        node.geometry?.firstMaterial?.specular.contents = UIColosr.orange
        //Color spread across surface
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//        let x = randomNumbers(firstNum: -0.3, secondNum: 0.03)
//        let y = randomNumbers(firstNum: -0.3, secondNum: 0.03)
//        let z = randomNumbers(firstNum: -0.3, secondNum: 0.03)
        
        //Specify position of the node
        node.position = SCNVector3(0.2,0.3,-0.2)
        boxNode.position = SCNVector3(0, 0.05, 0)
        doorNode.position = SCNVector3(0, -0.2, 0.053)
        //Put in sceneview, positioned relative to the rootnode, not visible in the phone
        self.sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
        
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        //Gives you a flow value in between
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}

