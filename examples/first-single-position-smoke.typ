#import "../src/lib.typ": sudoku, available-values, first-single-position

#let board = (
  (1, 2, 3, 4, 5, 6, 7, 8, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
)

#let single = first-single-position(board)

#assert(single == (1, 9), message: "expected the first single to be at (1, 9)")

#set page(width: auto, height: auto, margin: 18pt)

= First single demo

First single position: #single

Candidates there: #available-values(board, single.at(0), single.at(1))

#sudoku(
  board: board,
  hints: (
    ((), (), (), (), (), (), (), (), available-values(board, 1, 9)),
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
  highlighted-cells: (single,),
)
