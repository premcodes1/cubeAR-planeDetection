//
//  ViewController.swift
//  ARKITBASICS
//
//  Created by Prem Nalluri on 25/01/20.
//  Copyright © 2020 AgathsyaTechnologies. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = .showFeaturePoints
        
        // Create a new scene
        //////////4/////
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//        let sceneNode = scene.rootNode.childNode(withName: "ship", recursively: true)
                let scene = SCNScene(named: "art.scnassets/SAMBADANCE.scn")!
                let sceneNode = scene.rootNode.childNode(withName: "samba", recursively: true)
        
        sceneNode?.position = SCNVector3(0,0,0)
        sceneView.scene.rootNode.addChildNode(sceneNode!)
        
        sceneView.automaticallyUpdatesLighting = true
        sceneView.autoenablesDefaultLighting = true
        ////////4ends.////////////
        // Set the scene to the view
        //sceneView.scene = scene
        //////////1/////////////
//                let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
//                let boxNode = SCNNode()
//                boxNode.geometry = box
//                boxNode.position = SCNVector3(0,0,-2)
//        let scene = SCNScene()
//        scene.rootNode.addChildNode(boxNode)
//        sceneView.scene = scene
//        //////////////1ends///////////
        
        addTapGestureToSceneView()
        
        
       // let aeroPlane = sceneView.scene.rootNode.childNode(withName: "ship", recursively: false)
        //aeroPlane?.isHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
         configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        let anchor = anchor
//        let node = SCNNode()
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//        let sceneNode = scene.rootNode.childNode(withName: "ship", recursively: true)
////
       // let aeroPlaneView = SCNScene(named: "art.scnasstes/ship.scn")!
       // let shipNode = aeroPlaneView.rootNode.childNode(withName: "ship", recursively: true)
//       // let aeroPlane = scene.rootNode.childNode(withName: "ship", recursively: true)
//       // aeroPlane?.removeFromParentNode()
//        sceneNode?.isHidden = false
//        node.addChildNode(sceneNode!)
//

         let planeAnchor = anchor
        // let planeNode = SCNNode()
         let x = planeAnchor.transform.columns.3.x
         let y = planeAnchor.transform.columns.3.y
         let z = planeAnchor.transform.columns.3.z
        //planeNode!.position = SCNVector3(x: x, y: y, z: z)
        let boxNode = SCNNode()
        boxNode.position = SCNVector3(x: x, y: y, z: z)
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        boxNode.geometry = box
        sceneView.scene.rootNode.addChildNode(boxNode)
        

    }
    func addBox(x:Float=0,y:Float = 0,z:Float = -0.2){
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(x,y,z)
        sceneView.scene.rootNode.addChildNode(boxNode)
    }
    ///////2//////////
    func addTapGestureToSceneView(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func didTap(recognizer : UIGestureRecognizer){
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        
//        guard let node = hitTestResults.first?.node else{return}
//        node.removeFromParentNode()

        ////////3///////
        guard let node = hitTestResults.first?.node else{
            let hitTestResultWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
            if let hitTestResultsWithFeaturePoints = hitTestResultWithFeaturePoints.first{
                let translation = hitTestResultsWithFeaturePoints.worldTransform.transpose
               // translation.columns.0
              //  addBox(x: translation.columns.0, y: translation.columns.1, z: translation.columns.2)
                addBox()
            }
            return
        }
        node.removeFromParentNode()
       
        
    }
    ////////////2ends////////
}
