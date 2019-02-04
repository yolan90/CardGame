//
//  ViewController.swift
//  CardGame
//
//  Created by Yolanda Halim on 01/02/19.
//  Copyright © 2019 Yolanda Halim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
  
    @IBOutlet weak var firstPlayerCardLabel1: UILabel!
    @IBOutlet weak var firstPlayerCardLabel2: UILabel!
    @IBOutlet weak var secondPlayerCardLabel1: UILabel!
    @IBOutlet weak var secondPlayerCardLabel2: UILabel!
    
    enum CardNumber : Int, CaseIterable {
        case ace = 1, two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7, eight = 8, nine = 9, ten = 10, jack = 11, queen = 12, king = 13
    }
    enum CardSuit : String, CaseIterable {
        case spade = "♠️", heart = "♥️", club = "♣️", diamond = "♦️"
    }
    
    @IBAction func playGame(_ sender: Any) {
        var cardSuitArr : [String] = []
        for item in CardSuit.allCases {
            cardSuitArr.append(item.rawValue)
        }
        
        cardSuitArr.shuffle()
        let player1Card : Card = Card(cardNum: CardNumber(rawValue: Int.random(in: 1...13))!, cardSuit: cardSuitArr.shuffled()[0])
        var player2Card : Card? = Card(cardNum: CardNumber(rawValue: Int.random(in: 1...13))!, cardSuit: cardSuitArr.shuffled()[0])
        repeat {
            player2Card = Card(cardNum: CardNumber(rawValue: Int.random(in: 1...13))!, cardSuit: cardSuitArr.shuffled()[0])
        } while (player2Card?.cardNum == player1Card.cardNum && player2Card?.cardSuit == player1Card.cardSuit)
        
        print("\(player1Card.cardNum.rawValue) \(player1Card.cardSuit)")
        print("\(player2Card!.cardNum.rawValue) \(player2Card!.cardSuit)")
        
        firstPlayerCardLabel1.text = "\(translateCardSymbol(card: player1Card)) \(player1Card.cardSuit)"
        firstPlayerCardLabel2.text = "\(translateCardSymbol(card: player1Card)) \(player1Card.cardSuit)"
        secondPlayerCardLabel1.text = "\(translateCardSymbol(card: player2Card!)) \(player2Card!.cardSuit)"
        secondPlayerCardLabel2.text = "\(translateCardSymbol(card: player2Card!)) \(player2Card!.cardSuit)"
        
        compare(card1: player1Card, card2: player2Card!)
        winnerLabel.isHidden = false
    }
    
    func compare(card1: Card, card2: Card) {
        if card1.cardNum.rawValue > card2.cardNum.rawValue {
            winnerLabel.text = "player 1 wins!"
        } else if card1.cardNum.rawValue < card2.cardNum.rawValue {
            winnerLabel.text = "player 2 wins!"
        } else {
            winnerLabel.text = "Draw"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerLabel.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    struct Card {
        var cardNum : CardNumber
        var cardSuit : String
    }
    
    func translateCardSymbol(card: Card) -> String {
        var cardNum = ""
        switch(card.cardNum) {
            case CardNumber.jack : cardNum = "J"
            case CardNumber.queen : cardNum = "Q"
            case CardNumber.king : cardNum = "K"
            case CardNumber.ace: cardNum = "A"
        default : cardNum = String(card.cardNum.rawValue)
        }
        return cardNum
    }

}

