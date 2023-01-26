//
//  ViewController.swift
//  Snake
//
//  Created by Ludwig Medqvist on 2023-01-24.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController, NSWindowDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as? SKView {
            view.setBoundsSize(NSSize(width: 400, height: 400))
            
            // Load the SKScene from 'GameScene.sks'
            let gameScene = GameScene(size: view.bounds.size)
            
            // Set the scale mode to scale to fit the window
            gameScene.scaleMode = .aspectFill
            gameScene.anchorPoint = CGPoint(x: 0.025, y: 0.025)
            // Present the scene
            view.preferredFramesPerSecond = 6;
            view.presentScene(gameScene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
    override func viewDidAppear() {
        self.view.window?.delegate = self
    }
    
    func windowWillClose(_ sender: Any){
        NSApplication.shared.terminate(self)
    }
}

