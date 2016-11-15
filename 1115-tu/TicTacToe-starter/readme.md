# Tic Tac Toe

In this project, we want to explore the MVC architecture and understand what it means to _separate concerns_ between the `Model`, `View` and `Controller` inside an application.

Our goal is to write a simple Tic Tac Toe game with a dedicated **view** component (`BoardView`) that represents the state of the board. The `BoardView` is implemented as a 3x3 grid according to the rules of Tic Tac Toe. Each cell in the grid is represented by a different view class called `FieldView`.

At the same time, we have a **model** object to represent the _state_ of our game. It is implemented as a `struct` called `Board`. It keeps track of the current game state by managing a 3x3 matrix of fields. A `Field` is implemented as an `enum` that has two cases:

1. `.free`: this means the `Field` is available for a user to make a move
2. `.hasPlayer(player)`: this case uses an [associated value](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID148) to indicate which player has made a move on this field (note that `Player` is also implemented as an `enum` with two cases: `.circle` and `.cross`)

Whenever the board receives a touch event from a user, it needs to propagate the info about the event (i.e. the coordinates of the `FieldView` that has been tapped) to the **controller** , so that it can advance the game state (i.e. update the _model_).