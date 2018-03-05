
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
        // Populate the game board with blank squares placed randomly
        while(i < 10)
        {
            let pickSpot = Int(arc4random_uniform(UInt32(108)))
            if(gameBoard[pickSpot] != nil)
            {
                continue
            }
            gameBoard[pickSpot] = CellBlock(letter: "", type: "empty")
            i+=1
        }
        
        // Populate the board with the scrambled words found in fillWords()
        for word in words
        {
            placeWordOnBoard(word: word)
        }
        
        // Fill the remaining spots on the board with highlighted cells of a random character
        let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        for i in 0..<108
        {
            if(gameBoard[i] == nil)
            {
                let letter = letters[Int(arc4random_uniform(UInt32(letters.count)))]
                gameBoard[i] = CellBlock(letter: String(letter), type: "highlighted")
            }
        }
        
    }
    
    /*
     Places a word on the game board
    */
    func placeWordOnBoard(word: String)
    {
        // Convert word to character array. Needed for randomly placing characters if needed
        let charArray = Array(word)
        
        // Boolean used to determine if a start index was found for placing the word
        var startFound = false
        
        // Counter used to determine if there is ANY place a word can be placed on the board. If not, then we randomly place the words characers
        // on the board.
        var tryCount = 0
        
        // While a word hasn't been placed....
        while(!startFound)
        {
            // If we have tried 10 times to place a word, and no spot could be found, randomly place the characters on the board.
            if(tryCount == 10){
                placeRandomly(wordToPlace: charArray)
                startFound = true
                continue
            }
            
            // Pick a random spot on the board to start the word, if it is occupied already, continue the loop.
            let pickStart = Int(arc4random_uniform(108))
            if(gameBoard[pickStart] != nil)
            {
                continue
            }
            
            // Initial path for placing the characters of the string.
            let path : [Int?] = Array(repeatElement(-1, count: word.count))
            
            // Call findWordPath to see if there is a valid path, from the start index, for the word to fit. If not, try again until we have tried
            // 10 times.
            let newPath = findWordPath(startIndex: pickStart, count: 0, pathArray: path as! [Int])
            if(!newPath.0){
                tryCount += 1
                continue
            }
            
            // Once a path has been found, place the characters of the string into the game board based on the path found.
            for i in 0..<charArray.count
            {
                gameBoard[newPath.1[i]] = CellBlock(letter: String(charArray[i]), type: "active")
            }
            // Confirm that the word was placed, and end the loop.
            startFound = true
        }
    }
    
    /*
     Randomly place the characters of a word into the board. Only called when there is no room left on the board to fit the word.
     */
    func placeRandomly(wordToPlace: [Character])
    {
        var index = 0
        while(index < wordToPlace.count)
        {
            let pickStart = Int(arc4random_uniform(108))
            if(gameBoard[pickStart] != nil)
            {
                continue
            }
            gameBoard[pickStart] = CellBlock(letter: String(wordToPlace[index]), type: "active")
            index += 1
        }
    }
    
    /*
     Recursively looks for a path to place a word on the game board. If a path is found that the word can be placed in, returns the path, and true.
     INPUT:
        startIndex: The inital index of the word
        count: The length of the word being placed
        pathArray: The path that has been found so far
     RETURNS:
        true and the path found
        false and the start index if no path can be found
     */
    func findWordPath(startIndex: Int, count: Int, pathArray: [Int]) -> (Bool, [Int])
    {
        var newPathArray = pathArray
        // Base case, if we are on the last character of the string.
        if(count == pathArray.count - 1)
        {
            // If the index is empty and we haven't used the index so far in the path, add the index to the path
            if(gameBoard[startIndex] == nil && !newPathArray.contains(startIndex)){
                newPathArray[count] = startIndex
                return (true, newPathArray)
            }
            return (false, newPathArray)
        }
        
        // Look for an index to place the next character.
        newPathArray[count] = startIndex
        
        // Chooses a random direction.
        // 0 - the cell above
        // 1 - the cell below
        // 2 - the cell to the left
        // 3 - the cell to the right
        // 4 - the cell up and to the right
        // 5 - the cell up and to the left
        // 6 - the cell down and to the left
        // 7 - the cell down and to the right
        // Each case checks to see the the index on the game board has already been used, corner cases (if any), and if the index is in bounds of the board.
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
            // If the direction chosen does not work, try the next direction until we have gotten back to the original direction chosen and return false.
            direction += 1
            if(direction > 7){
                direction = 0
            }
            
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
        //let numWords = self.dictionary.count
        //print("num words: \(numWords)") // DELETE THIS ON FINAL
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
            if(wordLengthTotal + nextWord.count > 94 || wordLengthTotal + nextWord.count == 93){
                continue
            }
            words.append(scramble(word: nextWord).uppercased())
            wordLengthTotal += nextWord.count
        }
        //print("total length of words: \(wordLengthTotal)") // DELETE THIS ON FINAL
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
