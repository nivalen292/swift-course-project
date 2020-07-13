import Foundation

class Board {
  var boardMatrix: [[String]]

  init() {
    self.boardMatrix = Array(repeating: Array(repeating: " ", count: 7), count: 7)
    let emptyPositions = ["A1", "A4", "A7", "D1", "D2", "D3", "D5", "D6", "D7", "G1", "G4", "G7", "B2", "B4", "B6",
                          "F2", "F4", "F6", "C3", "C4", "C5", "E3", "E4", "E5"]
    let horizontalPositions = ["B1", "C1", "E1", "F1", "C2", "E2", "C6", "E6", "B7", "C7", "E7", "F7"]
    let verticalPositions = ["A2", "A3", "A6", "A7", "G2", "G3", "G6", "G7", "B3", "B5", "F3", "F5"]

    for openPosition in horizontalPositions {
      let position = Board.parseCoordinates(openPosition)
      self.boardMatrix[position.row][position.col] = "-"
    }
    for openPosition in verticalPositions {
      let position = Board.parseCoordinates(openPosition)
      self.boardMatrix[position.row][position.col] = "|"
    }
    for openPosition in emptyPositions {
      let position = Board.parseCoordinates(openPosition)
      self.boardMatrix[position.row][position.col] = "."
    }
  }

  func setPiece(_ coordinateString: String, _ piece: String) {
    let coords = Board.parseCoordinates(coordinateString)
    self.boardMatrix[coords.row][coords.col] = piece
  }

  func removePiece(_ coordinateString: String) {
    let coords = Board.parseCoordinates(coordinateString)
    self.boardMatrix[coords.row][coords.col] = "."
  }

  func printBoard() {
    for row in boardMatrix {
      for col in row {
        print(col, terminator: " ")
      }
      print("")
    }
  }

  func isPartOfMill(_ position: String) -> Bool {
    if !Board.validMove(position) {
      return false
    }

    let coords = Board.parseCoordinates(position)
    let piece = self.boardMatrix[coords.row][coords.col]

    if piece != Constants.ColorConstants.whiteColorPiece || piece != Constants.ColorConstants.blackColorPiece {
      return false
    }

    var formsMillUp = true
    var formsMillDown = true
    var formsMillLeft = true
    var formsMillRight = true

    // check up
    var start = coords.row
    while start > coords.row - 2 {
      if !Validator.inBounds(start) {
        formsMillUp = false
        break
      }
      if self.boardMatrix[start][coords.col] != piece {
        formsMillUp = false
        break
      }
      start -= 1
    }

    // check down
    start = coords.row
    while start < coords.row + 2 {
      if !Validator.inBounds(start) {
        formsMillDown = false
        break
      }
      if self.boardMatrix[start][coords.col] != piece {
        formsMillDown = false
        break
      }
      start += 1
    }

    // check left
    start = coords.col
    while start > coords.col - 2 {
      if !Validator.inBounds(start) {
        formsMillLeft = false
        break
      }
      if self.boardMatrix[coords.row][start] != piece {
        formsMillLeft = false
        break
      }
      start -= 1
    }

    // check right
    start = coords.col
    while start < coords.col + 2 {
      if !Validator.inBounds(start) {
        formsMillRight = false
        break
      }
      if self.boardMatrix[coords.row][start] != piece {
        formsMillRight = false
        break
      }
      start += 1
    }

    return formsMillUp || formsMillDown || formsMillLeft || formsMillRight
  }

  static func validMove(_ move: String) -> Bool {
    let regex = "^([A-G][1-7]|[A-G][1-7][A-G][1-7])$"
    if (move.range(of:regex, options:.regularExpression) != nil) {
      return true
    } else {
      print("Wrong notation.")
      return false
    }
  }

  static func parseCoordinates(_ coordinateString: String) -> (row: Int, col: Int) {
    let row = Int(coordinateString.suffix(1))! - 1
    let col = Int(UnicodeScalar(String(coordinateString.prefix(1)))!.value - 65)
    
    return (row: row, col: col)
  }
}