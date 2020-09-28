//
//  TouchView.swift
//  Games01
//
//  Created by JongHyun Park on 2020/09/25.
//

import UIKit
import Lottie

enum WaveColor:Int {
    case Black = 1
    case Blue = 2
    case Brown = 3
    case Cyan = 4
    case Yellow = 5
    case Purple = 6
    case Red = 7
    
    var wave: String {
        switch self {
        case .Black: return "blackWave"
        case .Blue: return "blueWave"
        case .Brown: return "brownWave"
        case .Cyan: return "cyanWave"
        case .Purple: return "purpleWave"
        case .Red: return "redWave"
        case .Yellow: return "yellowWave"
        }
    }
    var color: UIColor {
        switch self {
        case .Black: return UIColor.black
        case .Blue: return UIColor.blue
        case .Brown: return UIColor.brown
        case .Cyan: return UIColor.cyan
        case .Purple: return UIColor.purple
        case .Red: return UIColor.red
        case .Yellow: return UIColor.yellow
        }
    }
}


class TouchView: UIView {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var fingerView: UIView!
    
    var index:Int = 0
    var touchHashValue:Int = 0
    
    var lottieView:AnimationView!
    var waveColor:WaveColor = WaveColor.Black
    
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
        fingerView.layer.cornerRadius = fingerView.frame.width/2
    }
    
    func setHashValue(hash:Int) {
        self.touchHashValue = hash
    }
    
    func setLottie(_ waveColor:WaveColor) {
        self.waveColor = waveColor
        fingerView.backgroundColor = waveColor.color
        
        let waveColor = self.waveColor.wave
        lottieView = AnimationView(name: waveColor)
        lottieView.frame = self.bounds
        lottieView.backgroundColor = .clear
        lottieView.isHidden = true
        lottieView.animationSpeed = 3
        lottieView.loopMode = .loop
        
        self.addSubview(lottieView)
        playLottie()
    }
    
    func playLottie() {
        lottieView.isHidden = false
        if !lottieView.isAnimationPlaying {
            lottieView.play()
        }
    }
}
