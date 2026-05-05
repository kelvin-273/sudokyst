#import "../src/lib.typ": sudoku, available-values, propagate-step

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

#let result = propagate-step(board)
#let expected-board = (
  (1, 2, 3, 4, 5, 6, 7, 8, 9),
  (4, 5, 6, 7, 8, 9, 1, 2, 0),
  (7, 8, 9, 1, 2, 3, 4, 5, 0),
  (2, 3, 4, 5, 6, 7, 8, 9, 0),
  (5, 6, 7, 8, 9, 1, 2, 3, 0),
  (8, 9, 1, 2, 3, 4, 5, 6, 0),
  (3, 4, 5, 6, 7, 8, 9, 1, 0),
  (6, 7, 8, 9, 1, 2, 3, 4, 0),
  (9, 1, 2, 3, 4, 5, 6, 7, 0),
)

#assert(result.move == ((1, 9), 9), message: "expected the first propagate step to be ((1, 9), 9)")
#assert(result.position == (1, 9), message: "expected the returned position to be (1, 9)")
#assert(result.value == 9, message: "expected the returned value to be 9")
#assert(result.board == expected-board, message: "expected the one-step propagated board")

#set page(width: auto, height: auto, margin: 18pt)

= Propagate step demo

Applied move: #result.move

Candidates at that cell before applying: #available-values(board, result.position.at(0), result.position.at(1))

#grid(
  columns: (auto, auto),
  gutter: 1.5em,
  [
    *Before*
    #sudoku(
      board: board,
      hints: (
        ((), (), (), (), (), (), (), (), (9,)),
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
      highlighted-cells: (result.position,),
    )
  ],
  [
    *After*
    #sudoku(
      board: result.board,
      highlighted-cells: (result.position,),
    )
  ],
)
