#import "rx-note.typ": rx_style, term
#import "wongoji.typ": wongoji_grid

#import "@preview/cetz:0.3.4": canvas, draw

#set page(paper: "a4")
#set text(lang: "ko")

#show: rx_style.with(
  title: "소프트웨어・데이터",
  subtitle: "#2 집합",
  primary-color: rgb("#B251B8")
)

#let primary-stroke = 0.5pt + luma(80%)

#let text-content(content) = [
  #table(
    columns: (1fr),
    stroke: primary-stroke,
    inset: 13pt,
    content
  )
]

#let writing-space(rows: 1, postfix: [], ..content) = {
  let cells = ()
  
  // 가변 인자로 들어온 content들을 cells 배열에 추가
  if content.pos() != () {
    cells += content.pos()
  }
  
  // rows가 1 이상일 때만 빈 줄들과 postfix 줄을 생성
  if rows > 0 {
    // rows - 1 만큼 빈 줄 추가
    cells += range(rows - 1).map(i => [$" "$])
    // postfix가 포함된 줄 추가
    cells.push([#grid(columns: (1fr, 1fr), $" "$, align(right)[#postfix])])
  }
  
  
  if cells.len() > 0 {
    table(
      columns: (1fr),
      stroke: (x: none, y: primary-stroke, top: none),
      row-gutter: 1.2em,
      ..cells
    )
    v(.7em)
  }
}

#let free-space(height: 10pt) = {
  table(
    columns: (1fr),
    stroke: primary-stroke,
    table.cell(inset: height)[]
  )
}

#let directive(content) = text(size: 1.2em, content)

#let gridnote(
  _cell-size: 5mm,
  _rows: 30,
  _cols: 34,
  _gap: 0mm,
  _stroke: luma(95%) + 0.7pt
) = [
  #align(center)[#box(
    width: _cols * _cell-size + (_cols - 1) * _gap,
    height: _rows * _cell-size + (_rows - 1) * _gap,
    grid(
      columns: (_cell-size,) * _cols,
      rows: (_cell-size,) * _rows,
      stroke: _stroke,
    )
  )]
]

#align(center + horizon)[
  #image("assets/images/chipmunk.jpeg", width: 75%)
]

#align(bottom)[
  #grid(
    columns: (2fr, 1fr),
    [],
    [
      #table(
        columns: (auto, 1fr),
        stroke: (x: none, y: none, bottom: 0.5pt + luma(30%)),
        table.cell(stroke: 0.5pt + luma(30%), inset: 1em)[#text(fill: luma(30%))[이름]]
      )
    ]
  )
 
  #outline(indent: 1.5em, title: "구성")
]

#let hint(content) = [#align(center)[#box(width: 95%, inset: 1em, fill: rgb("#f7fbff"), stroke: 1pt + rgb("#f0f4f8"))[#align(left)[#content]]]]

#pagebreak()

= 집합

== 집합의 표현

#directive[집합을 사용하면 여러 가지 대상이나 객체를 한 데 묶어 생각할 수 있습니다. 집합을 이해해봅시다.]

\

#let example-font-size = .8em
#let example-cell(content) = {
  table.cell(colspan: 2)[#text(size: example-font-size, content)]
}

#figure(
  table(
    columns: (.8fr, 1fr, 3fr),
    align: center + horizon,
    inset: (x: .7em, y: .9em),
    [이름], [표기], [상세],
    table.cell(rowspan: 2)[원소 나열법], [
      $
      S = {a, b, c, d, e}
      $
    ], [집합의 원소들을 ${}$ 사이에 하나씩 나열하는 방법], 
    example-cell[
      $
      "교과목" = {"국어", "수학", "영어", "사회", "과학"}
      $
      $
      "언어" = {"한국어", "영어", "스페인어", "일본어", "프랑스어"}
      $
    ],
    table.cell(rowspan: 2)[조건 제시법], [
      $
      S = {x | p(x)}
      $
    ], [집합의 원소들이 갖고 있는 성질, 조건을 드러내는 방법], 
    example-cell[
      $
      S = {x | 1 <= x <= 5, x"는 자연수"}
      $
      $
      S = {x | x"는 물고기", x"는 우리나라의 특산품"}
      $
    ]
  ),
  caption: [집합의 표현 방법]
)  
\

#figure(
  table(
    columns: (.8fr, 1.5fr, 2.5fr),
    align: center + horizon,
    inset: (x: .7em, y: .9em),
    [이름], [상세], [예시],
    [유한 집합], [집합 $S$의 원소가 유한함], par(leading: .8em)[
      대한민국의 모든 초등학생들의 집합\
      회사 A에서 출시한 모든 제품
    ],
    [무한 집합], [집합 $S$의 원소가 무한함], [
      짝수의 집합\
      $0 < x < 1$을 만족하는 모든 수 $x$
    ]
  ),
  caption: [유한 집합과 무한 집합]
)

\

