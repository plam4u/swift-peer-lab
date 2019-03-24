//
//  GameViewController.swift
//  SpacePong
//
//  Created by Plamen Andreev on 3/24/19.
//  Copyright © 2019 Plamen Andreev. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func loadView() {
        view = SKView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = view as? SKView else {
            preconditionFailure("GameViewController.view should be of type SKView!")
        }

        let scene = GameScene(size: CGSize(width: 1280, height: 720))
        scene.scaleMode = .aspectFit
        view.presentScene(scene)
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
