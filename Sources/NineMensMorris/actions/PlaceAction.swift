class PlaceAction: Action {
  override init(board: Board, move: String, player: Player) {
    super.init(board: board, move: move, player: player)
  }

  override func valid() -> Bool {
    let coords = Board.parseCoordinates(self.move)
    if self.board.boardMatrix[coords.row][coords.col] == "." {
      return true
    }
    return false
  }

  override func play() -> Bool {
    if !self.valid() {
      return false
    }

    if self.player.pieceCountInHand < 1 || self.player.pieceCountOnBoard > 9 {
      return false
    }
    self.player.pieceCountInHand -= 1
    self.player.pieceCountOnBoard += 1
    if player.color == "white" {
      self.board.setPiece(self.move, "○")
    } else {
      self.board.setPiece(self.move, "●")
    }
    self.player.piecesOnBoard.append(self.move)
    return true
  }
}