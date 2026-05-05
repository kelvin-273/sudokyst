#import "../src/lib.typ": sudoku, generate-hints-all

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

#let positions = {
  range(1, 10).fold((), (positions, i) => {
    positions + range(1, 10)
      .filter(j => board.at(i - 1).at(j - 1) == 0)
      .map(j => (i, j))
  })
}

#let hints = generate-hints-all(board)

#set page(width: auto, height: auto, margin: 18pt)

= Generated hints demo

All empty cells are populated with hints.

#sudoku(
  board: board,
  hints: hints,
  show-hints: true,
  highlighted-cells: positions,
)
