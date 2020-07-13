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

  func playTurn() {
    var position: String
    repeat {
      print("Enter a position to place a piece:")
      position = readLine()!
    } while !Board.validMove(position)
    
    if let action = ActionFactory.getActionFactory().getAction(board: self.board, move: position, player: self) {
      action.play()
    }
  }
}