#figure(
  table(
    columns: (.8fr, 4fr),
    align: center + horizon,
    inset: (x: .7em, y: .9em),
    [이름], [상황], 
    [공집합 $emptyset$], [빈 집합],
    [정수 $Z$], [$Z = {dots, -2, -1, 0, 1, 2, dots}$],
    [자연수 $N$], [$N = {x | x in Z, z > 0} = {1, 2, 3, dots}$], 
    [실수 $R$], [], 
    [유리수 $Q$], [$Q = {x/y | x, y in Z, y != 0}$], 
    [$S_n$], [
      $1$부터 $n$까지의 자연수 집합\
      $S_n = {x | x in N, x <= n} = {1, 2, dots, n}$
    ]
  ),
  caption: [널리 알려진 집합의 종류]
)

== 집합의 관계

#hint[
  - $Z$, $N$, $R$, $Q$는 무한 집합이고, $S_n$은 유한 집합입니다.
  - $S_n subset.eq N subset.eq Z subset.eq Q subset.eq R$
  - $emptyset subset.eq A subset.eq U$
  - $A subset.eq A$
  - $A subset.eq B and B subset.eq C arrow A subset.eq C$
  - $A subset.eq B and B subset.eq A arrow.double.l.r A = B$
  - $emptyset subset.eq { emptyset }, emptyset in {emptyset}$
]

#figure(
  table(
    columns: (.8fr + .5fr, 3.5fr),
    align: center + horizon,
    inset: (x: .7em, y: .9em),
    [이름 / 표기], [상황],
    [부분 집합 $A subset.eq B$], [집합 $A$가 집합 $B$에 속한다.],
    [진부분 집합 $A subset B$], [집합 $A$가 집합 $B$에 속하면서 $A != B$이다.],
    [$A subset.eq.not B$], [집합 $A$가 집합 $B$에 속하지 않는다. (부분 집합 아님)],
    [$A subset.not B$], [집합 $A$가 집합 $B$에 속하지 않는다. (진부분 집합 아님)],
    [여집합 $dash(A), A^c$], [
      집합 $A$가 아닌 나머지 전체\
      전체 집합 $U$와 그것의 부분 집합 $A$에 대해서 $U$에는 속하지만 $A$에 속하지 않음\
      $dash(A) = {x | x in U, x in.not A}$
    ]
  ),
  caption: [두 집합의 관계]
)

// ───────────────── 공통 색상 ─────────────────
#let col-a      = color.mix((blue.lighten(20%), 60%), (white, 40%))
#let col-b      = color.mix((red.lighten(20%),  60%), (white, 40%))
#let col-union  = color.mix((purple.lighten(10%), 70%), (white, 30%))
#let col-inter  = color.mix((orange.lighten(10%), 80%), (white, 20%))
#let col-bg     = rgb("fafafa")

#let venn-diagram-a-subset-eq-b = [#align(center)[
  #block(
    fill: col-bg, stroke: 1pt + luma(200),
    radius: 0pt, inset: 16pt,
    width: 230pt,
    height: 115pt
  )[
    #canvas(length: 0.85cm, {
      import draw: *

      // B (큰 원)
      circle(
        (0, 0), radius: 1.8,
        fill: col-b.transparentize(45%),
        stroke: (paint: red.darken(20%), thickness: 1.6pt)
      )
      // A (작은 원, B 내부에 위치)
      circle(
        (-0.6, 0), radius: 1,
        fill: col-a.transparentize(30%),
        stroke: (paint: blue.darken(20%), thickness: 1.6pt)
      )

      // 레이블
      content((-0.6, 0),    text(fill: blue.darken(30%), weight: "bold")[$A$])
      content((1.2,  0),    text(fill: red.darken(30%),  weight: "bold")[$B$])
    })
  ]
]]

#let venn-diagram-a-inter-B-eq-not-emptyset = [#align(center)[
  #block(
    fill: col-bg, stroke: 1pt + luma(200),
    radius: 0pt, inset: 16pt,
    width: 230pt,
    height: 115pt
  )[
    #canvas(length: .8cm, {
      import draw: *

      // A
      circle(
        (-1.0, 0), radius: 1.8,
        fill: col-a.transparentize(40%),
        stroke: (paint: blue.darken(20%), thickness: 1.6pt)
      )
      // B
      circle(
        (1.0, 0), radius: 1.8,
        fill: col-b.transparentize(40%),
        stroke: (paint: red.darken(20%), thickness: 1.6pt)
      )

      // 레이블
      content((-2.0, 0), text(fill: blue.darken(30%), weight: "bold")[$A$])
      content(( 2.0, 0), text(fill: red.darken(30%),  weight: "bold")[$B$])
      content(( 0.0, 0), text(fill: purple.darken(10%), size: 9pt)[$A inter B$])
    })
  ]
]]

