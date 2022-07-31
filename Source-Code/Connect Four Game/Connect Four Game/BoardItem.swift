//
//  BoardItem.swift
//  Connect Four Game
//
//  Created by Moeez Khan on 7/19/22.
//

import Foundation
import UIKit

enum Tile{
    case Red
    case Yellow
    case Empty
}

struct BoardItem
{
    var indexPath: IndexPath!
    var tile: Tile!
    
    //These functions set the color of the files programmaticaly
    func yellowTile() -> Bool
    {
        return tile == Tile.Yellow
    }
    
    func redTile() -> Bool
    {
        return tile == Tile.Red
    }
    
    func emptyTile() -> Bool
    {
        return tile == Tile.Empty
    }
    
    //Detects the color of the tile
    //Returns the appropriate color accordingly
    func tileColor() -> UIColor
    {
        if redTile()
        {
            return .red
        }
        if yellowTile()
        {
            return .systemYellow
        }
        
        return .white
    }
}
