#import "../src/lib.typ": sudoku, available-values

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

#let candidates = available-values(board, 1, 3)

#set page(width: auto, height: auto, margin: 18pt)

= Candidate demo

Candidates for row 1, column 3: #candidates

#sudoku(
  board: board,
  highlighted-cells: ((1, 3),),
  hints: (
    ((), (), candidates, (), (), (), (), (), ()),
    ((), (), (), (), (), (), (), (), ()),
    ((), (), (), (), (), (), (), (), ()),
    ((), (), (), (), (), (), (), (), ()),
    ((), (), (), (), (), (), (), (), ()),
    ((), (), (), (), (), (), (), (), ()),
    ((), (), (), (), (), (), (), (), ()),
    ((), (), (), (), (), (), (), (), ()),
    ((), (), (), (), (), (), (), (), ()),
  ),
  show-hints: true,
)
