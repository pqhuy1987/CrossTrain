//
//  gallary.swift
//  ICrossCommander
//
//  Created by Lyt on 12/22/14.
//  Copyright (c) 2014 Lyt. All rights reserved.
//

import Foundation
import SpriteKit

var grav:CGFloat = 0 //scrolling gravity count
var dograv = false

class gallary: SKScene {
    
    var did = false;
    
    var back:SKSpriteNode!  //Back button
    var background:SKSpriteNode! //Background
    var gallary_content:[SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        if(did == false){
            did = true
            self.scaleMode = SKSceneScaleMode.aspectFill
            //Background
            background = SKSpriteNode(texture:SKTexture(imageNamed:"background_gallary"))
            background.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
            background.setScale(0.91)
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
            
            
            //Add 10 elements into the array
            for i in 0...9{
                let content:SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "gallary_content"))
                content.position = CGPoint(x: self.frame.midX, y: CGFloat(550 - i*130))
                content.zPosition = 2
                self.addChild(content)
                let t:SKLabelNode = SKLabelNode(text: String(i))
                content.addChild(t)
                gallary_content.append(content)
            }
            
            
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
    
    //Scrolling
     func touchesMoved(_ touches: NSSet, with event: UIEvent) {
        let touch:UITouch = touches.anyObject() as! UITouch
        
        let pnow:CGPoint = touch.location(in: self)
        let pold:CGPoint = touch.previousLocation(in: self)
        
        let tran:CGFloat = pnow.y - pold.y  //小于零向下，大于零向上
        
        
        if(tran < 0 && gallary_content[0].position.y > 550){
            //向上翻
            if(gallary_content[0].position.y + tran < 550){
                for k in 0...gallary_content.count - 1{
                    gallary_content[k].position = CGPoint(x: self.frame.midX, y: CGFloat(550 - k*130))
                }
            }else{
                grav = tran
                for i in 0...gallary_content.count - 1{
                    gallary_content[i].position.y += tran
                }
            }
        }else if(tran > 0 && gallary_content[gallary_content.count - 1].position.y < 200){
            //向下翻
            if(gallary_content[gallary_content.count - 1].position.y + tran > 200){
                for k in 0...gallary_content.count - 1{
                    gallary_content[k].position = CGPoint(x: self.frame.midX, y: CGFloat(200 + (gallary_content.count - 1 - k)*130))
                }
            }else{
                grav = tran
                for i in 0...gallary_content.count - 1{
                    gallary_content[i].position.y += tran
                }
            }
        }
        
        if(grav < -50){
            grav = -50
        }else if(grav > 50){
            grav = 50
        }
        
    }
    
     func touchesEnded(_ touches: NSSet, with event: UIEvent) {
        dograv = true
        
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
                //Set back the content places
                grav = 0
                for k in 0...self.gallary_content.count - 1{
                    self.gallary_content[k].position = CGPoint(x: self.frame.midX, y: CGFloat(550 - k*130))
                }
                Bank.storeScene(self, x: 3)
                self.view?.presentScene(Bank.getScene(1))
                transit_zheng.removeFromParent()
            })
        }
    }
    
     func touchesBegan(_ touches: NSSet, with event: UIEvent) {
        dograv = false
        
        let tnode:SKSpriteNode = self.atPoint((touches.anyObject() as! UITouch).location(in: self)) as! SKSpriteNode
        if(tnode.isEqual(back)){
            back.texture = SKTexture(imageNamed: "back_icon_t")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //This function is used to implement scrolling gravity
        if(dograv == true){
            if(grav > 0){
                //向上翻
                if(gallary_content[gallary_content.count - 1].position.y < 200){
                    if(gallary_content[gallary_content.count - 1].position.y + grav > 200){
                        for k in 0...gallary_content.count - 1{
                            gallary_content[k].position = CGPoint(x: self.frame.midX, y: CGFloat(200 + (gallary_content.count - 1 - k)*130))
                        }
                        grav = 0
                    }else{
                        for k in 0...gallary_content.count - 1{
                            gallary_content[k].position = CGPoint(x: self.frame.midX, y: gallary_content[k].position.y + grav)
                        }
                        grav -= 2.0
                        if(grav < 0){
                            grav = 0
                        }
                    }
                }else{
                    grav = 0
                }
            }else if(grav < 0){
                //向下翻
                if(gallary_content[0].position.y > 550){
                    if(gallary_content[0].position.y + grav < 550){
                        for k in 0...gallary_content.count - 1{
                            gallary_content[k].position = CGPoint(x: self.frame.midX, y: CGFloat(550 - k*130))
                        }
                        grav = 0
                    }else{
                        for k in 0...gallary_content.count - 1{
                            gallary_content[k].position = CGPoint(x: self.frame.midX, y: gallary_content[k].position.y + grav)
                        }
                        grav += 2.0
                        if(grav > 0){
                            grav = 0
                        }
                    }
                }else{
                    grav = 0
                }
            }
        }
    }


}







