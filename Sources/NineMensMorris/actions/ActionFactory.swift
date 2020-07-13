class ActionFactory {
  private static var actionFactory = ActionFactory()

  class func getActionFactory() -> ActionFactory {
    return self.actionFactory
  }

  func getAction(board: Board, move: String, player: Player) -> Action? {
    if move.count == 2 {
      return PlaceAction(board: board, move: move, player: player)
    } else if move.count == 4 && player.totalPieceCount() > 3 {
      return MoveAction(board: board, move: move, player: player)
    } else if move.count == 4 && player.totalPieceCount() <= 3 {
      return FlyAction(board: board, move: move, player: player)
    }
    return nil
  }
}