//
//  Board.swift
//  Connect Four Game
//
//  Created by Moeez Khan on 7/19/22.
//

import Foundation
import UIKit

var board = [[BoardItem]]()

//function reserts all board items to default settings
//removing all changes that were applied by the user
func resetBoard()
{
    board.removeAll()
    
    for row in 0...5
    {
        var rowArray = [BoardItem]()
        for column in 0...6
        {
            let indexPath = IndexPath.init(item: column, section: row)
            let boardItem = BoardItem(indexPath: indexPath, tile: Tile.Empty)
            rowArray.append(boardItem)
        }
        board.append(rowArray)
    }
}

func getBoardItem(_ indexPath: IndexPath) -> BoardItem
{
    return board[indexPath.section][indexPath.item]
}

//find the lowest row that has an empty spot to insert circle
//this ensures the grid fills out evenlt in regards to the row numbers
func getLowestEmptyBoardItem(_ column: Int) -> BoardItem?
{
    for row in (0...5).reversed()
    {
        let boardItem = board[row][column]
        if boardItem.emptyTile()
        {
            return boardItem
        }
    }
    
    return nil
}

//Funciton updates the grid display according to the user's selection
//includes edge checks and updates grid accordingly
func updateBoardWithBoardItem(_ boardItem: BoardItem)
{
    if let indexPath = boardItem.indexPath
    {
        board[indexPath.section][indexPath.item] = boardItem
    }
}

//Check if the board completely fills up
//if yes, return true -- used to reset grid
func boardIsFull() -> Bool
{
    for row in board
    {
        for column in row
        {
            if column.emptyTile()
            {
                return false
            }
        }
    }
    
    return true
}

func victoryAchieved()  -> Bool
{
    return horizontalVictory() || verticalVictory() || diagonalVicotry()
}

//Since 4 diagonals exists in the grid
//this function has 4 diffrent method calls with different parameters
//to check if any sequence of 4 exists
func diagonalVicotry()  -> Bool
{
    for column in 0...board.count
    {
        if checkDiagonalColumn(column, true, true)
        {
            return true
        }
        if checkDiagonalColumn(column, true, false)
        {
            return true
        }
        if checkDiagonalColumn(column, false, true)
        {
            return true
        }
        if checkDiagonalColumn(column, false, false)
        {
            return true
        }
    }

    return false
}

//Check if there has been any detection
//of a diagonal sequence of 4
func checkDiagonalColumn(_ columnToCheck: Int,_ moveUp: Bool,_ reverseRows: Bool) -> Bool
{
    var movingColumn = columnToCheck
    var consecutive = 0
    if reverseRows
    {
        for row in board.reversed()
        {
            if movingColumn < row.count && movingColumn >= 0
            {
                if row[movingColumn].tile == currentTurnTile()
                {
                    //increment count after every insertion
                    consecutive += 1
                    
                    //connected 4!
                    if consecutive >= 4
                    {
                        return true
                    }
                }
                else
                {
                    //if sequence breaks - update count by 0
                    consecutive = 0
                }
                movingColumn = moveUp ? movingColumn + 1 : movingColumn - 1
            }
        }
    }
    else
    {
        for row in board
        {
            if movingColumn < row.count && movingColumn >= 0
            {
                if row[movingColumn].tile == currentTurnTile()
                {
                    //increment count after every insertion
                    consecutive += 1
                    
                    //connected 4!
                    if consecutive >= 4
                    {
                        return true
                    }
                }
                else
                {
                    //if sequence breaks - update count by 0
                    consecutive = 0
                }
                movingColumn = moveUp ? movingColumn + 1 : movingColumn - 1
            }
        }
    }

    return false
}

//Check if there has been any detection
//of a vertical sequence of 4
func verticalVictory() -> Bool
{
    for column in 0...board.count
    {
        if checkVerticalColumn(column)
        {
            return true
        }
    }

    return false
}

//detect if a sequence has been detected
//in the vertical direction
func checkVerticalColumn(_ columnToCheck: Int) -> Bool
{
    var consecutive = 0
    for row in board
    {
        if row[columnToCheck].tile == currentTurnTile()
        {
            //increment count after every insertion
            consecutive += 1
            
            //Connected 4!
            if consecutive >= 4
            {
                return true
            }
        }
        else
        {
            //if sequence breaks - update count by 0
            consecutive = 0
        }
    }
    return false
}

//detect if a sequence has been detected
//in the horizontal direction
func horizontalVictory()  -> Bool
{
    for row in board
    {
        var consecutive = 0
        for column in row
        {
            if column.tile == currentTurnTile()
            {
                //increment count after every insertion
                consecutive += 1
                
                //Connected 4!
                if consecutive >= 4
                {
                    return true
                }
            }
            else
            {
                //if sequence breaks - update count by 0
                consecutive = 0
            }
        }
    }

    return false
}
