//
//  ContentVC.swift
//  Games01
//
//  Created by JongHyun Park on 2020/09/24.
//

import UIKit
import Lottie

class ContentVC: UIViewController {
    
    
    @IBOutlet weak var contentView: UIView!
    var loadingView:LoadingView!
    
    var touchViews = Dictionary<Int, TouchView>()
    var touchList = Array<UITouch>()
    
    var limitTimer : Timer?
    
    // 현재 터치중
    var randomValues = [1,2,3,4,5,6,7]
    
    var isStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        self.setGesture()
        self.initCntView()
        
    }
    
    func initUI() {
        self.loadingView = LoadingView.loadFromNibNamed(nibNamed: "LoadingView") as? LoadingView
        self.loadingView.frame = self.view.frame
        self.loadingView.layoutIfNeeded()
        self.loadingView.addLottie()
        self.loadingView.delegate = self
        
        self.view.addSubview(self.loadingView)
        self.view.bringSubviewToFront(self.loadingView)
        
        self.view.isMultipleTouchEnabled = true
        self.contentView.isMultipleTouchEnabled = true
    }
    
    func setGesture() {
        
    }
    func initCntView() {
        
    }
    func addTouchView(touches: Set<UITouch>) {
        var index = self.touchViews.count + 1
        for touch in touches {
            if !touchViews.keys.contains(touch.hashValue) {
                let touchView = TouchView.loadFromNibNamed(nibNamed: "TouchView") as! TouchView
                touchView.frame.size = CGSize(width: 150, height: 150)
                touchView.center = touch.location(in: self.contentView)
                touchView.setHashValue(hash: touch.hashValue)
                touchView.index = index
                touchView.setLottie(WaveColor(rawValue: randomValues[index])!)
                self.contentView.addSubview(touchView)
                self.touchViews[touch.hashValue] = touchView
                self.touchList.append(touch)
                index += 1
            }
        }
    }
    
    func moveTouchView(touches: Set<UITouch>) {
        for touch in touches {
            if touchViews.keys.contains(touch.hashValue) {
                let touchView = self.touchViews[touch.hashValue]
                DispatchQueue.main.async {
                    touchView?.center = touch.location(in: self.contentView)
                }
            }
        }
    }
    
    func removeTouchView(touches: Set<UITouch>) {
        for touch in touches {
            if touchViews.keys.contains(touch.hashValue) {
                let touchView = self.touchViews[touch.hashValue]
                touchView?.removeFromSuperview()
                self.touchViews.removeValue(forKey: touch.hashValue)
                if let index = touchList.firstIndex(of: touch) {
                    touchList.remove(at: index)
                }
            }
        }
        if self.touchViews.count == 0 {
            resetRandomValues()
        }
    }
    
    func removeAllTouchView() {
        for subView in contentView.subviews {
            subView.removeFromSuperview()
        }
        self.touchViews.removeAll()
    }
    
    func resetRandomValues() {
        self.randomValues.shuffle()
        
    }
    
    @objc func limitCallback() {
        
    }
    
    @IBAction func resetBtnClicked(_ sender:UIButton) {
        self.isStarted = false
        removeAllTouchView()
        self.loadingView.reset()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan : \(touches.count)")
        if isStarted == false {
            return
        }
        
        self.addTouchView(touches: touches)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isStarted == false {
            return
        }
        moveTouchView(touches: touches)
        
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesCancelled")
        if isStarted == false {
            return
        }
        removeAllTouchView()
        resetRandomValues()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded : \(touches.count)")
        
        if isStarted == false {
            return
        }
        removeTouchView(touches: touches)
        
    }
    
}

extension ContentVC: LoadingViewDelegate {
    func startBtnClicked() {
        self.loadingView.startTimer {
            self.isStarted = true
        }
    }
}

