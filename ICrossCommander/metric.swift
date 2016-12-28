//
//  metric.swift
//  ICrossCommander
//
//  Created by Lyt on 12/22/14.
//  Copyright (c) 2014 Lyt. All rights reserved.
//

import Foundation
import SpriteKit

class metric: SKScene {
    
    var back:SKSpriteNode!
    var background:SKSpriteNode!
    var did = false;
    
    override func didMove(to view: SKView) {
        if(did == false){
            did = true
            self.scaleMode = SKSceneScaleMode.aspectFill
            //Background
            background = SKSpriteNode(texture:SKTexture(imageNamed:"background_metric"))
            background.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
            //background.setScale(0.91)
            background.zPosition = 1
            self.addChild(background)
            
            //Back button
            back = SKSpriteNode(texture: SKTexture(imageNamed: "back_icon"))
            back.position = CGPoint(x:self.frame.midX - 460, y:self.frame.midY + 235)
            back.zPosition = 6
            back.setScale(2.6)
            self.addChild(back)
            
            let transit_fan:SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "transit_zheng"))
            transit_fan.position = CGPoint(x:self.frame.midX + 130, y:self.frame.midY)
            transit_fan.zPosition = 100
            transit_fan.setScale(1.0)
            self.addChild(transit_fan)
            
            transit_fan.run(SKAction.move(to: CGPoint(x:self.frame.midX - 1200, y:self.frame.midY), duration: 0.5), completion: {()
                transit_fan.removeFromParent()
            })

        }else{
            let transit_fan:SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "transit_zheng"))
            transit_fan.position = CGPoint(x:self.frame.midX + 130, y:self.frame.midY)
            transit_fan.zPosition = 100
            transit_fan.setScale(1.0)
            self.addChild(transit_fan)
            
            transit_fan.run(SKAction.move(to: CGPoint(x:self.frame.midX - 1200, y:self.frame.midY), duration: 0.5), completion: {()
                transit_fan.removeFromParent()
            })
        }
    }
    
    
    
     func touchesEnded(_ touches: NSSet, with event: UIEvent) {
        back.texture = SKTexture(imageNamed: "back_icon")
        var tnode:SKSpriteNode = self.atPoint((touches.anyObject() as! UITouch).location(in: self)) as! SKSpriteNode
        
        if(tnode.isEqual(back)){
            //back to main
            var transit_zheng:SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "transit_zheng"))
            transit_zheng.position = CGPoint(x:self.frame.midX - 1200, y:self.frame.midY)
            transit_zheng.zPosition = 100
            transit_zheng.setScale(1.0)
            self.addChild(transit_zheng)
            
            transit_zheng.run(SKAction.move(to: CGPoint(x:self.frame.midX + 160, y:self.frame.midY), duration: 0.5), completion: {()
                Bank.storeScene(self, x: 4)
                self.view?.presentScene(Bank.getScene(1))
                transit_zheng.removeFromParent()
            })
        }
    }
    
     func touchesBegan(_ touches: NSSet,with event: UIEvent) {
        let tnode:SKSpriteNode = self.atPoint((touches.anyObject() as! UITouch).location(in: self)) as! SKSpriteNode
        if(tnode.isEqual(back)){
            back.texture = SKTexture(imageNamed: "back_icon_t")
        }
    }

}
