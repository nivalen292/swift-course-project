class Game {
  var board: Board
  var player1: Player
  var player2: Player

  init() {
    self.board = Board()
    self.player1 = Player(color: "white", board: board)
    self.player2 = Player(color: "black", board: board)
  }

  func playTurn() {
    board.printBoard()
    player1.playTurn(action: "place")
    board.printBoard()
    player2.playTurn(action: "place")
    board.printBoard()
  }

  func run() {
    self.playTurn()
  }
}