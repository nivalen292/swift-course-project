# NineMensMorris

Implementing part 1 + part 2.

## Starting the project
```
swift build && swift run
```
## Design

The implementation of the game revolves around a couple of objects:
- Game - core object and where all resources are held.
- Actions - these can vary and are everything a player can do with their pieces on the board. For example, when the `MoveAction` is fired against the board, a piece will be moved, etc. These are also distributed to players via the `ActionFactory`.
- Players - allocated when the game begins.
