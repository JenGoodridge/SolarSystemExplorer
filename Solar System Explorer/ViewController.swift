//
//  ViewController.swift
//  Solar System Explorer
//
//  Created by Jennifer Goodridge on 8/1/17.
//  Copyright © 2017 Jennifer Goodridge. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        
        // Negative position is to the left on the x-axis; positive is to the right.
        // Earth will be centered here.
        let planets = ["mercury": (radius: 0.01,   position:  0.50),
                       "venus":   (radius: 0.024,  position:  0.25),
                       "earth":   (radius: 0.025,  position:  0.00),
                       "mars":    (radius: 0.0125, position: -0.35),
                       "jupiter": (radius: 0.32,   position: -0.95),
                       "saturn":  (radius: 0.28,   position: -1.85),
                       "uranus":  (radius: 0.1,    position: -2.45),
                       "neptune": (radius: 0.1,    position: -3.05)]
        
        for (key: name, value: (radius: radius, position: position)) in planets {
            let sphere = SCNSphere(radius: CGFloat(radius))
            let texture = SCNMaterial()
            // The texture is loaded from an image in Assets.xcassets.
            texture.diffuse.contents = UIImage(named: "\(name).jpg")
            sphere.materials = [texture]
            
            let node = SCNNode()
            node.geometry = sphere
            node.position = SCNVector3(position, 0.0, -2.0)
            scene.rootNode.addChildNode(node)
        }
        
        sceneView.scene = scene
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // The ARKit session must be manually started with a new tracking configuration.
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // No need to keep this running while the view isn't showing.
        sceneView.session.pause()
    }
}
