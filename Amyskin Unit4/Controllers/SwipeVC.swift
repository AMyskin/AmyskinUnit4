//
//  SwipeVC.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 05.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit


class SwipeVC: UIViewController {
    
    
    var imageURL: String?

    var nextImageURL: String?

    var swipeInteractionController: SwipeInteractionController?
    
    var transitionController: TransitionController? {
        return transitioningDelegate as? TransitionController
    }
    


    @IBOutlet weak var viewBeforeImage: UIView!
    @IBOutlet weak var image: UIImageView!
    lazy var nextImageView = UIImageView()
    
    var userImage : [UIImage] = []
    var userImageUrl : [String] = []
    var indexOfImage : Int = 0
    @IBOutlet weak var indexOfPhotoLabel: UILabel!
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeInteractionController = SwipeInteractionController(viewController: self)
        image.tag = 100
        
        nextImageView.contentMode = .scaleAspectFit
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.view.addGestureRecognizer(recognizer)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        //print(#function)
        print("indexOfImage=\(indexOfImage)")
        image.image = userImage[indexOfImage]
        //imageURL = userImageUrl[indexOfImage]
        indexOfPhotoLabel.text = "\(indexOfImage+1)"
        transitionController?.endView = image
        
        
    }
    
    // MARK: UICollectionViewDataSource
    static func storyboardInstance() -> SwipeVC? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "SwipeVC") as? SwipeVC
    }
    
    // MARK: - swipesAnimations
    
    
    
    var interactiveAnimator: UIViewPropertyAnimator!
    var interactiveAnimatorTopToBottom: UIViewPropertyAnimator!
    
    
    
    
    enum MyPanWay {
        case LeftToRight
        case RightToLeft
        case TopToBottom
        case BottomToTop
        case dafault
    }
    
    
    var myPanWay: MyPanWay = .dafault
    var prev: CGPoint = CGPoint(x: 0, y: 0)
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        guard let panView = recognizer.view else { return }
        
        let translation = recognizer.translation(in: panView)
        let percent = translation.y / panView.bounds.height
       // var myDirection = image.frame.size.width

    
        switch recognizer.state {
        case .began:
          
            //print(myDirection)
           // let translation = recognizer.translation(in: self.view)
            if translation.x > 0 {
                myPanWay = .LeftToRight
           //     myDirection =  self.image.frame.width
            } else if translation.x < 0 {
                myPanWay = .RightToLeft
        //        myDirection = (0 - self.image.frame.size.width)
            }
            if translation.y > 0 {
                myPanWay = .TopToBottom
         //       myDirection =  self.view.frame.size.width
            }
            //image.frame = image.frame.offsetBy(dx: 0, dy: 0)
           
            
            
            if myPanWay != .TopToBottom {
                interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                             curve: .easeInOut, animations: {
                                                               // let offsetX = self.myPanWay == .LeftToRight ? self.image.bounds.width / //2: -self.image.bounds.width / 2
//                                                                self.image.frame =
//                                                                    self.image.frame.offsetBy(dx: offsetX, dy: 0)
                                                               
                                                                self.image.alpha = 0
                                                                self.viewBeforeImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                                                                
                                                                
                                                                
                })
                if canSlide(myPanWay){
                    let nextIndex = myPanWay == .RightToLeft ? indexOfImage + 1 : indexOfImage - 1
                    nextImageView.image = userImage[nextIndex]
                    nextImageURL = userImageUrl[nextIndex]
                    
                    view.addSubview(nextImageView)
                    
                    let offsetX = myPanWay == .RightToLeft ? view.bounds.width: -view.bounds.width
                    
                    nextImageView.frame = view.bounds.offsetBy(dx: offsetX, dy: 0)
                    
                    
                    interactiveAnimator.addAnimations({
                        self.nextImageView.center = self.view.center
                        
                        //self.nextImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    }, delayFactor: 0.15)
                }
            
                interactiveAnimator.addCompletion{(position) in
                    guard position == .end  else {return}
                    self.indexOfImage = self.myPanWay == .RightToLeft ? self.indexOfImage + 1 :
                    self.indexOfImage - 1
                    self.image.alpha = 1
                    self.indexOfPhotoLabel.text = "\(self.indexOfImage+1)"
                    self.viewBeforeImage.transform = .identity
                    self.image.image = self.userImage[self.indexOfImage]
                    self.imageURL = self.userImageUrl[self.indexOfImage]
                    self.nextImageView.removeFromSuperview()
                }
                interactiveAnimator.pauseAnimation()
                
            }
            
            if myPanWay == .TopToBottom {
                
                transitionController?.interactionController = UIPercentDrivenInteractiveTransition()
                   
                dismiss(animated: true, completion: nil)

//                interactiveAnimatorTopToBottom = UIViewPropertyAnimator(duration: 0.5,
//                                                                        curve: .easeInOut, animations: {
//                                                                            self.image.frame =
//                                                                            self.image.frame.offsetBy(dx: 0, dy: myDirection)
//                })
//
//
//                interactiveAnimatorTopToBottom.pauseAnimation()
            }
            
            
            
            
        case .changed:
            
                //let translation = recognizer.translation(in: self.view)
 
                if myPanWay == .LeftToRight {
                    interactiveAnimator.fractionComplete = translation.x / self.image.frame.size.width
                } else if  myPanWay == .RightToLeft {
                    let positive = -translation.x
                    interactiveAnimator.fractionComplete = positive / self.image.frame.size.width
                }

                if  myPanWay == .TopToBottom{
                    
                    transitionController?.interactionController?.update(percent)

                   // interactiveAnimatorTopToBottom.fractionComplete = translation.y / self.image.frame.size.height
                }
               
            

            
            
        case .ended:
            
            
            if myPanWay != .TopToBottom {

                if  canSlide(myPanWay), interactiveAnimator.fractionComplete > 0.5  {
                    
                    interactiveAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                    
                    
                } else {
                    interactiveAnimator.stopAnimation(true)
                    returnAnimation()
                }
                
                
                
            }
            
            if myPanWay == .TopToBottom{
                
                if percent > 0.45 {
                      transitionController?.interactionController?.finish()
                  } else {
                    
                      transitionController?.interactionController?.cancel()
                  }
                
                
//                if  interactiveAnimatorTopToBottom.fractionComplete > 0.3 {
//
//                    interactiveAnimatorTopToBottom.continueAnimation(withTimingParameters: nil, durationFactor: 0)
//                    self.dismiss(animated: true, completion: nil)
//                } else {
//
//                    returnAnimationTop()
//                }


            }
                
            
            
  
            
            
        default: return
        }
    }
    
    private func returnAnimation() {
       

                  
                  interactiveAnimator.addAnimations {
                      self.image.frame = CGRect(x: self.image.layer.bounds.origin.x, y: self.image.layer.bounds.origin.y,   width: self.image.layer.bounds.width, height: self.image.layer.bounds.height)
                      self.image.alpha = 1
                    self.viewBeforeImage.transform = .identity
                    let offsetX = self.myPanWay == .RightToLeft ? self.view.bounds.width: -self.view.bounds.width
                    if self.canSlide(self.myPanWay) {
                        self.nextImageView.frame = self.view.bounds.offsetBy(dx: offsetX, dy: 0)
                        
                    }
                  }
                  
                  interactiveAnimator.startAnimation()
   
            // interactiveAnimator.addCompletion{(position) in
            //     guard position == .end  else {return}
            //     self.nextImageView.removeFromSuperview()
            // }
        
                
    }

    private func returnAnimationTop() {
        interactiveAnimatorTopToBottom.stopAnimation(true)

                  interactiveAnimatorTopToBottom.addAnimations {
                      self.image.frame = CGRect(x: 0, y: 0,   width: self.image.layer.bounds.width, height: self.image.layer.bounds.height)
                      self.image.alpha = 1
                    self.viewBeforeImage.transform = .identity
                  }

                  interactiveAnimatorTopToBottom.startAnimation()
    }
    
    
    
    
    
    private func changeImage(){
        
        //image.image = userImage[indexOfImage]
        imageURL = userImageUrl[indexOfImage]
        indexOfPhotoLabel.text = "\(indexOfImage+1)"
        imageAnimate()
    }
    
    
    
    private func imageAnimate(){
        
        //print(myPanWay)
        
        let fromMove = myPanWay == .LeftToRight ? -image.layer.bounds.width : image.layer.bounds.width * 2
        let toMove = myPanWay == .LeftToRight ? image.layer.bounds.width / 1.2 : image.layer.bounds.width - image.layer.bounds.width / 1.2
        
        let toValue = image.layer.bounds
        let fromValue = CGRect(x: image.layer.bounds.origin.x, y: image.layer.bounds.origin.y,   width: image.layer.bounds.width/1.7, height: image.layer.bounds.height/1.7)
        

        let animationsGroup = CAAnimationGroup()
        animationsGroup.duration = 0.5
        
        animationsGroup.fillMode = CAMediaTimingFillMode.backwards
        
        let move = CABasicAnimation(keyPath: "position.x")
        move.fromValue = fromMove
        move.toValue = toMove
        
        let translation = CABasicAnimation(keyPath: "bounds")
        translation.fromValue = fromValue
        translation.toValue = toValue
        
        let alpha = CABasicAnimation(keyPath: "opacity")
        alpha.fromValue = 0
        alpha.toValue = 0.9
        
        animationsGroup.animations = [move, translation, alpha]
        
        
        image.layer.add(animationsGroup, forKey: nil)
        
        
    }
    
    
    func canSlide(_ direction: MyPanWay) -> Bool {
        
        if direction == .RightToLeft {
            return indexOfImage < userImageUrl.count - 1
        } else {
            return indexOfImage > 0
        }
        
    }
    
    
    
}

