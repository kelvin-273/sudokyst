#let empty-board = (
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0, 0, 0, 0),
)

#let empty-hints = (
  ((), (), (), (), (), (), (), (), ()),
  ((), (), (), (), (), (), (), (), ()),
  ((), (), (), (), (), (), (), (), ()),
  ((), (), (), (), (), (), (), (), ()),
  ((), (), (), (), (), (), (), (), ()),
  ((), (), (), (), (), (), (), (), ()),
  ((), (), (), (), (), (), (), (), ()),
  ((), (), (), (), (), (), (), (), ()),
  ((), (), (), (), (), (), (), (), ()),
)

#let _normalize-selection(value) = if value == none { () } else { value }

#let _normalize-hint-cell(value) = if value == none { () } else { value }

#let _assert-grid-shape(name, grid) = {
  assert(
    grid.len() == 9 and grid.all(row => row.len() == 9),
    message: name + " must be a 9x9 array.",
  )
}

#let _assert-cell-position(row, column) = {
  assert(
    row >= 1 and row <= 9 and column >= 1 and column <= 9,
    message: "row and column must be between 1 and 9.",
  )
}

#let _assert-cell-value(value) = {
  assert(
    (value == none) or (type(value) == int and value >= 0 and value <= 9),
    message: "value must be an integer between 0 and 9, or none.",
  )
}

#let _has-value(value) = value != none and value != 0

#let _row-has-value(board, row, value) = board.at(row).contains(value)

#let _column-has-value(board, column, value) = {
  range(9).any(row => board.at(row).at(column) == value)
}

#let _block-has-value(board, row, column, value) = {
  let block-row-start = calc.floor(row / 3) * 3
  let block-column-start = calc.floor(column / 3) * 3

  range(block-row-start, block-row-start + 3)
    .any(block-row => range(block-column-start, block-column-start + 3)
      .any(block-column => board.at(block-row).at(block-column) == value))
}

#let available-values(board, row, column) = {
  _assert-grid-shape("board", board)
  _assert-cell-position(row, column)

  let row-index = row - 1
  let column-index = column - 1
  let current-value = board.at(row-index).at(column-index)

  if _has-value(current-value) {
    ()
  } else {
    range(1, 10).filter(value =>
      not _row-has-value(board, row-index, value)
      and not _column-has-value(board, column-index, value)
      and not _block-has-value(board, row-index, column-index, value)
    )
  }
}

#let valid-move(board, row, column, value) = {
  _assert-grid-shape("board", board)
  _assert-cell-position(row, column)
  assert(
    type(value) == int and value >= 1 and value <= 9,
    message: "value must be an integer between 1 and 9.",
  )

  let current-value = board.at(row - 1).at(column - 1)

  if _has-value(current-value) {
    false
  } else {
    available-values(board, row, column).contains(value)
  }
}

#let first-single-position(board) = {
  _assert-grid-shape("board", board)

  for row in range(1, 10) {
    for column in range(1, 10) {
      if available-values(board, row, column).len() == 1 {
        return (row, column)
      }
    }
  }

  none
}

#let first-single-move(board) = {
  _assert-grid-shape("board", board)

  for row in range(1, 10) {
    for column in range(1, 10) {
      let candidates = available-values(board, row, column)

      if candidates.len() == 1 {
        return ((row, column), candidates.at(0))
      }
    }
  }

  none
}

#let generate-hints(board, positions) = {
  _assert-grid-shape("board", board)

  for position in positions {
    assert(
      type(position) == array and position.len() == 2,
      message: "each position must be a (row, column) pair.",
    )
    _assert-cell-position(position.at(0), position.at(1))
  }

  range(9).map(row => range(9).map(col => {
    let position = (row + 1, col + 1)

    if positions.contains(position) {
      available-values(board, row + 1, col + 1)
    } else {
      ()
    }
  }))
}

#let generate-hints-all(board) = {
  _assert-grid-shape("board", board)

  range(9).map(row => range(9).map(col => {
    available-values(board, row + 1, col + 1)
  }))
}

#let set-cell(board, row, column, value) = {
  _assert-grid-shape("board", board)
  _assert-cell-position(row, column)
  _assert-cell-value(value)

  let row-index = row - 1
  let column-index = column - 1

  range(9).map(current-row => {
    if current-row == row-index {
      range(9).map(current-column => {
        if current-column == column-index {
          value
        } else {
          board.at(current-row).at(current-column)
        }
      })
    } else {
      board.at(current-row)
    }
  })
}

