#set enum(numbering: "a.")

#set page(
  paper: "us-letter",
  margin: (top: 2.3in),
  header: [
    #grid(
      columns: (1fr, 1fr),
      image("images/ecelogo.png", height: 0.8in),
      align(right)[
        Dillon Gutowski \
        9/13/2026 \
        #strong(text(fill: rgb("1F497D"))[EEL3701C - Fall 2026])
      ]
    )
  ],
  numbering: (current, total) => [Page #current],
  number-align: right
)

#set text(
  font: "Helvetica",
  size: 12pt,
)

#show heading: set text(fill:rgb("1F497D"))

#show heading.where(level: 1): it => [
  #align(center)[
    #strong(it.body)
  ]
  #v(0.5em)
]

#show heading.where(level: 2): it => [
  #strong(it.body)
  #v(-0.75em)
  #line(length: 100%, stroke: rgb("1F497D"))
]

= Lab 2: Hierarchical Component Design
== Requirements Not Met
N/A

== Problems Encountered

== Applications

#pagebreak()

#let nt(con) = $overline(#con) #h(0.1em)$

#let truth_table(incolumns, outcolumns, ..cells) = {
  let table_cells = incolumns + (table.vline(stroke: 3pt + gray),) + outcolumns + cells.pos().map(val => {
    if val == 0 {
      table.cell(fill: black, align(center)[#text(fill:white)[0]])
    } else if val == 1 {
      table.cell(fill: white, align(center)[1])
    } else {
      val
    }
  })
  text(font: "JetBrainsMono NF", table(columns: incolumns.len() + outcolumns.len(), ..table_cells))
}

#let kmap_2x2(x_lab, y_lab, x0y0, x1y0, x0y1, x1y1) = {
  let empty = table.cell(stroke:none)[]
  let head(n) = table.cell(stroke:none)[#n]
  let content(n) = if n == 0 {
    table.cell(align: center, fill: black)[#text(fill: white, font: "JetBrainsMono NF")[#n]]
  } else if n == 1 {
    table.cell(align: center)[#text(font: "JetBrainsMono NF")[#n]]
  }
  let nt(n) = overline(n)
  let table_cells = (empty,head(nt(x_lab)),head(x_lab),head(nt(y_lab)),content(x0y0),content(x1y0),head(y_lab),content(x0y1),content(x1y1)) 
  table(columns: 3, ..table_cells)
}
#let kmap_4x4(x1_lab, x2_lab, y1_lab, y2_lab, groups,
              x0y0, x1y0, x2y0, x3y0,
              x0y1, x1y1, x2y1, x3y1,
              x0y2, x1y2, x2y2, x3y2,
              x0y3, x1y3, x2y3, x3y3,
              ) = {
  let group_color(x, y) = {
    for group in groups {
      let coords = group.at(0)
      let color = group.at(1)
      for coord in coords {
        if coord.at(0) == x and coord.at(1) == y {
          return color
        }
      }
    }
    return black
  }
  let empty = table.cell(stroke:none)[]
  let head(n) = table.cell(stroke:none)[#n]
  let content(n, x, y) = table.cell(align: center + horizon, fill: group_color(x, y))[#text(fill: white, font: "JetBrainsMono NF")[#n]]
  let nt(n) = overline()[#n #h(0.1em)]
  let s(a, b) = stack(a, b, spacing: 5pt)
  let table_cells = (
    empty,head(nt(x1_lab) + nt(x2_lab)),head(nt(x1_lab) + x2_lab),head(x1_lab + x2_lab),head(x1_lab + nt(x2_lab)),
    head(s(nt(y1_lab), nt(y2_lab))),content(x0y0, 0, 0),content(x1y0, 1, 0),content(x2y0, 2, 0),content(x3y0, 3, 0),
    head(s(nt(y1_lab), y2_lab)),content(x0y1, 0, 1),content(x1y1, 1, 1),content(x2y1, 2, 1),content(x3y1, 3, 1),
    head(s(y1_lab, y2_lab)),content(x0y2, 0, 2),content(x1y2, 1, 2),content(x2y2, 2, 2),content(x3y2, 3, 2),
    head(s(y1_lab, nt(y2_lab))),content(x0y3, 0, 3),content(x1y3, 1, 3),content(x2y3, 2, 3),content(x3y3, 3, 3),
  ) 
  table(columns: 5, ..table_cells)
}

== Pre-Lab Questions

=== Part 1: Design 2x1 multiplexer
#grid(
  columns: 2,
  column-gutter: 5%,
  truth_table(
    ("S", "A", "B"),("C",),
    0, 0, 0, 0,
    0, 0, 1, 0,
    0, 1, 0, 1,
    0, 1, 1, 1,
    1, 0, 0, 0,
    1, 0, 1, 1,
    1, 1, 0, 0,
    1, 1, 1, 1,
  ),
  block[
    $C(A, B, S) = sum_m (2, 3, 5, 7) = nt(S)A nt(B) + nt(S) A B + S nt(A) B + S A B$\
    Simplify:
    #block(inset: 0.5em)[
      $nt(S)(A nt(B) + A B) + S(nt(A) B + A B)$ #h(1fr) Inverse distribution\
      $nt(S)(A(nt(B) + B)) + S(B(nt(A) + A))$ #h(1fr) Inverse distribution\
      $nt(S)(A(1)) + S(B(1))$ #h(1fr) Inverse\
      #box(stroke: 1pt, inset: 5pt)[$nt(S)A + S B$] #h(1fr) Identity\
    ]
  ]
)
#align(center)[#image("images/mx2.png")]
=== Part 2: Design 4x1 multiplexer
#align(center)[#image("images/mx4.png")]
#pagebreak()
=== Part 3: Design 7-segment display decoder
+ Truth table
  #truth_table(
    ("B1", "B0"),("DP","G","F","E","D","C","B","A"),
    0, 0, 1, 1, 0, 0, 0, 0, 0, 0,
    0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 
    1, 0, 1, 0, 1, 0, 0, 1, 0, 0,
    1, 1, 1, 0, 1, 1, 0, 0, 0, 0,
  
  )
  Karnaugh maps
  #table(align: center, columns: 7, table.header("A", "B", "C", "D", "E", "F", "G"),
    kmap_2x2(
      "B0", "B1",
      0, 1,
      0, 0
    ),
    kmap_2x2(
      "B0", "B1",
      0, 0,
      0, 0
    ),
    kmap_2x2(
      "B0", "B1",
      0, 0,
      1, 0
    ),
    kmap_2x2(
      "B0", "B1",
      0, 1,
      0, 0
    ),
    kmap_2x2(
      "B0", "B1",
      0, 1,
      0, 1
    ),
    kmap_2x2(
      "B0", "B1",
      0, 1,
      1, 1
    ),
    kmap_2x2(
      "B0", "B1",
      1, 1,
      0, 0
    ),
    $B_0 nt(B_1)$,
    $0$,
    $nt(B_0)B_1$,
    $B_0 nt(B_1)$,
    $B_0$,
    $B_0 + B_1$,
    $nt(B_1)$
  )
  Circuit
  #align(center)[#image("images/p3a.png")]
  #colbreak()
+ Truth table
  #truth_table(
    ("B3", "B2", "B1", "B0"),("DP","G","F","E","D","C","B","A"),
    0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 
    0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0,
    0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0,
    0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1,
    0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 
    0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
    1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
    1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 
    1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0,
    1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1,
    1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0,
    1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 
    1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0,
    1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0,
  )
  Karnaugh map
  #grid(columns: 2, column-gutter: 5%,
    block[
      #kmap_4x4(
        "B0", "B1", "B2", "B3",
        (
          (
            ((0,3),), green
          ),
          (
            ((1,1),), orange
          ),
          (
            ((3,0),), olive
          ),
          (
            ((2,2),(2,3)), teal
          ),
        ),
        0, 0, 0, 1,
        0, 1, 0, 0,
        0, 0, 1, 0,
        1, 0, 1, 0
      )
    ],
    grid.cell(align: horizon)[
      #let rc(n, color) = rect(stroke: 2pt + color, radius: 5pt)[#n]
      #par(leading: 14pt)[
        $rc(nt(B_0) nt(B_1) B_2 nt(B_3), #green) + rc(nt(B_0) B_1 nt(B_2) B_3, #orange) + rc(B_0 nt(B_1) nt(B_2) nt(B_3), #olive) + rc(B_0 B_1 B_2, #teal)$
      ]
    ]
  )
  Circuit
  #align(center)[#image("images/7seg.png")]
=== Part 4: Master of tones
#align(center)[#image("images/p4.png")]
