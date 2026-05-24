// ─────────────────────────────────────────────────────────────
//  OFDM Receiver Theory – Typst 디자인 패키지
//  파일명 : rx-note.typ
// ─────────────────────────────────────────────────────────────

#let rx_style(
  title: "Document Title",
  subtitle: "Subtitle",
  author: none,
  primary-color: rgb("#0056b3"),
  body
) = {
  let serif = ("RidiBatang", "Noto Serif KR", "Noto Serif CJK KR")
  let sans = ("Pretendard", "Noto Sans KR", "Noto Sans CJK KR")
  
  // 1. 페이지 기본 설정
  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2.5cm),
    header: grid(
      columns: (1fr, 1fr),
      align(left)[#text(fill: luma(70%))[#title]],
      align(right)[#context {
        if counter(page).get().at(0) > 0 {
          align(right, text(8pt, fill: gray.darken(20%), subtitle))
        }
      }],
    ),
    footer: context [
      #line(length: 100%, stroke: 0.5pt + gray)
      #set text(8pt, fill: gray)
      #grid(
        columns: (1fr, 1fr),
        align(left, []),
        align(right, counter(page).display())
      )
    ]
  )

  // 2. 기본 글꼴·텍스트 설정
  set text(
    font: serif,
    size: 10pt,
    lang: "ko"
  )

  // 3. 문서 타이틀 영역
  block(width: 100%, inset: (bottom: 1.5em))[
    #v(12pt)
    #text(36pt, weight: "bold", fill: primary-color)[#title]
    
    #text(20pt, fill: gray.darken(50%))[#subtitle]
    #if author != none {
      v(0.2em)
      text(10pt, fill: gray)[#author]
    }
  ]

  // -------------------------------------------------
  // 4. 헤딩(Heading) 스타일 및 번호 활성화 (핵심 수정 부분)
  // -------------------------------------------------
  // 중요: 이 설정이 있어야 counter가 작동합니다.
  set heading(numbering: "1.") 

  show heading: set text(font: sans)
  show heading.where(level: 1): it => block(inset: (top: 1em, bottom: 0.5em))[
    #set text(20pt, weight: "bold", fill: black)
    #stack(
      dir: ltr,
      spacing: 0.5em,
      // 번호 뒤에 마침표 없이 § 기호만 쓰고 싶다면 .at(0) 등을 쓸 수 있으나 
      // 기본 display()가 설정된 numbering 형식을 따릅니다.
      text(fill: primary-color)[§#counter(heading).display()],
      it.body
    )
  ]

  show heading.where(level: 2): it => block(inset: (top: 0.8em, bottom: 0.4em))[
    #set text(13pt, weight: "bold")
    #it
  ]

  // 5. 기타 스타일
  set par(justify: true, leading: 1.3em)
  show link: set text(fill: primary-color)
  show link: underline

  show outline: set text(size: 1.2em)
  
  show quote: it => rect(
    width: 100%,
    fill: primary-color.lighten(95%),
    stroke: (left: 3pt + primary-color),
    inset: 1em,
    it
  )

  body
}

#let term(name, description) = block(width: 100%, inset: (left: 0.5em, y: 0.2em))[
  #grid(
    columns: (80pt, 1fr),
    text(weight: "bold", fill: gray.darken(30%))[#name],
    description
  )
]
