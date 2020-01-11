//
//  MenuSKScene.swift
//  ColorSwitchGame
//
//  Created by Julio Collado on 1/10/20.
//  Copyright © 2020 Julio Collado. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.appBackgroundColor
        layoutScene()
    }
    
    func layoutScene() {
        addLogo()
        addLabels()
    }
    
    func addLogo() {
        let logo = SKSpriteNode(imageNamed: "colorSwitch")
        logo.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        let action = SKAction.rotate(byAngle: .pi, duration: 2)
        
        logo.run(SKAction.repeatForever(action))
        
        addChild(logo)
    }
    
    func addLabels() {
        let playLabel = SKLabelNode(text: "Tap to Play!")
        playLabel.fontName = "AvenirNext-Bold"
        playLabel.fontSize = 50
        playLabel.fontColor = .white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        animate(label: playLabel)
        
        let hightScore = UserDefaults.standard.integer(forKey: "HightScore")
        let hightScoreLabel = SKLabelNode(text: "Hightest Score: \(hightScore)")
        hightScoreLabel.fontName = "AvenirNext-Bold"
        hightScoreLabel.fontSize = 35
        hightScoreLabel.fontColor = .white
        hightScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - hightScoreLabel.frame.height * 4)
        addChild(hightScoreLabel)
        
        let recentScore = UserDefaults.standard.integer(forKey: "RecentScore")
        let recentScoreLabel = SKLabelNode(text: "Recent Score: \(recentScore)")
        recentScoreLabel.fontName = "AvenirNext-Bold"
        recentScoreLabel.fontSize = 30
        recentScoreLabel.fontColor = .white
        recentScoreLabel.position = CGPoint(x: frame.midX, y: hightScoreLabel.position.y - recentScoreLabel.frame.height * 2)
        addChild(recentScoreLabel)
    }
    
    func animate(label: SKLabelNode) {   
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        
        let secuence = SKAction.sequence([scaleUp, scaleDown])
        label.run(SKAction.repeatForever(secuence))
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let view = view else { return }
        let gameScene = GameScene(size: view.bounds.size)
        view.presentScene(gameScene)
    }
    
}
