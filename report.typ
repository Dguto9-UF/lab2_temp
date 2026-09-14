#set enum(numbering: "a.")

#set page(
  paper: "us-letter",
  margin: (top: 2.5in),
  header: [
    #grid(
      columns: (1fr, 1fr),
      image("images/ecelogo.png", height: 0.8in),
      align(right)[
        Dillon Gutowski \
        9/7/2026 \
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

= Lab 1: Basic Logic Design
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

== Pre-Lab Questions

=== Part 1: Design 2x1 multiplexer
+ #truth_table(
    ("S", "A", "B"),("C",),
    0, 0, 0, 0,
    0, 0, 1, 0,
    0, 1, 0, 1,
    0, 1, 1, 1,
    1, 0, 0, 0,
    1, 0, 1, 1,
    1, 1, 0, 0,
    1, 1, 1, 1,
  )
+ $C(A, B, S) = sum_m (2, 3, 5, 7) = nt(S)A nt(B) + nt(S) A B + S nt(A) B + S A B$\
  Simplify:
  #block(inset: 0.5em)[
    $nt(S)(A nt(B) + A B) + S(nt(A) B + A B)$ #h(1fr) Inverse distribution\
    $nt(S)(A(nt(B) + B)) + S(B(nt(A) + A))$ #h(1fr) Inverse distribution\
    $nt(S)(A(1)) + S(B(1))$ #h(1fr) Inverse\
    $nt(S)A + S B$ #h(1fr) Identity\
  ]
=== Part 2: Design 4x1 multiplexer
=== Part 3: Design 7-segment display decoder
+ #truth_table(
    ("B1", "B0"),("DP","G","F","E","D","C","B","A"),
    0, 0, 1, 1, 0, 0, 0, 0, 0, 0,
    0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 
    1, 0, 1, 0, 1, 0, 0, 1, 0, 0,
    1, 1, 1, 0, 1, 1, 0, 0, 0, 0,
  
  )
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
=== Part 4: Master of tones
