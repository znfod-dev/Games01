//
//  ContentVC.swift
//  Games01
//
//  Created by JongHyun Park on 2020/09/24.
//

import UIKit
import Lottie

class ContentVC: UIViewController {

    static func instance() -> ContentVC {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
        return vc
    }
    
    
    @IBOutlet weak var cntLbl: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    var loadingView:LoadingView!
    
    var touchViews = Dictionary<Int, TouchView>()
    var touchList = Array<UITouch>()
    
    var limitTimer : Timer?
    let resetCount = 2
    var countdown = 6
    
    // 현재 터치중
    var randomValues = [1,2,3,4,5,6,7]
    
    var isStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        
        
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
        self.countdown = resetCount
        self.cntLbl.text = "\(self.countdown)"
        self.cntLbl.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews")
        super.viewWillLayoutSubviews()
    }
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        super.viewDidAppear(animated)
    }
    
    func addTouchView(touches: Set<UITouch>) {
        var index = self.touchViews.count + 1
        for touch in touches {
            if !touchViews.keys.contains(touch.hashValue) {
                let touchView = TouchView.loadFromNibNamed(nibNamed: "TouchView") as! TouchView
                touchView.frame.size = CGSize(width: 300, height: 300)
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
    func selectOne() {
        print("self.touchList.count : \(self.touchList.count)")
        let rand:Int = Int(arc4random_uniform(UInt32(self.touchList.count)))
        print("rand : \(rand)")
        var index = 0
        for key in touchViews.keys {
            let touchView = self.touchViews[key]
            if rand != index {
                touchView?.removeFromSuperview()
                self.touchViews.removeValue(forKey: key)
            }else {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    touchView?.playBoom()
                }
            }
            index += 1
        }
    }
    
    func resetRandomValues() {
        self.randomValues.shuffle()
        
    }
    
    func checkTouchCnt() {
        if touchList.count < 2 {
            self.endGame()
        }else {
            self.startGame()
        }
    }
    
    func startGame() {
        print("start Game")
        if let timer = self.limitTimer {
            timer.invalidate()
            self.limitTimer = nil
        }
        self.countdown = resetCount
        self.cntLbl.text = "\(countdown)"
        self.cntLbl.isHidden = false
        self.limitTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(limitCallback), userInfo: nil, repeats: true)
        self.limitTimer?.fire()
    }
    
    func endGame() {
        print("endGame")
        if let timer = self.limitTimer {
            timer.invalidate()
            self.limitTimer = nil
            selectOne()
        }
        self.countdown = resetCount
        self.cntLbl.text = "\(countdown)"
        self.cntLbl.isHidden = true
        
    }
    
    @objc func limitCallback() {
        print("limitCallback")
        if self.countdown == 0 {
            self.endGame()
            self.isStarted = false
            
            
        }
        self.countdown -= 1
        self.cntLbl.text = "\(self.countdown)"
    }
    
    @IBAction func resetBtnClicked(_ sender:UIButton) {
        self.isStarted = false
        self.touchList.removeAll()
        removeAllTouchView()
        self.loadingView.reset()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isStarted == false {
            return
        }
        
        self.addTouchView(touches: touches)
        self.checkTouchCnt()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isStarted == false {
            return
        }
        moveTouchView(touches: touches)
        
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isStarted == false {
            return
        }
        removeAllTouchView()
        resetRandomValues()
        self.checkTouchCnt()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isStarted == false {
            return
        }
        removeTouchView(touches: touches)
        self.checkTouchCnt()
        
    }
    
}

extension ContentVC: LoadingViewDelegate {
    func startBtnClicked() {
        self.loadingView.startTimer {
            self.isStarted = true
        }
    }
    func endBtnClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}

