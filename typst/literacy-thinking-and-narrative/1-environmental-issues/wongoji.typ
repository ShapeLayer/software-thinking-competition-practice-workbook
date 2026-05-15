#let default_red = rgb("#d14141")

#let wongoji_grid(
  txt: "",
  cols: 20, 
  rows: 10, 
  cell: 8.5mm, 
  box_bg: none
) = {
  let clusters = txt.clusters()
  let row-gap = 6pt
  let _stroke = default_red + 0.3pt
  
  box(
    inset: 0pt,
    fill: box_bg,
    width: cols * cell,
    height: rows * cell + (rows - 1) * row-gap,
    stroke: _stroke,
    grid(
      columns: (cell,) * cols,
      rows: (cell,) * rows,
      stroke: _stroke,
      align: center + horizon,
      inset: 0pt,
      row-gutter: row-gap,
      ..range(cols * rows).map(i => {
        let ch = if i < clusters.len() { clusters.at(i) } else { " " }
        let col = calc.rem(i, cols)

        let cell-stroke = if col == 0 and col == cols - 1 {
          (left: none, right: none, top: _stroke, bottom: _stroke)
        } else if col == 0 {
          (left: none, right: _stroke, top: _stroke, bottom: _stroke)
        } else if col == cols - 1 {
          (left: _stroke, right: none, top: _stroke, bottom: _stroke)
        } else {
          _stroke
        }

        grid.cell(stroke: cell-stroke)[
          #text(fill: black, size: cell * 0.6)[#ch]
        ]
      })
    )
  )
}