#let _cell-fill(
  row,
  col,
  highlighted-rows,
  highlighted-columns,
  highlighted-cells,
  row-highlight-fill,
  column-highlight-fill,
  overlap-highlight-fill,
  cell-highlight-fill,
) = {
  let row-hit = highlighted-rows.contains(row + 1)
  let column-hit = highlighted-columns.contains(col + 1)
  let cell-hit = highlighted-cells.contains((row + 1, col + 1))

  if cell-hit {
    cell-highlight-fill
  } else if row-hit and column-hit {
    overlap-highlight-fill
  } else if row-hit {
    row-highlight-fill
  } else if column-hit {
    column-highlight-fill
  } else {
    none
  }
}

#let _cell-stroke(col, row, thin-stroke, block-stroke) = (
  left: if col == 0 {
    block-stroke
  } else if calc.rem(col, 3) == 0 {
    block-stroke
  } else {
    thin-stroke
  },
  top: if row == 0 {
    block-stroke
  } else if calc.rem(row, 3) == 0 {
    block-stroke
  } else {
    thin-stroke
  },
  right: if col == 8 { block-stroke } else { 0pt },
  bottom: if row == 8 { block-stroke } else { 0pt },
)

#let _hint-grid(cell-hints, cell-size, hint-text-size, hint-color) = {
  let slot-size = cell-size / 3

  grid(
    columns: (slot-size,) * 3,
    rows: (slot-size,) * 3,
    gutter: 0pt,
    align: center + horizon,
    ..range(1, 10).map(n => {
      if cell-hints.contains(n) {
        text(size: hint-text-size, fill: hint-color)[#n]
      } else {
        []
      }
    }),
  )
}

#let _cell-content(
  board,
  hints,
  row,
  col,
  show-hints,
  cell-size,
  value-text-size,
  hint-text-size,
  value-color,
  hint-color,
) = {
  let value = board.at(row).at(col)

  if _has-value(value) {
    text(size: value-text-size, weight: "semibold", fill: value-color)[#value]
  } else if show-hints {
    let cell-hints = _normalize-hint-cell(hints.at(row).at(col))
    _hint-grid(cell-hints, cell-size, hint-text-size, hint-color)
  } else {
    []
  }
}

#let sudoku(
  board: empty-board,
  hints: none,
  show-hints: false,
  highlighted-rows: none,
  highlighted-columns: none,
  highlighted-cells: none,
  cell-size: 2.4em,
  thin-stroke: 0.5pt + black,
  block-stroke: 1.4pt + black,
  value-color: black,
  hint-color: luma(90),
  row-highlight-fill: rgb("f7f1c7"),
  column-highlight-fill: rgb("ddeefa"),
  overlap-highlight-fill: rgb("e7f4dc"),
  cell-highlight-fill: rgb("f8d7d4"),
  value-text-size: auto,
  hint-text-size: auto,
) = {
  _assert-grid-shape("board", board)

  let hints = if hints == none { empty-hints } else { hints }
  _assert-grid-shape("hints", hints)

  let highlighted-rows = _normalize-selection(highlighted-rows)
  let highlighted-columns = _normalize-selection(highlighted-columns)
  let highlighted-cells = _normalize-selection(highlighted-cells)
  let value-text-size = if value-text-size == auto {
    cell-size * 0.5
  } else {
    value-text-size
  }
  let hint-text-size = if hint-text-size == auto {
    cell-size / 5.5
  } else {
    hint-text-size
  }

  table(
    columns: (cell-size,) * 9,
    rows: (cell-size,) * 9,
    inset: 0pt,
    align: center + horizon,
    fill: (col, row) => _cell-fill(
      row,
      col,
      highlighted-rows,
      highlighted-columns,
      highlighted-cells,
      row-highlight-fill,
      column-highlight-fill,
      overlap-highlight-fill,
      cell-highlight-fill,
    ),
    stroke: (col, row) => _cell-stroke(col, row, thin-stroke, block-stroke),
    ..range(9)
      .map(row => range(9).map(col => _cell-content(
        board,
        hints,
        row,
        col,
        show-hints,
        cell-size,
        value-text-size,
        hint-text-size,
        value-color,
        hint-color,
      )))
      .flatten(),
  )
}
