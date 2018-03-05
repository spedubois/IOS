
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
        var i = 0
        while(i < 4)
        {
            let pickSpot = Int(arc4random_uniform(UInt32(108)))
            if(gameBoard[pickSpot] != nil)
            {
                continue
            }
            gameBoard[pickSpot] = CellBlock(letter: "", type: "empty")
            i+=1
        }
        
        for word in words
        {
            placeWordOnBoard(word: word)
        }
    }
    
    func placeWordOnBoard(word: String)
    {
        let charArray = Array(word)
        var i = 0
        var startFound = false
        var indexToPlace = 0
        while(!startFound)
        {
            let pickStart = Int(arc4random_uniform(109))
            if(gameBoard[pickStart] != nil)
            {
                continue
            }
            startFound = true
            indexToPlace = pickStart
        }
       
        var path : [Int?] = Array(repeatElement(-1, count: word.count))
        path = findWordPath(startIndex: indexToPlace, count: 0, pathArray: path as! [Int]).1
        
    }
    
    func findWordPath(startIndex: Int, count: Int, pathArray: [Int]) -> (Bool, [Int])
    {
        var newPathArray = pathArray
        if(count == pathArray.count - 1)
        {
            if(gameBoard[startIndex] == nil && !newPathArray.contains(startIndex)){
                newPathArray[count] = startIndex
                return (true, newPathArray)
            }
            return (false, newPathArray)
        }
        newPathArray[count] = startIndex
        var direction = Int(arc4random_uniform(8))
        let firstPicked = direction
        while(true)
        {
            if(direction > 7)
            {
                direction = 0
            }
            switch(direction)
            {
            case 0:
                if(startIndex + 9 < 108 && gameBoard[startIndex+9] == nil && !pathArray.contains(startIndex+9))
                {
                    let recurs = findWordPath(startIndex: startIndex + 9, count: count + 1, pathArray: newPathArray)
                    if(recurs.0)
                    {
                        return (true, recurs.1)
                    }
                    break
                }
            case 1:
                if(startIndex - 9 >= 0 && gameBoard[startIndex-9] == nil && !pathArray.contains(startIndex-9))
                {
                    let recurs = findWordPath(startIndex: startIndex - 9, count: count + 1, pathArray: newPathArray)
                    if(recurs.0)
                    {
                        return (true, recurs.1)
                    }
                    break
                }
            case 2:
                if((startIndex + 1) % 9 != 0 && gameBoard[startIndex+1] == nil && !pathArray.contains(startIndex+1))
                {
                    let recurs = findWordPath(startIndex: startIndex + 1, count: count + 1, pathArray: newPathArray)
                    if(recurs.0)
                    {
                        return (true, recurs.1)
                    }
                    break
                }
            case 3:
                if(startIndex % 9 != 0 && gameBoard[startIndex-1] == nil && !pathArray.contains(startIndex-1))
                {
                    let recurs = findWordPath(startIndex: startIndex - 1, count: count + 1, pathArray: newPathArray)
                    if(recurs.0)
                    {
                        return (true, recurs.1)
                    }
                    break
                }
            case 4:
                if((startIndex + 1) % 9 != 0 && startIndex + 10 < 108 && gameBoard[startIndex+10] == nil && !pathArray.contains(startIndex+10))
                {
                    let recurs = findWordPath(startIndex: startIndex + 10, count: count + 1, pathArray: newPathArray)
                    if(recurs.0)
                    {
                        return (true, recurs.1)
                    }
                    break
                }
            case 5:
                if(startIndex % 9 != 0 && startIndex + 8 < 108 && gameBoard[startIndex+8] == nil && !pathArray.contains(startIndex+8))
                {
                    let recurs = findWordPath(startIndex: startIndex + 8, count: count + 1, pathArray: newPathArray)
                    if(recurs.0)
                    {
                        return (true, recurs.1)
                    }
                    break
                }
            case 6:
                if(startIndex % 9 != 0 && startIndex - 10 >= 0 && gameBoard[startIndex-10] == nil && !pathArray.contains(startIndex-10))
                {
                    let recurs = findWordPath(startIndex: startIndex - 10, count: count + 1, pathArray: newPathArray)
                    if(recurs.0)
                    {
                        return (true, recurs.1)
                    }
                    break
                }
            case 7:
                if((startIndex + 1) % 9 != 0 && startIndex - 8 >= 0 && gameBoard[startIndex-8] == nil && !pathArray.contains(startIndex-8))
                {
                    let recurs = findWordPath(startIndex: startIndex - 8, count: count + 1, pathArray: newPathArray)
                    if(recurs.0)
                    {
                        return (true, recurs.1)
                    }
                    break
                }
            default:
                break
            }
            direction += 1
            if(direction == firstPicked){
                return (false, newPathArray)
            }
        }      
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
