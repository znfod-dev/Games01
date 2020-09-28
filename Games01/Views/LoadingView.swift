//
//  LoadingView.swift
//  Games01
//
//  Created by ParkJonghyun on 2020/09/25.
//

import UIKit
import Lottie

protocol LoadingViewDelegate: class {
    func startBtnClicked()
}


class LoadingView: UIView {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var lottieView: UIView!
    
    @IBOutlet weak var startBtn: UIButton!
    
    weak var delegate: LoadingViewDelegate?
    
    let animationView = AnimationView(name: "timer")
    
    override func awakeFromNib() {
        initUI()
    }
    
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
        ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    func initUI() {
        self.backgroundView.backgroundColor = UIColor(hex: "000000", alpha: 0.2)
    }
    
    func addLottie() {
        lottieView.isHidden = true
        
        animationView.frame = self.lottieView.bounds
        animationView.animationSpeed = 1
        animationView.loopMode = .playOnce
        lottieView.addSubview(animationView)
    }
    
    func playLottie(completion: @escaping (()->())) {
        lottieView.isHidden = false
        animationView.play { (success) in
            completion()
        }
    }
    
    func startTimer(completion: @escaping (()->())) {
        
        self.startBtn.isHidden =  true
        playLottie {
            self.isHidden = true
            completion()
        }
    }
    
    func reset() {
        self.startBtn.isHidden =  false
        lottieView.isHidden = true
        self.isHidden = false
        
    }
    
    @IBAction func startBtn(_ sender: Any) {
        
        self.delegate?.startBtnClicked()
    }
    
    
    
}
