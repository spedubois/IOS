//
//  Game.swift
//  SpellTower
//
//  Created by u0482113 on 2/28/18.
//  Copyright © 2018 u0482113. All rights reserved.
//

import Foundation
class game {
    var gameBoard = [CellBlock]()
    var dictionary = [String]()
    var words = [String]()
    
    init()
    {
        populateDictionary()
        fillWords()
        
    }
    
    /*
     Populates a dictionary 
     */
    func populateDictionary()
    {
        let file = Bundle.main.path(forResource: "Project 3 - Dictionary", ofType: "txt")
        do{
            let contents = try! NSString(contentsOfFile: file!, encoding: String.Encoding.ascii.rawValue)
            contents.enumerateLines({(line, stop)->() in
                self.dictionary.append(line)
            })
        }
        let numWords = self.dictionary.count
        print("num words: \(numWords)")
    }
    
    func fillWords()
    {
        let wordLengthTotal = 0
        while(wordLengthTotal != 98)
        {
            let pickWordRand = Int(arc4random_uniform(UInt32(self.dictionary.count)))
            let nextWord = dictionary[pickWordRand]
            if(wordLengthTotal + nextWord.count > 98){
                continue
            }
            words.append(nextWord)
        }
    }
}
