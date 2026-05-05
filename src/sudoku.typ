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

#let _has-value(value) = value != none and value != 0

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
