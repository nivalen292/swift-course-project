class MoveAction: Action {
  var fromCoordsString: String = ""
  var toCoordsString: String = ""
  var fromCoords: (row: Int, col: Int) = (row: 0, col: 0)
  var toCoords: (row: Int, col: Int) = (row: 0, col: 0)
  
  override init(board: Board, move: String, player: Player) {
    super.init(board: board, move: move, player: player)

    self.fromCoordsString = String(self.move.prefix(2))
    self.toCoordsString = String(self.move.suffix(2))
    self.fromCoords = Board.parseCoordinates(self.fromCoordsString)
    self.toCoords = Board.parseCoordinates(self.toCoordsString)
  }

  override func valid() -> Bool {
    if (self.fromCoords.row != self.toCoords.row && self.fromCoords.col != self.toCoords.col) ||
       (!Validator.inBounds(self.fromCoords.row) || !Validator.inBounds(self.fromCoords.col)) ||
       (!Validator.inBounds(self.toCoords.row) || !Validator.inBounds(self.toCoords.col)) {
        print("Outside of board or not on same row or column")
        return false
    }

    if self.board.boardMatrix[self.fromCoords.row][self.fromCoords.col] != self.playerPiece {
      print("Starting piece is not own by the player or there is no piece there")
      return false
    }

    if self.fromCoords.row == self.toCoords.row {
      let dy = self.fromCoords.col - self.toCoords.col > 0 ? -1 : 1
      var start = self.fromCoords.col + dy
      while dy == 1 ? start <= self.toCoords.col : start >= self.toCoords.col {
        if self.board.boardMatrix[self.fromCoords.row][start] == Constants.ColorConstants.blackColorPiece ||
           self.board.boardMatrix[self.fromCoords.row][start] == Constants.ColorConstants.whiteColorPiece {
            print("There is a piece in between")
            return false
          }
        start += dy
      }
    }

    if self.fromCoords.col == self.toCoords.col {
      let dx = self.fromCoords.row - self.toCoords.row > 0 ? -1 : 1
      var start = self.fromCoords.row + dx
      while dx == 1 ? start <= self.toCoords.row : start >= self.toCoords.row {
        if self.board.boardMatrix[start][self.fromCoords.col] == Constants.ColorConstants.blackColorPiece ||
           self.board.boardMatrix[start][self.fromCoords.col] == Constants.ColorConstants.whiteColorPiece {
            print("There is a piece in between")
            return false
          }
        start += dx
      }
    }

    return true
  }

  override func play() -> Bool {
    if !self.valid() {
      return false
    }

    if let index = self.player.piecesOnBoard.firstIndex(of: self.fromCoordsString) {
      self.board.removePiece(self.fromCoordsString)
      self.board.setPiece(self.toCoordsString, playerPiece)

      self.player.piecesOnBoard.remove(at: index)
      self.player.piecesOnBoard.append(self.toCoordsString)
    } else {
      return false
    }

    return true
  }
}