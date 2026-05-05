#import "../src/lib.typ": sudoku, available-values, valid-move

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
#let legal-value = 4
#let illegal-value = 5
#let candidates = available-values(board, move.at(0), move.at(1))

#set page(width: auto, height: auto, margin: 18pt)

= Valid move demo

Candidates for #move: #candidates

Is `#legal-value` valid? #valid-move(board, move.at(0), move.at(1), legal-value)

Is `#illegal-value` valid? #valid-move(board, move.at(0), move.at(1), illegal-value)

#sudoku(
  board: board,
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
  highlighted-cells: (move,),
)
