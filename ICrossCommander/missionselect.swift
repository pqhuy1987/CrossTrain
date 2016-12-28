//
//  missionselect.swift
//  ICrossCommander
//
//  Created by Lyt on 12/23/14.
//  Copyright (c) 2014 Lyt. All rights reserved.
//

import Foundation
import SpriteKit

var zeropoint:CGFloat! //翻页效果基准中点

class missionselect:SKScene {
    
    var background:SKSpriteNode!
    var earth:SKSpriteNode!
    var back:SKSpriteNode!
    var left:SKSpriteNode!
    var right:SKSpriteNode!
    var alert_box:SKSpriteNode!
    var alert_yes:SKSpriteNode!
    var alert_no:SKSpriteNode!
    
    //var panel:SKSpriteNode!     //The panel to place missions
    
    var mission_array:[SKSpriteNode] = []    //Missions
    var did = false
    var current_page = 1    //第一页
    
    override func didMove(to view: SKView) {
        if(did == false){
            did = true
            zeropoint = self.frame.midX
            self.scaleMode = SKSceneScaleMode.aspectFill
            //Background
            background = SKSpriteNode(texture:SKTexture(imageNamed:"background_mission"))
            background.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
            background.setScale(0.91)
            background.zPosition = 1
            self.addChild(background)
            
            //earth
            earth = SKSpriteNode(texture:SKTexture(imageNamed:"Earth"))
            earth.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 550)
            earth.setScale(1.6)
            earth.zPosition = 1
            self.addChild(earth)
            
            let action_r:SKAction = SKAction.repeatForever(SKAction.rotate(byAngle: 3.0, duration: 20.0))
            earth.run(action_r)
            
            
            //Gestures
            var swipe_right = UISwipeGestureRecognizer(target: self, action: #selector(missionselect.ges_right))
            swipe_right.direction = UISwipeGestureRecognizerDirection.right
            self.view?.addGestureRecognizer(swipe_right)
            var swipe_left = UISwipeGestureRecognizer(target: self, action: #selector(missionselect.ges_left))
            swipe_left.direction = UISwipeGestureRecognizerDirection.left
            self.view?.addGestureRecognizer(swipe_left)
            
            //Back button
            back = SKSpriteNode(texture: SKTexture(imageNamed: "back_icon"))
            back.position = CGPoint(x:self.frame.midX - 460, y:self.frame.midY + 235)
            back.zPosition = 6
            back.setScale(2.6)
            self.addChild(back)
            
            //left and right
            left = SKSpriteNode(texture: SKTexture(imageNamed: "turn_page_left"))
            left.position = CGPoint(x:self.frame.midX - 440, y:self.frame.midY)
            left.zPosition = 6
            left.setScale(1.5)
            self.addChild(left)
            left.isHidden = true
            
            right = SKSpriteNode(texture: SKTexture(imageNamed: "turn_page_right"))
            right.position = CGPoint(x:self.frame.midX + 440, y:self.frame.midY)
            right.zPosition = 6
            right.setScale(1.5)
            self.addChild(right)
            
            
            //---------Alert box---------------
            alert_box = SKSpriteNode(texture:SKTexture(imageNamed:"alert_box"))
            alert_box.position = CGPoint(x:self.frame.midX + 100, y:self.frame.midY + 100)
            alert_box.setScale(0.4)
            alert_box.zRotation = -0.2
            
            alert_box.alpha = 0.0
            alert_box.zPosition = 8
            
            
            alert_yes = SKSpriteNode(texture:SKTexture(imageNamed:"alert_yes"))
            alert_yes.position = CGPoint(x:-300, y:-200)
            alert_yes.setScale(0.7)
            alert_yes.zPosition = 9
            alert_box.addChild(alert_yes)
            
            alert_no = SKSpriteNode(texture:SKTexture(imageNamed:"alert_no"))
            alert_no.position = CGPoint(x:300, y:-200)
            alert_no.setScale(0.7)
            alert_no.zPosition = 9
            alert_box.addChild(alert_no)
            
            
            //Missions
            for i in 1...5{
                //Store image in bank
                var str:NSString = NSString(format: "mission_%d", i)
                var content:UIImage = UIImage(named: str as String)!
                Bank.sc_shot.append(content)
            }
            
            for i in 1...5{
                var str:NSString = NSString(format: "mission_%d", i)
                var content:SKSpriteNode = SKSpriteNode(texture: SKTexture(image: Bank.getshot(i)))
                content.position = CGPoint(x: self.frame.midX + CGFloat(i) * self.frame.width, y: self.frame.midY)
                content.zPosition = 2
                content.setScale(0.5)
                self.addChild(content)
                mission_array.append(content)
            }
            
            var transit_fan:SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "transit_zheng"))
            transit_fan.position = CGPoint(x:self.frame.midX + 130, y:self.frame.midY)
            transit_fan.zPosition = 100
            transit_fan.setScale(1.0)
            self.addChild(transit_fan)
            
            transit_fan.run(SKAction.move(to: CGPoint(x:self.frame.midX - 1200, y:self.frame.midY), duration: 0.5), completion: {()
                transit_fan.removeFromParent()
            })
            
        }else{
            //Add gestures again
            var swipe_right = UISwipeGestureRecognizer(target: self, action: #selector(missionselect.ges_right))
            swipe_right.direction = UISwipeGestureRecognizerDirection.right
            self.view?.addGestureRecognizer(swipe_right)
            var swipe_left = UISwipeGestureRecognizer(target: self, action: #selector(missionselect.ges_left))
            swipe_left.direction = UISwipeGestureRecognizerDirection.left
            self.view?.addGestureRecognizer(swipe_left)
            
            if(Bank.getpreviousscene() == 2){
                Bank.storepreviousscene(0)  //Reset previous scene, in order to run the effect
                
                mission_array[Bank.getworld()-1].texture = SKTexture(image: Bank.getshot(Bank.getworld()))
                
                //缩小的效果
                let aa:SKAction = SKAction.scale(by: 0.5, duration: 0.3)
                mission_array[current_page - 1].run(aa)

            }else{
                var transit_fan:SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "transit_zheng"))
                transit_fan.position = CGPoint(x:self.frame.midX + 130, y:self.frame.midY)
                transit_fan.zPosition = 100
                transit_fan.setScale(1.0)
                self.addChild(transit_fan)
                
                transit_fan.run(SKAction.move(to: CGPoint(x:self.frame.midX - 1200, y:self.frame.midY), duration: 0.5), completion: {()
                    transit_fan.removeFromParent()
                })
            }
        }
    }
    
     func touchesBegan(_ touches: NSSet, with event: UIEvent) {
        let tnode:SKSpriteNode = self.atPoint((touches.anyObject() as! UITouch).location(in: self)) as! SKSpriteNode
        
        if(tnode.isEqual(back)){
            back.texture = SKTexture(imageNamed: "back_icon_t")
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
            
            //remove all gestures
            if let recognizers = self.view?.gestureRecognizers {
                for recognizer in recognizers {
                    self.view?.removeGestureRecognizer(recognizer as UIGestureRecognizer)
                }
            }
            
            transit_zheng.run(SKAction.move(to: CGPoint(x:self.frame.midX + 160, y:self.frame.midY), duration: 0.5), completion: {()
                Bank.storeScene(self, x: 6)
                self.view?.presentScene(Bank.getScene(1))
                transit_zheng.removeFromParent()
            })
        }else if(tnode.isEqual(left)){
            //向左翻页
            ges_right()
        }else if(tnode.isEqual(right)){
            //向右翻页
            ges_left()
        }else if(tnode.isEqual(alert_yes)){
            //点击yes
            var fadein_act:SKAction = SKAction.fadeAlpha(to: 0.0, duration: 0.2)
            var move_act:SKAction = SKAction.move(to: CGPoint(x:self.frame.midX - 100, y:self.frame.midY + 100), duration: 0.2)
            var rotate_act:SKAction = SKAction.rotate(byAngle: 0.2, duration: 0.2)
            var combine:[SKAction] = [fadein_act, move_act, rotate_act]
            
            var combine_act:SKAction = SKAction.group(combine)
            self.alert_box.run(combine_act, completion: {()
                self.alert_box.position = CGPoint(x:self.frame.midX + 100, y:self.frame.midY + 100)
                self.alert_box.zRotation = -0.2
                self.alert_box.removeFromParent()
                
                let aa:SKAction = SKAction.scale(by: 2.0, duration: 0.3)
                self.mission_array[self.current_page - 1].run(aa, completion: {()
                    Bank.storeworld(self.current_page)
                    Bank.storeScene(self, x: 6)
                    self.view?.presentScene(Bank.getScene(2))
                })
                
            })
            
            
        }else if(tnode.isEqual(alert_no)){
            //点击no
            fadeout_alertbox()
        }else{
            for k in 0...4{
                if(tnode.isEqual(mission_array[k])){
                    //remove all gestures
                    if let recognizers = self.view?.gestureRecognizers {
                        for recognizer in recognizers {
                            self.view?.removeGestureRecognizer(recognizer as UIGestureRecognizer)
                        }
                    }
                    
                    if(Bank.getworld() == 0 || Bank.getworld() == self.current_page){
                        //If no previous world, or going in existing world
                        //放大图像进入
                        let aa:SKAction = SKAction.scale(by: 2.0, duration: 0.3)
                        mission_array[k].run(aa, completion: {()
                            Bank.storeworld(k + 1)
                            Bank.storeScene(self, x: 6)
                            self.view?.presentScene(Bank.getScene(2))
                        })
                    }else{
                        //Else if going in a new world, pop out the box
                        fadein_alertbox()
                    }
                    
                    
                    
                    print(k)
                    
                }
            }
        }
    }
    
     func touchesMoved(_ touches: NSSet, with event: UIEvent) {
        let tnode:SKSpriteNode = self.atPoint((touches.anyObject() as! UITouch).location(in: self)) as! SKSpriteNode
        if(!tnode.isEqual(back)){
            back.texture = SKTexture(imageNamed: "back_icon")
        }
    }

    func ges_right(){
        //Handles swipe right, 向左翻页
        if(current_page != 1){
            zeropoint  = zeropoint + self.frame.width
            current_page -= 1
            
            let a1:SKAction = SKAction.fadeOut(withDuration: 0.25)
            let a2:SKAction = SKAction.fadeIn(withDuration: 0.25)
            let actt:[SKAction] = [a1, a2]
            let act:SKAction = SKAction.sequence(actt)
            left.run(act)
            if(current_page == 1){
                left.isHidden = true
                right.run(act)
            }else if(current_page == 4){
                right.isHidden = false
                left.run(act)
            }else{
                left.run(act)
                right.run(act)
            }
        }
    }
    
    func ges_left(){
        //Handles swipe left, 向右翻页
        if(current_page != 5){
            zeropoint = zeropoint - self.frame.width
            current_page += 1
            
            let a1:SKAction = SKAction.fadeOut(withDuration: 0.25)
            let a2:SKAction = SKAction.fadeIn(withDuration: 0.25)
            let actt:[SKAction] = [a1, a2]
            let act:SKAction = SKAction.sequence(actt)
            if(current_page == 2){
                left.isHidden = false
                right.run(act)
            }else if(current_page == 5){
                right.isHidden = true
                left.run(act)
            }else{
                left.run(act)
                right.run(act)
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Use to turn pages
        var v = (zeropoint - mission_array[0].position.x)/8
        if(v != 0){
            if(abs(zeropoint - mission_array[0].position.x) < 7){
                mission_array[0].position.x = zeropoint
            }else{
                if(v < 7 && v > 0){
                    v = 7
                }else if(v > -7 && v < 0){
                    v = -7
                }
                for i in 0...4{
                    mission_array[i].position.x += v
                }
            }
        }
    }
    
    
    func fadein_alertbox(){
        self.addChild(alert_box)
        
        let fadein_act:SKAction = SKAction.fadeAlpha(to: 1.0, duration: 0.2)
        let move_act:SKAction = SKAction.move(to: CGPoint(x:self.frame.midX, y:self.frame.midY), duration: 0.2)
        let rotate_act:SKAction = SKAction.rotate(byAngle: 0.2, duration: 0.2)
        let combine:[SKAction] = [fadein_act, move_act, rotate_act]
        
        let combine_act:SKAction = SKAction.group(combine)
        self.alert_box.run(combine_act)
        
    }
    
    func fadeout_alertbox(){
        
        let fadein_act:SKAction = SKAction.fadeAlpha(to: 0.0, duration: 0.2)
        let move_act:SKAction = SKAction.move(to: CGPoint(x:self.frame.midX - 100, y:self.frame.midY + 100), duration: 0.2)
        let rotate_act:SKAction = SKAction.rotate(byAngle: 0.2, duration: 0.2)
        let combine:[SKAction] = [fadein_act, move_act, rotate_act]
        
        let combine_act:SKAction = SKAction.group(combine)
        self.alert_box.run(combine_act, completion: {()
            self.alert_box.position = CGPoint(x:self.frame.midX + 100, y:self.frame.midY + 100)
            self.alert_box.zRotation = -0.2
            self.alert_box.removeFromParent()
            
        })
    }
    
}







