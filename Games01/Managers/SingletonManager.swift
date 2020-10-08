//
//  SingletonManager.swift
//  Games01
//
//  Created by JongHyun Park on 2020/10/07.
//

import Foundation


class SingletonManager:NSObject {
    static let shared = SingletonManager()
    
    let gameList = [Game(name: "게임1", minPlayers: 2, maxPlayers: 3, desc: "게임방법"),
                    Game(name: "게임2", minPlayers: 2, maxPlayers: 5, desc: "게임방법"),
                    Game(name: "게임3", minPlayers: 1, maxPlayers: 5, desc: "게임방법"),
                    Game(name: "게임4", minPlayers: 2, maxPlayers: 8, desc: "게임방법")]
    
    override init() {
        super.init()
    }
    
    
    
}
