//
//  ViewController.swift
//  TapBubbleAnimation
//
//  Created by PHN MAC 1 on 31/05/23.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var firstBubbleView: UIView!
    @IBOutlet weak var secondBubbleView: UIView!
    
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    
    @IBOutlet weak var firstLottie: LottieAnimationView!
    @IBOutlet weak var secondLottie: LottieAnimationView!
    
    @IBOutlet weak var firstBubbleImage: UIImageView!
    @IBOutlet weak var secondBubbleImage: UIImageView!
    
    var bubbleAnimation1: UIViewPropertyAnimator!
    var bubbleAnimation2: UIViewPropertyAnimator!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configurationLottie()
        setFirstBubbleFrame()
        setSecondBubbleFrame()
        addTapGesture()
        
        startFirstViewAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
            self.startSecondViewAnimation()
        })
    }
    func configurationLottie(){
        firstLottie!.contentMode = .scaleAspectFit
        secondLottie!.contentMode = .scaleAspectFit
        firstLottie!.loopMode = .playOnce
        secondLottie!.loopMode = .playOnce
        firstLottie!.animationSpeed = 0.5
        secondLottie!.animationSpeed = 0.5
    }
    func setFirstBubbleFrame(){
        let height = containerView.frame.height
        firstBubbleView.frame = CGRect(x: 20, y: height, width: 100, height: 100)
        let firstFrame = CGRect(x: 0, y: 0, width: firstBubbleView.frame.width, height: firstBubbleView.frame.height)
        firstLbl.frame = firstFrame
        firstLottie.frame = firstFrame
        firstBubbleImage.frame = firstFrame
    }
    func setSecondBubbleFrame(){
        let width = containerView.frame.width
        let height = containerView.frame.height
        secondBubbleView.frame = CGRect(x: width-20-150, y: height, width: 150, height: 150)
        let secondFrame = CGRect(x: 0, y: 0, width: secondBubbleView.frame.width, height: secondBubbleView.frame.height)
        secondLbl.frame = secondFrame
        secondLottie.frame = secondFrame
        secondBubbleImage.frame = secondFrame
    }
   
    func addTapGesture(){
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(firstBubbleTapped))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(secondBubbleTapped))
        firstBubbleView.addGestureRecognizer(tap1)
        secondBubbleView.addGestureRecognizer(tap2)
    }
    @objc func firstBubbleTapped(){
        bubbleAnimation1.stopAnimation(true)
    }
    @objc func secondBubbleTapped(){
        bubbleAnimation2.stopAnimation(true)
    }
    
    func startFirstViewAnimation(){
        bubbleAnimation1 = UIViewPropertyAnimator(duration: 5, curve: .linear){
            UIView.animate(withDuration: 5, delay: 0.1, animations: {
                self.firstBubbleView.frame = CGRect(x: 20, y: 0, width: 100, height: 100)
            },completion: { _ in
                self.firstLbl.isHidden = true
                self.firstBubbleImage.isHidden = true
                self.firstLottie.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                    self.firstLbl.isHidden = false
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.setFirstBubbleFrame()
                    self.firstBubbleImage.isHidden = false
                    self.firstLbl.isHidden = true
                    self.startFirstViewAnimation()
                })
            })
        }
        bubbleAnimation1.startAnimation()
    }
    func startSecondViewAnimation(){
        bubbleAnimation2 = UIViewPropertyAnimator(duration: 5, curve: .linear){
            UIView.animate(withDuration: 5, delay: 0.1, animations: {
                self.secondBubbleView.frame = CGRect(x: self.containerView.frame.width-150-20, y: 0, width: 150, height: 150)
            },completion: { _ in
                self.secondLbl.isHidden = true
                self.secondBubbleImage.isHidden = true
                self.secondLottie.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                    self.secondLbl.isHidden = false
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.setSecondBubbleFrame()
                    self.secondBubbleImage.isHidden = false
                    self.firstLbl.isHidden = true
                    self.startSecondViewAnimation()
                })
            })
        }
        
        bubbleAnimation2.startAnimation()
    }
}

