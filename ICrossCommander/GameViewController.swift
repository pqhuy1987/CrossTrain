//
//  GameViewController.swift
//  ICrossCommander
//
//  Created by Lyt on 9/8/14.
//  Copyright (c) 2014 Lyt. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(_ file : String) -> SKNode? {
        if let url = Bundle.main.url(forResource: file, withExtension: "sks") {
            do {
                let sceneData = try Data(contentsOf: url)
                let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
                
                archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
                let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! GameScene
                archiver.finishDecoding()
                return scene
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view. 
            
            Bank.storeScene(Mainplay.init(size: CGSize(width: scene.frame.width, height: scene.frame.height)), x: 2)
            Bank.storeScene(gallary.init(size: CGSize(width: scene.frame.width, height: scene.frame.height)), x: 3)
            Bank.storeScene(metric.init(size: CGSize(width: scene.frame.width, height: scene.frame.height)), x: 4)
            Bank.storeScene(leaderboard.init(size: CGSize(width: scene.frame.width, height: scene.frame.height)), x: 5)
            Bank.storeScene(missionselect.init(size: CGSize(width: scene.frame.width, height: scene.frame.height)), x: 6)
            
            
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
            
            
        }
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask(rawValue: UInt(Int(UIInterfaceOrientationMask.allButUpsideDown.rawValue)))
        } else {
            return UIInterfaceOrientationMask.all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
