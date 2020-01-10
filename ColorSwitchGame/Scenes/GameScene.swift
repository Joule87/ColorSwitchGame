//
//  GameScene.swift
//  ColorSwitchGame
//
//  Created by Julio Collado on 1/9/20.
//  Copyright © 2020 Julio Collado. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!
    var switchState = SwitchState.red
    var currentColorIndex: Int?
    
    let scoreLabel = SKLabelNode(text: "0")
    var score = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        setupPhysics()
        layoutScene()
        
    }
    
    func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self
    }
    
    func layoutColorSwitch() {
        colorSwitch = SKSpriteNode(imageNamed: "colorSwitch")
        colorSwitch.size = CGSize(width: frame.size.width / 2, height: frame.size.width / 2)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height / 2)
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/3)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory.category
        colorSwitch.physicsBody?.isDynamic = false
        colorSwitch.zPosition = ZPositions.colorSwitch
        addChild(colorSwitch)
    }
    
    func layoutScene() {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1)
        
        layoutColorSwitch()
        layoutScoreLabel()
        spawnBall()
    }
    
    func layoutScoreLabel() {
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.color = .white
        scoreLabel.zPosition = ZPositions.label
        scoreLabel.fontSize = 60
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(scoreLabel)
    }
    
    func spawnBall() {
        
        currentColorIndex = Int.random(in: 0...3)
        
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColors.colors[currentColorIndex ?? 0], size: CGSize(width: 30, height: 30))
        ball.colorBlendFactor = 1.0
        ball.name = "Ball"
        ball.zPosition = ZPositions.ball
        ball.size = CGSize(width: 30, height: 30)
        ball.position = CGPoint(x: frame.midX, y: frame.maxY - ball.size.height * 2)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory.category
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory.category
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none.category
        
        addChild(ball)
    }
    
    func turnWheel() {
        if let newState = SwitchState(rawValue: switchState.rawValue + 1) {
            switchState = newState
        } else {
            switchState = .red
        }
        
        colorSwitch.run(SKAction.rotate(byAngle: CGFloat.pi / 2, duration: 0.25))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
    
    func gameOver() {
        print("GAME OVER")
    }
    
    func proccessContact(for contact: SKPhysicsContact) {
        guard let nodeBall = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode else { return }
        
        if currentColorIndex == switchState.rawValue {
            nodeBall.run(SKAction.fadeOut(withDuration: 0.2)) {
                self.score += 5
                nodeBall.removeFromParent()
                self.spawnBall()
            }
        } else {
            gameOver()
        }
        
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        /**
         ballCategory      01
         switchCategory 10
         result                 11  ->  which is equal to (PhysicsCategories.ballCategory.category | PhysicsCategories.switchCategory.category)
         */
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategories.ballCategory.category | PhysicsCategories.switchCategory.category {
            proccessContact(for: contact)
        }
        
    }
    
}
