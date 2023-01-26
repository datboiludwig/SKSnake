//
//  GameScene.swift
//  Snake
//
//  Created by Ludwig Medqvist on 2023-01-24.
//

import Foundation
import SpriteKit

let w = 400, h = 400

let gridSize = 20, tileCount = 20



class GameScene: SKScene, SKPhysicsContactDelegate {
    
	var score = 0;
	
	var x = 10, y = 10
	var foodX = Int.random(in: 1..<tileCount)
	var foodY = Int.random(in: 1..<tileCount)
	var dx = 1, dy = 0;

	var trail = Array<TailPiece>();
	var tail = 5;
    
	let playerNode = SKSpriteNode(color: SKColor.green, size: CGSize(width: gridSize-2, height: gridSize-2))
	let foodNode = SKSpriteNode(color: SKColor.red, size: CGSize(width: gridSize-2, height: gridSize-2))
	let scoreNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.black
        
		scoreNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left;
		scoreNode.position = CGPoint(x: 0, y: 0)
		scoreNode.fontName = "Sans-Serif"
		scoreNode.fontSize = 24;
		scoreNode.color = SKColor.white
		
    }
    
	override func update(_ currentTime: TimeInterval) {
		self.removeAllChildren()
		
		x += self.dx;
		y += self.dy;
		
		if(foodX==x && foodY==y) {
			tail += 1
			foodX = Int.random(in: 1..<tileCount)
			foodY = Int.random(in: 1..<tileCount)
			score += 1;
		}
		
		if(x < 0) {
			tail = 5
			trail.removeAll()
			x = 10; y = 10;
			score = 0
		}
		if(x > tileCount-1) {
			tail = 5
			trail.removeAll()
			x = 10; y = 10;
			score = 0
		}
		if(y < 0) {
			tail = 5
			trail.removeAll()
			x = 10; y = 10;
			score = 0
		}
		if(y > tileCount-1) {
			tail = 5
			trail.removeAll()
			x = 10; y = 10;
			score = 0
		}
		
		for i in 0..<trail.count {
			let tailNode = SKSpriteNode()
			if(i > 0) {
				if(trail[i-1].x < trail[i].x) {
					let connectNode = SKSpriteNode(color: SKColor.green, size: CGSize(width: 4, height: gridSize-2))
					connectNode.position = CGPoint(x: trail[i].x*gridSize-gridSize/2, y: trail[i].y*gridSize+1)
					self.addChild(connectNode)
				}
				if(trail[i-1].x > trail[i].x) {
					let connectNode = SKSpriteNode(color: SKColor.green, size: CGSize(width: 4, height: gridSize-2))
					connectNode.position = CGPoint(x: trail[i].x*gridSize+gridSize/2, y: trail[i].y*gridSize+1)
					self.addChild(connectNode)
				}
				if(trail[i-1].y < trail[i].y) {
					let connectNode = SKSpriteNode(color: SKColor.green, size: CGSize(width: gridSize-2, height: 4))
					connectNode.position = CGPoint(x: trail[i].x*gridSize+1, y: trail[i].y*gridSize-gridSize/2)
					self.addChild(connectNode)
				}
				if(trail[i-1].y > trail[i].y) {
					let connectNode = SKSpriteNode(color: SKColor.green, size: CGSize(width: gridSize-2, height: 4))
					connectNode.position = CGPoint(x: trail[i].x*gridSize+1, y: trail[i].y*gridSize+gridSize/2)
					self.addChild(connectNode)
				}
			} else {
				if(self.x < trail[i].x) {
					let connectNode = SKSpriteNode(color: SKColor.green, size: CGSize(width: 4, height: gridSize-2))
					connectNode.position = CGPoint(x: trail[i].x*gridSize-gridSize/2, y: trail[i].y*gridSize+1)
					self.addChild(connectNode)
				}
				if(self.x > trail[i].x) {
					let connectNode = SKSpriteNode(color: SKColor.green, size: CGSize(width: 4, height: gridSize-2))
					connectNode.position = CGPoint(x: trail[i].x*gridSize+gridSize/2, y: trail[i].y*gridSize+1)
					self.addChild(connectNode)
				}
				if(self.y < trail[i].y) {
					let connectNode = SKSpriteNode(color: SKColor.green, size: CGSize(width: gridSize-2, height: 4))
					connectNode.position = CGPoint(x: trail[i].x*gridSize+1, y: trail[i].y*gridSize-gridSize/2)
					self.addChild(connectNode)
				}
				if(self.y > trail[i].y) {
					let connectNode = SKSpriteNode(color: SKColor.green, size: CGSize(width: gridSize-2, height: 4))
					connectNode.position = CGPoint(x: trail[i].x*gridSize+1, y: trail[i].y*gridSize+gridSize/2)
					self.addChild(connectNode)
				}
			}
			tailNode.position = CGPoint(x: trail[i].x*gridSize+1, y: trail[i].y*gridSize+1)
			tailNode.size = CGSize(width: gridSize-2, height: gridSize-2)
			tailNode.color = SKColor.green
			self.addChild(tailNode)
			if(trail[i].x==x && trail[i].y==y) {
				tail = 5;
				trail.removeAll()
				x = 10; y = 10;
				score = 0;
				break;
			}
		}
		
		scoreNode.text = "Score: " + String(score);
		
		trail.insert(TailPiece(x: x, y: y), at: 0)
		while(trail.count>tail) {
			trail.removeLast()
		}
		
		self.playerNode.position = CGPoint(x: x*gridSize+1, y: y*gridSize+1)
		self.foodNode.position = CGPoint(x: foodX*gridSize+1, y: foodY*gridSize+1)
		
		self.addChild(playerNode)
		self.addChild(foodNode)
		self.addChild(scoreNode)
	}
	
	override func keyDown(with event: NSEvent) {
		switch(event.keyCode) {
		case 0x7B:
			if(dx != 1) {dx = -1; dy = 0;}
			break;
		case 0x7D:
			if(dy != 1) {dx = 0;  dy = -1;}
			break;
		case 0x7C:
			if(dx != -1) {dx = 1;  dy = 0;}
			break;
		case 0x7E:
			if(dy != -1) {dx = 0;  dy = 1;}
			break;
		default:
			break;
		}
	}
	
}

struct TailPiece {
	var x: Int, y: Int;
	
	init(x: Int, y: Int) {
		self.x = x
		self.y = y
	}
}
