class Board {
  var boardMatrix: [[String]]

  init() {
    self.boardMatrix = Array(repeating: Array(repeating: " ", count: 7), count: 7)
    let emptyPositions = ["A1", "A4", "A7", "D1", "D2", "D3", "D5", "D6", "D7", "G1", "G4", "G7", "B2", "B4", "B6",
                          "F2", "F4", "F6", "C3", "C4", "C5", "E3", "E4", "E5"]
    let horizontalPositions = ["B1", "C1", "E1", "F1", "C2", "E2", "C6", "E6", "B7", "C7", "E7", "F7"]
    let verticalPositions = ["A2", "A3", "A6", "A7", "G2", "G3", "G6", "G7", "B3", "B5", "F3", "F5"]

    for openPosition in horizontalPositions {
      let position = parseCoordinates(openPosition)
      self.boardMatrix[position.row][position.col] = "-"
    }
    for openPosition in verticalPositions {
      let position = parseCoordinates(openPosition)
      self.boardMatrix[position.row][position.col] = "|"
    }
    for openPosition in emptyPositions {
      let position = parseCoordinates(openPosition)
      self.boardMatrix[position.row][position.col] = "."
    }
  }

  func setPiece(_ coordinateString: String, _ piece: String) {
    var coords = parseCoordinates(coordinateString)
    self.boardMatrix[coords.row][coords.col] = piece
  }

  func printBoard() {
    for row in boardMatrix {
      for col in row {
        print(col, terminator: " ")
      }
      print("")
    }
  }

  func validPosition(_ position: String, _ action: String) -> Bool {
    let coords = parseCoordinates(position)
    if (action == "place" && self.boardMatrix[coords.row][coords.col] == ".") {
      return true
    }
    return false
  }

  private func parseCoordinates(_ coordinateString: String) -> (row: Int, col: Int) {
    let row = Int(coordinateString.suffix(1))! - 1
    let col = Int(UnicodeScalar(String(coordinateString.prefix(1)))!.value - 65)
    
    return (row: row, col: col)
  }
}