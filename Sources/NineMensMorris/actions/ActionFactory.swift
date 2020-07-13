class ActionFactory {
  private static var actionFactory = ActionFactory()

  class func getActionFactory() -> ActionFactory {
    return self.actionFactory
  }

  func getAction(board: Board, move: String, player: Player) -> Action? {
    if move.count == 2 {
      return PlaceAction(board: board, move: move, player: player)
    }
    return nil
  }
}