
//
//  Game.swift
//  SpellTower
//
//  Created by u0482113 on 2/28/18.
//  Copyright © 2018 u0482113. All rights reserved.
//

import Foundation
class game {
    var gameBoard : [CellBlock?] = Array(repeatElement(nil, count: 108))
    var dictionary = [String]()
    var words = [String]()
    
    init()
    {
        populateDictionary()
        fillWords()
        populateGameBoard()
    }
    
    /*
     Using the words generated in fillWords(), populate the game board the the player will use. The 10 blank
     squares are placed first, then the words from fillWords(), then the 4 highlighted squares.
    */
    func populateGameBoard()
    {
        
    }
    
    /*
     Populates a dictionary from a list of valid words. This dictionary will be used to check if words fromed by player are valid.
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
        print("num words: \(numWords)") // DELETE THIS ON FINAL
    }
    
    /*
     Randomly selects words from the dictionary to be used to populate a game board. Total length of all the strings used must not exceed 98. Words that are selected are also scrambled, so when they are placed on the board, they aren't in order.
    */
    func fillWords()
    {
        var wordLengthTotal = 0
        while(wordLengthTotal < 94)
        {
            let pickWordRand = Int(arc4random_uniform(UInt32(self.dictionary.count)))
            let nextWord = dictionary[pickWordRand]
            if(wordLengthTotal + nextWord.count > 98){
                continue
            }
            words.append(scramble(word: nextWord))
            wordLengthTotal += nextWord.count
        }
        print("total length of words: \(wordLengthTotal)") // DELETE THIS ON FINAL
    }
    
    /*
     Takes in a string, and scrambles it's characters.
    */
    func scramble(word : String) -> String{
        var charArray = Array(word)
        for i in 0..<(word.count-1){
            let r = Int(arc4random_uniform(UInt32(word.count)))
            guard i != r else {continue}
            let temp = charArray[i];
            charArray[i] = charArray[r];
            charArray[r] = temp;
        }
        return String(charArray);
    }
}
