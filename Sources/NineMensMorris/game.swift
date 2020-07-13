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
    var validMove: Bool
    board.printBoard()

    validMove = player1.playTurn()
    while !validMove {
      validMove = player1.playTurn()
    }
    board.printBoard()

    validMove = player2.playTurn()
    while !validMove {
      validMove = player2.playTurn()
    }
  }

  func run() {
    repeat {
      self.playTurn()
    } while !self.player1.hasLost() && !self.player2.hasLost()
  }
}