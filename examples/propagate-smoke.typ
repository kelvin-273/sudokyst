#import "../src/lib.typ": sudoku, generate-hints-all, propagate

#let board = (
  (1, 2, 3, 4, 5, 6, 7, 8, 0),
  (4, 5, 6, 7, 8, 9, 1, 2, 0),
  (7, 8, 9, 1, 2, 3, 4, 5, 0),
  (2, 3, 4, 5, 6, 7, 8, 9, 0),
  (5, 6, 7, 8, 9, 1, 2, 3, 0),
  (8, 9, 1, 2, 3, 4, 5, 6, 0),
  (3, 4, 5, 6, 7, 8, 9, 1, 0),
  (6, 7, 8, 9, 1, 2, 3, 4, 0),
  (9, 1, 2, 3, 4, 5, 6, 7, 0),
)

#let expected-board = (
  (1, 2, 3, 4, 5, 6, 7, 8, 9),
  (4, 5, 6, 7, 8, 9, 1, 2, 3),
  (7, 8, 9, 1, 2, 3, 4, 5, 6),
  (2, 3, 4, 5, 6, 7, 8, 9, 1),
  (5, 6, 7, 8, 9, 1, 2, 3, 4),
  (8, 9, 1, 2, 3, 4, 5, 6, 7),
  (3, 4, 5, 6, 7, 8, 9, 1, 2),
  (6, 7, 8, 9, 1, 2, 3, 4, 5),
  (9, 1, 2, 3, 4, 5, 6, 7, 8),
)

#let result = propagate(board)
#let expected-positions = (
  (1, 9),
  (2, 9),
  (3, 9),
  (4, 9),
  (5, 9),
  (6, 9),
  (7, 9),
  (8, 9),
  (9, 9),
)
#let expected-moves = (
  ((1, 9), 9),
  ((2, 9), 3),
  ((3, 9), 6),
  ((4, 9), 1),
  ((5, 9), 4),
  ((6, 9), 7),
  ((7, 9), 2),
  ((8, 9), 5),
  ((9, 9), 8),
)

#assert(result.board == expected-board, message: "expected propagate to fill all forced singles")
#assert(result.positions == expected-positions, message: "expected propagate positions in reading order")
#assert(result.moves == expected-moves, message: "expected propagate to record the applied moves")

#set page(width: auto, height: auto, margin: 18pt)

= Propagate demo

Applied positions: #result.positions

Applied moves: #result.moves

#grid(
  columns: (auto, auto),
  gutter: 1.5em,
  [
    *Before*
    #sudoku(
      board: board,
      hints: generate-hints-all(board),
      show-hints: true,
      highlighted-cells: result.positions,
    )
  ],
  [
    *After*
    #sudoku(
      board: result.board,
      highlighted-cells: result.positions,
    )
  ],
)
