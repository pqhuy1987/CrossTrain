//
//  Welcome.swift
//  ICrossCommander
//
//  Created by Lyt on 11/14/14.
//  Copyright (c) 2014 Lyt. All rights reserved.
//
//  This is the scene that initial appear when enter the app

import SpriteKit

//let buttonscale_big:CGFloat = 2.5
//let buttonscale_small:CGFloat = 2.0

var Back_Rect:SKSpriteNode!     //Back
var WelcomeS:SKSpriteNode!   //电线杆
var logo:SKSpriteNode!      //Logo
var Mountain:SKSpriteNode!  //Mountain
var Heavy_rotation:SKSpriteNode!    //Rotation

var enter_game:SKSpriteNode!  //play button
var enter_gallary:SKSpriteNode!   //gallary button
var enter_metric:SKSpriteNode!  //metric button
var enter_leaderboard:SKSpriteNode!  //leaderboard button

var train_main:SKSpriteNode! //train head
var train_next:SKSpriteNode!    //train body

class GameScene: SKScene {
    
    var did = false
    
    override func didMove(to view: SKView) {
        
        if(did == false){
            did = true
            self.scaleMode = SKSceneScaleMode.aspectFill
            
            Back_Rect = SKSpriteNode(texture:SKTexture(imageNamed:"BackRect"))
            Back_Rect.position = CGPoint(x:self.frame.midX + self.frame.width/2, y:self.frame.midY)
            Back_Rect.setScale(0.91)
            Back_Rect.zPosition = 1
            self.addChild(Back_Rect)
            
            //DianXianGan
            WelcomeS = SKSpriteNode(texture:SKTexture(imageNamed:"Welcome"))
            WelcomeS.position = CGPoint(x:self.frame.midX + self.frame.width/2, y:self.frame.midY)
            WelcomeS.setScale(0.91)
            WelcomeS.zPosition = 2
            self.addChild(WelcomeS)
            
            logo = SKSpriteNode(texture:SKTexture(imageNamed:"LOGO"))
            logo.position = CGPoint(x:self.frame.midX, y:self.frame.midY + 180)
            logo.setScale(2.0)
            logo.zPosition = 3
            self.addChild(logo)
            
            //---------------------------------buttons----------------------------------------
            let scale:CGFloat = 2.8
            enter_game = SKSpriteNode(texture:SKTexture(imageNamed:"enter_game"))
            enter_game.position = CGPoint(x:self.frame.midX, y:self.frame.midY + 38)
            //enter_game.setScale(buttonscale_small)
            enter_game.zPosition = 3
            enter_game.setScale(scale)
            self.addChild(enter_game)
            
            enter_gallary = SKSpriteNode(texture:SKTexture(imageNamed:"enter_gallary"))
            enter_gallary.position = CGPoint(x:self.frame.midX - 200, y:self.frame.midY + 38)
            //enter_gallary.setScale(buttonscale_small)
            enter_gallary.zPosition = 3
            enter_gallary.setScale(scale)
            self.addChild(enter_gallary)
            
            enter_leaderboard = SKSpriteNode(texture:SKTexture(imageNamed:"enter_leaderboard"))
            enter_leaderboard.position = CGPoint(x:self.frame.midX + 200, y:self.frame.midY + 38)
            //enter_leaderboard.setScale(buttonscale_small)
            enter_leaderboard.zPosition = 3
            enter_leaderboard.setScale(scale)
            self.addChild(enter_leaderboard)
            
            enter_metric = SKSpriteNode(texture:SKTexture(imageNamed:"enter_metric"))
            enter_metric.position = CGPoint(x:self.frame.midX + 440, y:self.frame.midY + 210)
            //enter_metric.setScale(buttonscale_small)
            enter_metric.zPosition = 3
            enter_metric.setScale(scale)
            self.addChild(enter_metric)
            
            //---------------------------------model train----------------------------------------
            var randnum = Int(arc4random_uniform(2))    //0 or 1
            
            let track_ins = OnTrack()
            train_main = track_ins.GetComponent(0, train: randnum, compo: "Head")
            train_next = track_ins.GetComponent(0, train: randnum, compo: "Mid")
            
            train_main.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 149)
            train_main.setScale(0.6)
            train_main.xScale = -0.6
            train_main.zPosition = 5
            self.addChild(train_main)
            
            train_next.position = CGPoint(x:self.frame.midX - 422, y:self.frame.midY - 149)
            train_next.setScale(0.6)
            train_next.xScale = -0.6
            train_next.zPosition = 5
            self.addChild(train_next)
            
            //------------------------transition between scenes----------------------------------
            var transit_zheng:SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "transit_fan"))
            transit_zheng.position = CGPoint(x:self.frame.midX - 130, y:self.frame.midY)
            transit_zheng.zPosition = 100
            transit_zheng.setScale(1.0)
            self.addChild(transit_zheng)
            
            //Set background rolling
            let action_b:SKAction = SKAction.move(to: CGPoint(x:self.frame.midX - self.frame.width/2, y:self.frame.midY), duration: 2.5)
            let action_c:SKAction = SKAction.move(to: CGPoint(x:self.frame.midX - self.frame.width/2, y:self.frame.midY), duration: 2.5)
            
            WelcomeS.run(action_b, completion: {()
                self.repeatBack(0);
            })
            Back_Rect.run(action_c, completion: {()
                self.repeatBack(1);
            })
            
            
            transit_zheng.run(SKAction.move(to: CGPoint(x:self.frame.midX + 1200, y:self.frame.midY), duration: 0.5), completion: {()
                transit_zheng.removeFromParent()
            })

        }else{
            
            //transition between scenes
            self.isPaused = false
            
            var transit_zheng:SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "transit_fan"))
            transit_zheng.position = CGPoint(x:self.frame.midX - 130, y:self.frame.midY)
            transit_zheng.zPosition = 100
            transit_zheng.setScale(1.0)
            self.addChild(transit_zheng)
            
            transit_zheng.run(SKAction.move(to: CGPoint(x:self.frame.midX + 1200, y:self.frame.midY), duration: 0.5), completion: {()
                transit_zheng.removeFromParent()
            })
            
        }
    }
    
    
    func repeatBack(_ which:Int){
        if(which == 0){
            //If dianxiangan
            WelcomeS.position = CGPoint(x:self.frame.midX + self.frame.width/2, y:self.frame.midY)
            
            //Set background rolling
            let action_b:SKAction = SKAction.move(to: CGPoint(x:self.frame.midX - self.frame.width/2, y:self.frame.midY), duration: 2.5)
            
            WelcomeS.run(action_b, completion: {()
                self.repeatBack(which);
            })
        }else if(which == 1){
            //If dianxiangan
            Back_Rect.position = CGPoint(x:self.frame.midX + self.frame.width/2, y:self.frame.midY)
            
            //Set background rolling
            let action_c:SKAction = SKAction.move(to: CGPoint(x:self.frame.midX - self.frame.width/2, y:self.frame.midY), duration: 2.5)
            
            Back_Rect.run(action_c, completion: {()
                self.repeatBack(which);
            })
        }
        
    }
    
    
    
     func touchesEnded(_ touches: NSSet, with event: UIEvent) {
        
        var tnode:SKSpriteNode = self.atPoint((touches.anyObject() as! UITouch).location(in: self)) as! SKSpriteNode
        
        if(tnode.isEqual(enter_game) || tnode.isEqual(enter_gallary) || tnode.isEqual(enter_metric) || tnode.isEqual(enter_leaderboard)){
            
            //transition to main gameplay
            var transit_fan:SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "transit_fan"))
            transit_fan.position = CGPoint(x:self.frame.midX + 1200, y:self.frame.midY)
            transit_fan.zPosition = 100
            transit_fan.setScale(1.0)
            self.addChild(transit_fan)
            
            if(tnode.isEqual(enter_game)){
                enter_game.texture = SKTexture(imageNamed: "enter_game")
                //enter_game.setScale(buttonscale_small)
            }else if(tnode.isEqual(enter_gallary)){
                enter_gallary.texture = SKTexture(imageNamed: "enter_gallary")
                //enter_gallary.setScale(buttonscale_small)
            }else if(tnode.isEqual(enter_metric)){
                enter_metric.texture = SKTexture(imageNamed: "enter_metric")
                //enter_metric.setScale(buttonscale_small)
            }else if(tnode.isEqual(enter_leaderboard)){
                enter_leaderboard.texture = SKTexture(imageNamed: "enter_leaderboard")
                //enter_leaderboard.setScale(buttonscale_small)
            }
            
            transit_fan.run(SKAction.move(to: CGPoint(x:self.frame.midX - 130, y:self.frame.midY), duration: 0.5), completion: {()
                //------------------- transition between scene------------------
                Bank.storeScene(self, x: 1)
                if(tnode.isEqual(enter_game)){
                    self.view?.presentScene(Bank.getScene(6))
                }else if(tnode.isEqual(enter_gallary)){
                    self.view?.presentScene(Bank.getScene(3))
                }else if(tnode.isEqual(enter_metric)){
                    self.view?.presentScene(Bank.getScene(4))
                }else if(tnode.isEqual(enter_leaderboard)){
                    self.view?.presentScene(Bank.getScene(5))
                }
                
                self.isPaused = true

                transit_fan.removeFromParent()
            })
        }
    }
    
     func touchesBegan(_ touches: NSSet, with event: UIEvent) {
        
        let tnode:SKSpriteNode = self.atPoint((touches.anyObject() as! UITouch).location(in: self)) as! SKSpriteNode
        
        if(tnode.isEqual(enter_game)){
            enter_game.texture = SKTexture(imageNamed: "enter_game_t")
            //enter_game.setScale(buttonscale_big)
        }else if(tnode.isEqual(enter_gallary)){
            enter_gallary.texture = SKTexture(imageNamed: "enter_gallary_t")
            //enter_gallary.setScale(buttonscale_big)
        }else if(tnode.isEqual(enter_metric)){
            enter_metric.texture = SKTexture(imageNamed: "enter_metric_t")
            //enter_metric.setScale(buttonscale_big)
        }else if(tnode.isEqual(enter_leaderboard)){
            enter_leaderboard.texture = SKTexture(imageNamed: "enter_leaderboard_t")
            //enter_leaderboard.setScale(buttonscale_big)
        }
    }
    
     func touchesMoved(_ touches: NSSet, with event: UIEvent) {
        
        let tnode:SKSpriteNode = self.atPoint((touches.anyObject() as! UITouch).location(in: self)) as! SKSpriteNode
        
        if(tnode.isEqual(enter_game)){
            enter_game.texture = SKTexture(imageNamed: "enter_game_t")
            //enter_game.setScale(buttonscale_big)
        }else if(tnode.isEqual(enter_gallary)){
            enter_gallary.texture = SKTexture(imageNamed: "enter_gallary_t")
            //enter_gallary.setScale(buttonscale_big)
        }else if(tnode.isEqual(enter_metric)){
            enter_metric.texture = SKTexture(imageNamed: "enter_metric_t")
            //enter_metric.setScale(buttonscale_big)
        }else if(tnode.isEqual(enter_leaderboard)){
            enter_leaderboard.texture = SKTexture(imageNamed: "enter_leaderboard_t")
            //enter_leaderboard.setScale(buttonscale_big)
        }else{
            enter_game.texture = SKTexture(imageNamed: "enter_game")
            //enter_game.setScale(buttonscale_small)
            enter_gallary.texture = SKTexture(imageNamed: "enter_gallary")
            //enter_gallary.setScale(buttonscale_small)
            enter_metric.texture = SKTexture(imageNamed: "enter_metric")
            //enter_metric.setScale(buttonscale_small)
            enter_leaderboard.texture = SKTexture(imageNamed: "enter_leaderboard")
            //enter_leaderboard.setScale(buttonscale_small)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    
}








