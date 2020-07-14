class Player {
  let color: String
  var pieceCountInHand: Int
  var pieceCountOnBoard: Int
  var board: Board
  var piecesOnBoard: [String]
  var oponent: Player? = nil

  init(color: String, board: Board) {
    self.color = color
    self.board = board
    self.pieceCountInHand = 9
    self.pieceCountOnBoard = 0
    self.piecesOnBoard = []
  }

  func totalPieceCount() -> Int {
    return self.pieceCountInHand + self.pieceCountOnBoard
  }

  func hasLost() -> Bool {
    return self.totalPieceCount() <= 2 || self.allPiecesTrapped()
  }

  func piece() -> String {
    return self.color == "white" ? Constants.ColorConstants.whiteColorPiece : Constants.ColorConstants.blackColorPiece
  }

  func allPiecesTrapped() -> Bool {
    if self.pieceCountInHand == 0 {
      for pieceCoords in self.piecesOnBoard {
        if self.board.isMovablePiece(pieceCoords) {
          return false
        }
      }
      return true
    }
    return false
  }

  func forfeitPiece(_ coordinateString: String) -> Bool {
    if self.pieceCountOnBoard == 0 {
      return true
    }
    if !self.piecesOnBoard.contains(coordinateString) {
      return false
    }
    if self.pieceCountOnBoard > 3 && self.board.isPartOfMill(coordinateString) {
      return false
    }

    self.board.removePiece(coordinateString)
    self.piecesOnBoard.remove(at: self.piecesOnBoard.firstIndex(of: coordinateString)!)
    self.pieceCountOnBoard -= 1
    return true
  }

  func playTurn() -> Bool {
    print("\(color) player's turn:")
    var position: String
    repeat {
      print("Enter a position to place a piece:")
      position = readLine()!
    } while !Board.validMove(position)
    
    if let action = ActionFactory.getActionFactory().getAction(board: self.board, move: position, player: self) {
      if !action.play() {
        return false
      }
      // action was successful
      if self.board.isPartOfMill(position) {
        self.board.printBoard()
        // can remove an oponent piece
        var removePiecePosition: String
        repeat {
          print("You formed a mill. Enter the coordinates of an oponent piece to remove: ")
          removePiecePosition = readLine()!
        } while !Board.validMove(removePiecePosition) //self.board.getPieceAt(removePiecePosition) != self.oponent!.piece()
        self.oponent!.forfeitPiece(removePiecePosition)
      }
      return true
    }

    return false
  }
}