class Player {
  let color: String
  var pieceCountInHand: Int
  var pieceCountOnBoard: Int
  var board: Board
  var piecesOnBoard: [String]

  init(color: String, board: Board) {
    self.color = color
    self.board = board
    self.pieceCountInHand = 9
    self.pieceCountOnBoard = 0
    self.piecesOnBoard = []
  }

  func setPiece(_ position: String) -> Bool {
    if self.pieceCountInHand < 1 || self.pieceCountOnBoard > 9 {
      return false
    }
    self.pieceCountInHand -= 1
    self.pieceCountOnBoard += 1
    if color == "white" {
      board.setPiece(position, "○")
    } else {
      board.setPiece(position, "●")
    }
    self.piecesOnBoard.append(position)
    return true
  }

  func playTurn(action: String) {
    var position: String
    if action == "place" {
      repeat {
        print("Enter a position to place a piece:")
        position = readLine()!
      } while !board.validPosition(position, action)
      self.setPiece(position)
    }
  }
}