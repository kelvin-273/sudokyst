#import "../src/lib.typ": sudoku, available-values, first-single-move

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

#let single-move = first-single-move(board)
#let single-position = single-move.at(0)
#let single-value = single-move.at(1)

#assert(
  single-move == ((1, 9), 9),
  message: "expected the first single move to be ((1, 9), 9)",
)

#set page(width: auto, height: auto, margin: 18pt)

= First single move demo

First single move: #single-move

Candidates there: #available-values(board, single-position.at(0), single-position.at(1))

#sudoku(
  board: board,
  hints: (
    ((), (), (), (), (), (), (), (), (single-value,)),
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
  highlighted-cells: (single-position,),
)
