//
//  GameScene.swift
//  SpacePong
//
//  Created by Plamen Andreev on 3/24/19.
//  Copyright © 2019 Plamen Andreev. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    let paddleSpeed: CGFloat = 7.5
    let leftPaddle = SKShapeNode(rect: CGRect(x: 0, y: -50, width: 20, height: 100))
    let rightPaddle = SKShapeNode(rect: CGRect(x: 0, y: -50, width: 20, height: 100))
    let ball = SKShapeNode(rectOf: CGSize(width: 20, height: 20))

    override func didMove(to view: SKView) {
        leftPaddle.position = CGPoint(x: 100, y: size.height / 2)
        leftPaddle.fillColor = .white
        addChild(leftPaddle)

        rightPaddle.position = CGPoint(x: size.width - 100 - 20, y: size.height / 2)
        rightPaddle.fillColor = .white
        addChild(rightPaddle)

        ball.position = CGPoint(x: size.width / 2, y: size.height / 2)
        ball.fillColor = .white
        addChild(ball)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            rightPaddle.position.y = location.y
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func update(_ currentTime: TimeInterval) {
        moveComputerPaddle()
    }

    func moveComputerPaddle() {
        let ballY = ball.position.y
        let paddleY = leftPaddle.position.y
        let yDirection: CGFloat

        if abs(ballY - paddleY) < paddleSpeed {
            leftPaddle.position.y = ballY
        } else {
            if ballY > paddleY {
                yDirection = 1
            } else if ballY < paddleY {
                yDirection = -1
            } else {
                yDirection = 0
            }
            leftPaddle.position.y += paddleSpeed * yDirection
        }
    }
}
