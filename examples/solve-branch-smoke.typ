#import "../src/lib.typ": sudoku, solve

#let board = (
  (4, 8, 3, 9, 2, 1, 6, 5, 7),
  (9, 0, 7, 3, 4, 0, 8, 2, 1),
  (2, 0, 1, 8, 7, 0, 4, 9, 3),
  (5, 4, 8, 1, 3, 2, 9, 7, 6),
  (7, 2, 9, 5, 6, 4, 1, 3, 8),
  (1, 3, 6, 7, 9, 8, 2, 4, 5),
  (3, 7, 2, 6, 8, 9, 5, 1, 4),
  (8, 1, 4, 2, 5, 3, 7, 6, 9),
  (6, 9, 5, 4, 1, 7, 3, 8, 2),
)

#let result = solve(board)

#assert(result.solved, message: "expected the solver to find a valid completion")
#assert(result.boards.len() == result.move_groups.len(), message: "expected aligned trace arrays")
#assert(result.move_groups.any(group => group.len() == 1), message: "expected the solver to take at least one guessed branch")
#assert(result.board.all(row => row.all(value => value != 0)), message: "expected the final board to be complete")

#set page(width: auto, height: auto, margin: 18pt)

= Solve branch demo

Solved: #result.solved

Trace length: #result.boards.len()

#grid(
  columns: (auto, auto),
  gutter: 1.5em,
  [
    *Initial*
    #sudoku(board: board)
  ],
  [
    *Solved*
    #sudoku(board: result.board)
  ],
)
