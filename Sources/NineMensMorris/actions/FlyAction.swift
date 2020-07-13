class FlyAction: MoveAction {
  override func valid() -> Bool {
    if (!Validator.inBounds(self.fromCoords.row) || !Validator.inBounds(self.fromCoords.col)) ||
       (!Validator.inBounds(self.toCoords.row) || !Validator.inBounds(self.toCoords.col)) {
        print("Outside of board")
        return false
    }

    if self.board.boardMatrix[self.fromCoords.row][self.fromCoords.col] != self.playerPiece {
      print("Starting piece is not own by the player or there is no piece there")
      return false
    }

    if self.board.boardMatrix[self.toCoords.row][self.toCoords.col] != "." {
      print("Target location is not free")
      return false
    }

    return true
  }
}