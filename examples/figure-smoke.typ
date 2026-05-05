#import "../src/lib.typ": sudoku

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

#figure(
  caption: [Example Sudoku board shown inside a figure.],
  supplement: [Board],
  placement: none,
  sudoku(
    board: board,
    cell-size: 1.8em,
    highlighted-rows: (1,),
    highlighted-columns: (5,),
    highlighted-cells: ((1, 5),),
  ),
)
