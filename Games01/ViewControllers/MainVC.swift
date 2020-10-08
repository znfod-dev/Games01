//
//  MainVC.swift
//  Games01
//
//  Created by JongHyun Park on 2020/10/03.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let gameList = SingletonManager.shared.gameList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        initUI()
        
    }
    
    func initUI() {
        self.collectionView.register(UINib(nibName: "MainCollectionCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        let layout = CircularCollectionViewLayout()
        layout.itemSize = CGSize(width: 62*4, height: 88*4)
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    
    @IBAction func cameraBtnClicked(_ sender: UIButton) {
        
        let vc = CameraVC.instance()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func fingerBtnClicked(_ sender: UIButton) {
        let vc = ContentVC.instance()
        self.present(vc, animated: true, completion: nil)
    }
    
}
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gameList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = CameraVC.instance()
            self.present(vc, animated: true, completion: nil)
        } else if indexPath.row == 1 {
            let vc = ContentVC.instance()
            self.present(vc, animated: true, completion: nil)
        } else if indexPath.row == 2 {
            
        } else if indexPath.row == 3 {
            
        } else if indexPath.row == 4 {
            
        }
    }
}

