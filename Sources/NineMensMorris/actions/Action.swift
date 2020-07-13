class Action {
  var board: Board
  var move: String
  var player: Player
  var playerPiece: String

  init(board: Board, move: String, player: Player) {
    self.board = board
    self.move = move
    self.player = player
    self.playerPiece = player.color == "white" ? Constants.ColorConstants.whiteColorPiece : Constants.ColorConstants.blackColorPiece
  }

  func play() -> Bool { return true }
  func valid() -> Bool { return true }
}