//
//  Turn.swift
//  Connect Four Game
//
//  Created by Moeez Khan on 7/19/22.
//

import Foundation
import UIKit

enum Turn
{
    case Red
    case Yellow
}

//the yelloe team gets the starting turn
var currentTurn = Turn.Yellow

//after every turn of one team
//the currentTurn is toggled so the other team gets a go
//to connect 4!
//updates imageView with appropriate color
func toggleTurn(_ turnImage: UIImageView)
{
    if yellowTurn()
    {
        currentTurn = Turn.Red
        turnImage.tintColor = .red
    }
    else
    {
        currentTurn = Turn.Yellow
        turnImage.tintColor = .systemYellow
    }
}

//changing turns to yellow
func yellowTurn() -> Bool
{
    return currentTurn == Turn.Yellow
}

//changing turns to red
func redTurn() -> Bool
{
    return currentTurn == Turn.Red
}

//These funcitons logistically
//alter the state of the tiles and turns
func currentTurnTile() -> Tile
{
    return yellowTurn() ? Tile.Yellow : Tile.Red
}

func currentTurnColor() -> UIColor
{
    return yellowTurn() ? .systemYellow : .red
}

//victory message to be displayed
//once a victory is detected through functions in Board.swift
func currentTurnVictoryMessage() -> String
{
    return yellowTurn() ? "Yellow Wins!" : "Red Wins!"
}
