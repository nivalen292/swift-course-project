class Action {
  var board: Board
  var move: String
  var player: Player

  init(board: Board, move: String, player: Player) {
    self.board = board
    self.move = move
    self.player = player
  }

  func play() -> Bool { return true }
  func valid() -> Bool { return true }
}