#let venn-diagram-a-inter-b-emptyset = [#align(center)[
  #block(
    fill: col-bg, stroke: 1pt + luma(200),
    radius: 0pt, inset: 16pt,
    width: 230pt,
    height: 115pt
  )[
    #canvas(length: 1cm, {
      import draw: *

      // A
      circle(
        (-1.7, 0), radius: 1.5,
        fill: col-a.transparentize(35%),
        stroke: (paint: blue.darken(20%), thickness: 1.6pt)
      )
      // B
      circle(
        (1.7, 0), radius: 1.4,
        fill: col-b.transparentize(35%),
        stroke: (paint: red.darken(20%), thickness: 1.6pt)
      )

      // 레이블
      content((-1.7, 0), text(fill: blue.darken(30%), weight: "bold")[$A$])
      content(( 1.7, 0), text(fill: red.darken(30%),  weight: "bold")[$B$])
    })
  ]
]]

#grid(
  columns: (1fr, 1fr),
  inset: 0.92em,
  [#figure(venn-diagram-a-subset-eq-b, caption: [$A subset.eq B$])],
  [#figure(venn-diagram-a-inter-B-eq-not-emptyset, caption: [$A inter B eq.not emptyset$])],
  grid.cell(colspan: 2)[#figure(venn-diagram-a-inter-b-emptyset, caption: [$A inter B = emptyset$])]
)

== 집합의 연산



#figure(
  table(
    columns: (.8fr + .5fr, 3.5fr),
    align: center + horizon,
    inset: (x: .7em, y: .9em),
    [이름 / 표기], [상황],
    [합집합 $A union B$], [
      집합 $A$ 또는 집합 $B$에 속하는 원소들의 집합\
      $A union B = {x | x in A or x in B}$
    ],
    [교집합 $A inter B$], [
      집합 $A$과 집합 $B$ 양쪽에 모두 속하는 원소들의 집합\
      $A inter B = {x | x in A and x in B}$
    ],
    [차집합 $A - B$], [
      집합 $A$에 속하지만 집합 $B$에는 속하지 않는 원소들의 집합\
      $A - B = {x | x in A and x in.not B}$
    ],
  ),
  caption: [두 집합의 연산]
)

#let svg-union = ```xml
<svg xmlns="http://www.w3.org/2000/svg" width="460" height="220">
  <defs>
    <style>
      .lbl    { font-family:serif; font-size:20px; font-weight:bold; }
      .op-lbl { font-family:serif; font-size:14px; font-weight:bold; }
    </style>
  </defs>
  <circle cx="170" cy="110" r="90" fill="#c9a0e0" fill-opacity="0.55" stroke="none"/>
  <circle cx="290" cy="110" r="90" fill="#c9a0e0" fill-opacity="0.55" stroke="none"/>
  <circle cx="170" cy="110" r="90" fill="none" stroke="#1a5fa8" stroke-width="2.2"/>
  <circle cx="290" cy="110" r="90" fill="none" stroke="#a81a1a" stroke-width="2.2"/>
  <text x="110" y="115" class="lbl" fill="#0d3d6e">A</text>
  <text x="330" y="115" class="lbl" fill="#6e0d0d">B</text>
  <text x="210" y="115"  class="op-lbl" fill="#5a1a8a">A ∪ B</text>
</svg>
```.text

#let svg-intersection = ```xml
<svg xmlns="http://www.w3.org/2000/svg" width="460" height="220">
  <defs>
    <style>
      .lbl    { font-family:serif; font-size:20px; font-weight:bold; }
      .op-lbl { font-family:serif; font-size:14px; font-weight:bold; }
    </style>
  </defs>
  <circle cx="170" cy="110" r="90" fill="#a8c4e8" fill-opacity="0.35" stroke="#1a5fa8" stroke-width="2.2"/>
  <circle cx="290" cy="110" r="90" fill="#f0a8a8" fill-opacity="0.35" stroke="#a81a1a" stroke-width="2.2"/>
  <path d="M 230 42.92 A 90 90 0 0 1 230 177.08 A 90 90 0 0 1 230 42.92 Z"
        fill="#e8871a" fill-opacity="0.65" stroke="none"/>
  <text x="110" y="115" class="lbl" fill="#0d3d6e">A</text>
  <text x="330" y="115" class="lbl" fill="#6e0d0d">B</text>
  <text x="210" y="115" class="op-lbl" fill="#7a3a00">A ∩ B</text>
</svg>
```.text
#let svg-difference = ```xml
<svg xmlns="http://www.w3.org/2000/svg" width="460" height="220">
  <!--
    두 원: A(cx=170, r=90),  B(cx=290, r=90)
    교점:  (230, 42.92)  /  (230, 177.08)

    A−B 초승달 경로 구성:
      ① 위 교점 → 아래 교점 : 원 A 기준 큰 호 (왼쪽으로 크게)
         large-arc=1, sweep=0  (반시계)
      ② 아래 교점 → 위 교점 : 원 B 기준 작은 호 역방향
         large-arc=0, sweep=0  (반시계)  ← 렌즈 오른쪽 경계 역추적
  -->
  <defs>
    <style>
      .lbl    { font-family:serif; font-size:20px; font-weight:bold; }
      .op-lbl { font-family:serif; font-size:14px; font-weight:bold; }
    </style>
  </defs>

  <!-- A−B 초승달: 정확한 Arc Path -->
  <path d="
    M 230 42.92
    A 90 90 0 1 0 230 177.08
    A 90 90 0 0 0 230 42.92
    Z"
    fill="#4a90d9" fill-opacity="0.70"
    stroke="none"/>

  <!-- A: 테두리만 (초승달 위에 선만 덮기) -->
  <circle cx="170" cy="110" r="90"
          fill="none"
          stroke="#1a5fa8" stroke-width="2.2"/>

  <!-- B: 흐린 채우기 + 테두리 -->
  <circle cx="290" cy="110" r="90"
          fill="#fafafa" fill-opacity="1"
          stroke="#a81a1a" stroke-width="2.2"/>

  <!-- 레이블 -->
  <text x="108" y="115" class="lbl"    fill="#0d3d6e">A</text>
  <text x="285" y="115" class="lbl"    fill="#6e0d0d">B</text>
  <text x="140" y="114" class="op-lbl" fill="#0d3d6e">A − B</text>
</svg>
```.text


// ── 카드 래퍼 함수 ──────────────────────────────────────
#let venn-card(svg-text) = align(center)[
  #block(
    fill: col-bg, stroke: 1pt + luma(200),
    radius: 0pt, inset: 8pt,
    width: 230pt, height: 120pt,
    clip: true,
  )[
    #image(bytes(svg-text), format: "svg", width: 100%, height: 100%, fit: "contain")
  ]
]

// ── 2×2 그리드 ──────────────────────────────────────────
#grid(
  columns: (1fr, 1fr),
  inset: 0.92em,
  figure(venn-card(svg-union), caption: [$A union B$]),
  figure(venn-card(svg-intersection), caption: [$A inter B$]),
  grid.cell(colspan: 2)[#figure(venn-card(svg-difference), caption: [$A - B$])]
)

#pagebreak()

= 집합 익히기 -- 「일본 헤이안 시대, 고전 문학의 세계」

\

#directive[아래의 지문을 읽어보세요.]

#text-content[
  헤이안 시대(794\~1185)에 성립한 일본 문학은 산문 문학과 시 문학이 활발히 발전한 시기로 알려져 있다. 산문 문학으로는 모노가타리(物語), 일기(日記), 수필(随筆) 등이 있으며, 시 문학으로는 일본 고유의 정형시인 와카(和歌)와 한시(漢詩) 등이 있다.

  \
  
  모노가타리는 성립 형식에 따라 두 계열로 구분된다. 하나는 와카와 그 와카가 지어진 상황을 이야기 형식으로 전달하는 우타모노가타리(歌物語)이며, 다른 하나는 가공의 세계를 배경으로 서술하는 츠쿠리모노가타리(作り物語)이다. 《이세모노가타리》, 《야마토모노가타리》, 《헤이추모노가타리》는 우타모노가타리에 해당하고, 《타케토리모노가타리》, 《우츠호모노가타리》, 《겐지모노가타리》는 츠쿠리모노가타리에 해당한다.

  \
  
  헤이안 시대를 대표하는 칙찬 와카집인 《고킨와카슈(古今和歌集)》는 905년 무렵에 편찬되었으며, 기노 츠라유키(紀貫之), 기노 도모노리(紀友則), 오시코치노 미츠네(凡河内躬恒), 미부노 다다미네(壬生忠岑)의 네 사람이 편찬을 맡았다. 약 1,100수의 와카가 수록된 이 가집에는 편찬자 네 사람의 작품은 물론, 아리와라노 나리히라(在原業平), 소토오리히메, 오노노 고마치를 비롯한 다수의 가인 작품도 실려 있다. 아리와라노 나리히라의 작품은 《이세모노가타리》에 수록된 와카와도 일부 겹치는 것으로 전해지나, 두 작품에 수록된 와카가 완전히 동일하지는 않다.

  \
  
  《이세모노가타리》는 헤이안 시대 최초의 우타모노가타리로, 125단으로 구성된 옴니버스 형식의 이야기이다. 대부분의 단에서는 '무카시오토코(昔、男)'로 불리는 남성 주인공이 등장하며, 그가 와카를 주고받는 이야기를 중심으로 서사가 전개된다. 그러나 23단 《우물벽(筒井筒)》의 주인공은 '시골에서 일하던 사람의 자식', '야마토의 사람'으로만 지칭되어 있어, 다른 단의 무카시오토코와 동일 인물로 보기 어렵다는 것이 학계의 일반적인 시각이다. 이처럼 《이세모노가타리》는 단일한 주인공의 이야기로 읽히기도 하지만, 작품 전체를 아리와라노 나리히라 한 사람의 행적으로 보는 데에는 무리가 따른다.

  \
  
  헤이안 귀족 사회에서 와카는 단순한 창작 활동이 아니라, 상대의 마음을 움직이는 수단으로서 사회적으로 중요한 기능을 담당하였다. 와카를 통해 타인의 마음을 움직이는 행위를 '미야비(雅び)'로서 높이 평가하였으며, 와카를 통해 행복한 결말에 이르는 이야기 유형을 가덕설화(歌德説話)라고 일컫는다. 가덕설화는 우타모노가타리에서 자주 나타나는 서사 유형이다.

  \
  
  《우물벽》에는 야마토 여자와 카와치 여자가 각각 남자에게 와카를 지어 보내는 장면이 등장한다. 야마토 여자의 와카는 남자를 카와치로 떠나지 못하게 하는 데 성공하는 반면, 카와치 여자의 와카는 끝내 남자의 발길을 다시 돌리지 못한다. 두 여자 모두 와카를 읊었지만, 이야기 안에서 그 결과는 서로 다르게 귀결된다. 《우물벽》은 이와 같이 '미야비'를 구현한 야마토 여자와, '히나비(鄙び)'로 표현되는 세련되지 않은 카와치 여자를 대조적으로 구성하여 가덕설화의 전형을 보여주는 단으로 평가받는다.
]

\

#directive[다음의 서술이 타당한지 판단해보세요.]

\

- 일본 헤이안 시대의 시 문학에는 와카, 한시, 수필이 있다. // X 수필은 산문

\

- 산문 문학인 모노가타리는 와카를 중심으로 이야기가 이어지는 우타모노가타리, 가공의 세계를 배경으로 이야기가 이어지는 츠쿠리모노가타리가 있다. // O

\

- 산문 문학인 모노가타리의 일종인 우타모노가타리에서 사용하는 와카는 산문 문학인 모노가타리에서 다루고 있으므로, 와카라고 하더라도 산문 문학으로 보아야 한다. // X 와카는 시 문학

\

- 《이세모노가타리》, 《야마토모노가타리》, 《헤이추모노가타리》는 모노가타리이지만, 츠쿠리모노가타리로 볼 수는 없다. // O

\

- 《이세모노가타리》는 헤이안 시대 최초의 모노가타리로, 125단으로 구성된 옴니버스 형식의 이야기이다.  // X 최초는 타케토리모노가타리

\

- 《이세모노가타리》의 주인공은 '무카시오토코'이고, 이 '무카시오토코'가 와카를 주고받는 이야기를 중심으로 이야기가 이어진다. // X 무카시오토코가 주인공이 아닌 단이 있음

\

- 《이세모노가타리》의 '무카시오토코'는 시골이 아닌 도읍지에서 생활하는 사람이다. // O

\

- 《우물벽》은 《야마토모노가타리》에 수록된 단편이다. // X 이세모노가타리

\

- 헤이안 귀족 사회에서는 와카를 통해 타인의 마음을 움직이는 행위를 '히나비'로서 높이 평가했다.  // X 미야비

\

- 야마토 여자의 와카는 남자를 카와치로 떠나지 못하게 하여, 카와치 여자의 행복한 결말에 도달하지 못하게 되었으므로, 《우물벽》은 가덕설화로 볼 수 없다.  // X 와카를 지어 보내는 미야비로 인물의 마음을 바꾸어냄. 인물의 마음을 바꾼 사람이 행복한 결말을 맞았으므로 가덕설화임

#pagebreak()

#directive[앞의 지문에서 확인할 수 있는 집합 관계를 그려봅시다.]

#align(center)[#gridnote(
  _rows: 47,
)]

#pagebreak()

= 디지털 화상 파일의 형식

\

#directive[아래의 지문을 읽어보세요.]

#text-content[
  디지털 이미지의 종류 ... 디지털 이미지는 크게 세 가지로 나뉜다. 래스터 이미지는 작은 점(픽셀)들로 그림을 만드는 방식이고, 벡터 이미지는 수학 공식으로 선과 도형을 그리는 방식이다. 동화상은 움직이는 영상으로, 여러 장의 정지 이미지를 빠르게 연결한 것이다.

  \
  
  자주 쓰이는 이미지 포맷 ... JPEG, PNG, GIF, BMP, TIFF가 가장 많이 사용된다. 이 중에서 PNG, GIF, BMP, TIFF는 압축할 때 정보가 손실되지 않고(무손실), JPEG는 파일 크기를 줄이면서 약간의 정보를 버린다(손실).

  \
  
  색상 표현 능력 ... 포맷마다 표현할 수 있는 색상이 다르다. GIF는 최대 256색만 가능하지만, PNG와 TIFF는 훨씬 더 많은 색상(수천만 가지)을 표현할 수 있다. 따라서 GIF가 표현하는 모든 색상은 PNG나 TIFF에서도 표현 가능하다.

  \
  
  투명도 기능 ... PNG는 투명한 부분을 만들 수 있지만, GIF는 특정 색 하나만 투명하게 할 수 있고, JPEG와 BMP는 투명도를 지원하지 않는다.

  \
  
  움직이는 이미지 ... GIF는 여러 장의 이미지를 담아서 애니메이션을 만들 수 있다. PNG는 표준으로는 불가능하지만 확장판(APNG)을 쓰면 가능하다. MP4나 AVI 같은 동영상 파일은 처음부터 애니메이션을 담기 위해 만들어졌다.

  \
  
  벡터 이미지와 전용 소프트웨어 ... SVG, AI, CDR 같은 벡터 포맷들이 있다. Photoshop의 PSD, GIMP의 XCF 같은 파일들은 특정 프로그램에서만 완전히 열 수 있다. 반면 PNG나 JPEG는 어떤 프로그램에서나 쉽게 볼 수 있다.
]

\

#text-content[
  디지털 화상 파일은 저장 방식에 따라 크게 래스터 이미지, 벡터 이미지, 동화상으로 나뉜다. 래스터 이미지는 픽셀 단위로 색상과 밝기 정보를 기록하는 방식이며, 벡터 이미지는 수학적 표현으로 선과 도형을 정의하는 방식이다. 동화상은 시간 순서로 배열된 프레임의 연속으로 구성되며, 그 프레임은 래스터 화상으로 이루어지는 경우가 일반적이다. 오디오 트랙을 함께 수록할 수 있다는 점에서 정지 화상과 구별되는 또 다른 특징을 지닌다.

  \

  래스터 이미지 형식 중 JPEG, PNG, GIF, BMP, TIFF는 오늘날 광범위하게 사용되는 대표적인 포맷이다. 이 가운데 무손실 압축을 채택한 포맷으로는 PNG, GIF, BMP, TIFF가 있으며, JPEG는 비가역 압축, 즉 손실 압축 방식을 기본으로 사용한다. 단, JPEG 규격 안에는 가역 압축 방식도 정의되어 있으나, 특허 등의 이유로 사실상 활용되지 않는다. PBM, PGM, PPM을 포함하는 PNM 계열 포맷과 BMP는 압축 자체를 적용하지 않는 무압축 형식이기도 하다.

  \
  
  색상 표현 범위의 측면에서 보면 포맷마다 지원하는 색상의 수가 다르다. GIF는 팔레트 방식을 채택하여 최대 256색까지만 표현할 수 있다. PNG 역시 팔레트 모드에서는 최대 256색이지만, RGB 또는 RGBA 모드에서는 24비트 이상의 색상을 표현할 수 있으며, 16비트 그레이스케일도 지원한다. TIFF와 BMP, JPEG는 RGB 각 채널에 8비트를 할당하여 약 1,677만 가지 색상을 기본으로 표현하며, TIFF와 PNG는 채널당 16비트까지 확장이 가능하다. GIF가 표현할 수 있는 색상의 범위는 PNG나 TIFF가 표현할 수 있는 범위 안에 완전히 들어간다.

  \
  
  투명도 지원 여부도 포맷마다 다르다. PNG는 8비트에서 16비트에 이르는 알파 채널을 통해 반투명 표현까지 가능하다. GIF는 특정 색상을 투명색으로 지정하는 방식만 지원하여 반투명 표현은 불가능하다. BMP와 JPEG는 투명도를 지원하지 않는다. TIFF는 알파 채널을 포함한 다양한 구성을 지원한다. 알파 채널을 통한 반투명 표현이 가능한 포맷은 PNG와 TIFF이며, GIF는 투명색 지정이 가능하지만 알파 채널  자체를 지원하지는 않는다.

  \
  
  애니메이션 기능의 지원 여부를 살펴보면, GIF는 복수의 프레임을 하나의 파일에 수록하는 애니메이션 기능을 표준으로 지원한다. PNG는 표준 규격상 애니메이션을 지원하지 않으나, PNG를 확장한 APNG 및 MNG 형식을 통해 애니메이션을 구현할 수 있다. JPEG, BMP, TIFF는 애니메이션을 지원하지 않는다. 동화상 포맷인 MP4, AVI, WebM 등은 애니메이션을 포함하는 연속 영상의 수록을 본래 목적으로 설계된 형식이다.

  \
  
  벡터 이미지 형식에는 2D 벡터 포맷과 3D 벡터 포맷이 있다. SVG는 2D 벡터 포맷으로, XML 기반으로 작성되어 웹 환경과의 친화성이 높다. AI, CDR, EPS 등도 2D 벡터 포맷에 해당한다. 3D 모델링 데이터를 다루는 STL, OBJ(Wavefront), COLLADA, 3DS 등은 3D 벡터 포맷이다. 2D 벡터 포맷이 다루는 도형과 3D 벡터 포맷이 다루는 입체 데이터는 표현 차원이 다르며, 어느 한쪽 포맷이 다른 쪽을 완전히 대신할 수 없다.

  \
  
  전용 소프트웨어가 요구되는 포맷으로는 PSD(Adobe Photoshop), AI(Adobe Illustrator), KRA(Krita), XCF(GIMP), SAI 등 각 화상 편집 소프트웨어의 전용 저장 형식이 있다. 이들 포맷은 레이어, 편집 이력, 채널 정보 등 해당 소프트웨어에서만 유효한 데이터를 보존한다는 점에서, 타 소프트웨어와의 호환이 제한된다. 범용 래스터 포맷인 JPEG, PNG, BMP, GIF, TIFF는 운영체제 수준에서 직접 지원되거나 별도 설치 없이도 다수의 소프트웨어에서 열람이 가능한 경우가 많다. 


  \
  
  GIF 파일의 경우 헤더에 글로벌 컬러 테이블을 정의하며, 각 프레임은 별도의 로컬 컬러 테이블을 가질 수도 있다. 글로벌 컬러 테이블과 로컬 컬러 테이블은 각각 독립적으로 정의되며, 특정 프레임에 로컬 컬러 테이블이 존재하는 경우 해당 프레임에서는 글로벌 컬러 테이블 대신 로컬 컬러 테이블이 우선 적용된다.

  \
  
  JPEG는 JFIF와 Exif 두 가지 파일 포맷으로 저장되는 경우가 대부분이다. 단순히 "JPEG 파일"이라 부를 때는 JFIF 형식을 가리키는 것이 일반적이며, Exif는 디지털 카메라에서 촬영 정보, 날짜, 섬네일 이미지 등의 부가 정보를 화상 파일에 함께 수록하기 위해 사용된다. Exif는 JPEG 외에 TIFF 형식도 지원한다. 즉, Exif 규격이 지원하는 화상 포맷의 범위와 JPEG 포맷의 범위는 서로 겹치지만 어느 한쪽이 다른 쪽을 완전히 포함하지는 않는다.
]

\

#directive[디지털 화상 파일은 무엇을 기준으로 구분할 수 있었나요? 구분 기준을 적어보세요.]

#writing-space(rows: 4)

\

#directive[래스터 이미지, 벡터 이미지, 동화상 파일은 무엇인가요?]

#writing-space([래스터 이미지는 ], postfix: [이다.])

#writing-space([벡터 이미지는 ], postfix: [이다.])

#writing-space([동화상 파일은 ], postfix: [이다.])

\

#directive[투명도를 지원하는 이미지 형식은 무엇이 있나요? 이들은 대체로 어떤 특징을 가지고 있나요?]

#writing-space(rows: 3)

#pagebreak()

#directive[앞의 지문에서 확인할 수 있는 집합 관계를 그려봅시다.]

#align(center)[#gridnote(
  _rows: 47,
)]

#pagebreak()

= GIF 없는 GIF 기능?

\

#directive[인터넷에서 아래의 동물 사진들을 본 적 있나요? 어떤 사이트, 앱에서 마주쳤나요?]

#align(center)[#box(width: 90%)[#align(center)[
  #grid(columns: (auto, auto, auto),
    align: center + horizon,
    inset: .5em,
    image("assets/images/dancing-cat.png"),
    image("assets/images/goat.png"),
    image("assets/images/shocked-cat.png")
  )
]]]

\

#writing-space(rows: 3)
\


\

#directive[SNS나 메신저 앱을 사용하다보면 이따금 "GIF"라고 되어있는 버튼을 볼 수 있습니다. 이 GIF 버튼을 눌러본 적 있나요? 어떤 기능이었나요?]

#writing-space(rows: 4)

#pagebreak()

#directive[아래의 지문을 읽어보세요.]

#text-content[
  GIF는 Graphics Interchange Format의 약자로, 1987년 CompuServe가 개발한 이미지 파일 형식이다. 개발 당시에는 인터넷 환경 자체가 지금과 비교할 수 없을 만큼 열악했기 때문에, 파일 크기를 최소화하는 것이 무엇보다 중요한 과제였다. GIF는 이러한 시대적 요구에 부응하여 설계된 포맷으로, 당시 기준으로는 꽤 효율적인 압축 방식을 채택하고 있었다.

  \
  
  그러나 GIF 형식에는 구조적인 한계가 있다. 가장 대표적인 문제는 색상 표현의 제약이다. GIF는 한 프레임에서 표현할 수 있는 색상의 수가 최대 256가지로 고정되어 있다. 현대의 디스플레이 장치들이 수백만 가지 이상의 색상을 표현하는 것과 비교하면 극히 제한적인 수치다. 이 때문에 GIF로 저장된 영상이나 이미지는 색 표현이 뭉개지거나 계단 현상이 나타나는 등 화질 저하가 눈에 띄게 발생한다.

  \
  
  파일 크기 문제도 심각하다. GIF는 움직이는 이미지, 즉 애니메이션을 구현할 때 각 프레임을 개별 이미지로 저장하는 방식을 사용한다. 프레임 수가 늘어날수록, 또 해상도가 높아질수록 파일 크기는 기하급수적으로 커진다. 몇 초짜리 짧은 움직임을 GIF로 저장하더라도 파일 크기가 수십 메가바이트에 달하는 경우가 흔하다. 반면 같은 내용을 MP4 같은 현대적인 영상 포맷으로 저장하면 파일 크기가 몇 분의 일 수준으로 줄어드는 동시에 색상 표현도 훨씬 정확해진다.

  \
  
  이러한 이유로 트위터, 슬랙, 디스코드, 텐서, 카카오톡 등 현재 운영 중인 대부분의 IT 서비스들은 사용자가 GIF를 업로드하거나 GIF 기능을 사용할 때 실제로는 GIF 파일 형식을 그대로 처리하지 않는다. 서비스 내부에서는 업로드된 GIF를 자동으로 MP4나 WebM 같은 영상 포맷으로 변환하여 저장하고 전송한다. 사용자 화면에 보이는 것은 영상 파일이지만, 인터페이스에는 여전히 GIF라는 단어가 표시된다. 사용자가 GIF라는 개념에 워낙 익숙해져 있기 때문에, 굳이 기술적으로 정확한 용어를 사용하는 것보다 GIF라는 표현을 유지하는 쪽이 사용자 경험에 유리하다는 판단에서 비롯된 것이다.

  \
  
  결과적으로 GIF는 오늘날 두 가지 의미로 쓰인다. 하나는 1987년에 정의된 기술 규격으로서의 파일 형식이고, 다른 하나는 짧고 반복 재생되는 움직이는 이미지라는 개념 자체를 가리키는 일상적인 표현이다. 후자의 의미가 점점 더 지배적으로 자리를 잡으면서, GIF는 특정 파일 확장자를 의미하는 단어에 그치지 않고, 하나의 콘텐츠 유형을 지칭하는 보통명사로 정착했다. 기술 용어가 일상어로 흡수되는 과정은 IT 분야에서 드물지 않은 현상이지만, GIF의 경우 원래의 기술적 실체와 현재 통용되는 의미 사이의 차이가 뚜렷한 특이한 사례가 된 것이다.
]

#pagebreak()

#directive[지문의 주제는 무엇이었나요?]

#free-space(height: 40mm)

\

#directive[지문이 말하고자 하는 내용은 무엇이었나요? 도식으로 그려봅시다.]

#gridnote(_rows: 27)

#pagebreak()

#directive[앞선 지문에서, GIF 기능은 실제로 GIF를 사용하지 않는다고 했습니다. 내가 IT 서비스를 개발해서 서비스한다면, GIF 기능을 어떻게 만들 수 있을까요?]

\
#wongoji_grid(rows: 20)

#pagebreak()

#wongoji_grid(rows: 24)

#pagebreak()

#wongoji_grid(rows: 24)

/*
집합 관계;	지문 내 근거
무손실 압축 포맷 ⊊ 래스터 포맷;	PNG·GIF·BMP·TIFF는 무손실, JPEG는 기본 손실
GIF 표현 색상 ⊊ PNG 표현 색상;	GIF 최대 256색, PNG는 256색 초과 가능
GIF 표현 색상 ⊊ TIFF 표현 색상;	동일 구도
반투명 지원 포맷 ⊊ 투명도 지원 포맷;	GIF는 투명 지원이나 반투명 불가, PNG·TIFF는 반투명 가능
전용 포맷 ∩ 범용 포맷 = ∅, 둘 다 ⊆ 래스터 포맷;	전용·범용 구분 단락
2D 벡터 포맷 ∩ 3D 벡터 포맷 = ∅;	어느 한쪽이 다른 쪽을 대신할 수 없다
보조 청크 ∩ 부가 청크 = ∅, 둘 다 ⊆ 선택적 청크;	PNG 청크 단락
Exif 지원 포맷 ∩ JPEG = JPEG, 완전 포함은 아님;	Exif는 JPEG·TIFF 지원, JPEG ⊊ Exif 지원 범위 아님
동화상 ⊇ {래스터 프레임};	동화상 프레임은 래스터로 구성 서술
*/


/*
집합 관계;	지문 내 위치
우타모노가타리 ⊊ 모노가타리;	이세모노가타리·야마토모노가타리 ↔ 겐지모노가타리 비교 단락
겐지모노가타리 ∉ 우타모노가타리;	"츠쿠리모노가타리에 해당한다" 서술
고킨와카슈 수록 와카 ∩ 이세모노가타리 수록 와카 ≠ ∅, 두 집합 ≠;	나리히라 와카 일부 겹침 서술
무카시오토코 등장 단 ⊊ 125단 전체;	23단 주인공 예외 서술
편찬자 4인 ⊊ 고킨와카슈 수록 가인;	나리히라 등 다수 가인 포함 서술
가덕설화 ⊆ 우타모노가타리 서사 유형;	가덕설화 단락
와카를 읊은 인물 − 성공한 인물 = 카와치 여자;	《우물벽》 두 여자 비교 단락
*/

