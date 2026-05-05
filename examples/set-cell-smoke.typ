#import "../src/lib.typ": sudoku, generate-hints, set-cell

#let board = (
  (5, 3, 0, 0, 7, 0, 0, 0, 0),
  (6, 0, 0, 1, 9, 5, 0, 0, 0),
  (0, 9, 8, 0, 0, 0, 0, 6, 0),
  (8, 0, 0, 0, 6, 0, 0, 0, 3),
  (4, 0, 0, 8, 0, 3, 0, 0, 1),
  (7, 0, 0, 0, 2, 0, 0, 0, 6),
  (0, 6, 0, 0, 0, 0, 2, 8, 0),
  (0, 0, 0, 4, 1, 9, 0, 0, 5),
  (0, 0, 0, 0, 8, 0, 0, 7, 9),
)

#let move = (1, 3)
#let value = 4
#let updated-board = set-cell(board, move.at(0), move.at(1), value)
#let focus-cells = (
  move,
  (1, 4),
  (2, 2),
)
#let updated-hints = generate-hints(updated-board, focus-cells)

#set page(width: auto, height: auto, margin: 18pt)

= Set cell demo

Applied value #value at position #move.

#grid(
  columns: (auto, auto),
  gutter: 1.5em,
  [
    *Before*
    #sudoku(
      board: board,
      hints: generate-hints(board, focus-cells),
      show-hints: true,
      highlighted-cells: focus-cells,
    )
  ],
  [
    *After*
    #sudoku(
      board: updated-board,
      hints: updated-hints,
      show-hints: true,
      highlighted-cells: focus-cells,
    )
  ],
)
