#import "rx-note.typ": rx_style, term
#import "wongoji.typ": wongoji_grid

#import "@preview/cetz:0.3.4": canvas, draw

#set page(paper: "a4")
#set text(lang: "ko")

#show: rx_style.with(
  title: "소프트웨어・데이터",
  subtitle: "#3 오토마타",
  primary-color: rgb("#7365A6")
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
  #image("assets/images/black-footed-cat.jpeg", width: 75%)
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

= 오토마타

\

#directive[아래의 그림을 보세요. 무엇이 보이나요?]

#free-space(height: 10mm)

#figure(image("assets/images/park.jpeg"))

#directive[다음 대상들의 공통점은 무엇일까요?]

#let park-circle-size = 3.5cm
#v(0.2em)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  [#box(
      width: park-circle-size,
      height: park-circle-size,
      radius: 50%,
      clip: true,
      image("assets/images/park-car.jpg", width: 100%, height: 100%, fit: "cover")
  )],
  [#box(
    width: park-circle-size,
    height: park-circle-size,
    radius: 50%,
    clip: true,
    image("assets/images/park-cat.jpg", width: 100%, height: 100%, fit: "cover")
  )],
  [#box(
    width: park-circle-size,
    height: park-circle-size,
    radius: 50%,
    clip: true,
    image("assets/images/park-clock.jpg", width: 100%, height: 100%, fit: "cover")
  )],
  [#box(
    width: park-circle-size,
    height: park-circle-size,
    radius: 50%,
    clip: true,
    image("assets/images/park-vending-machine.jpg", width: 100%, height: 100%, fit: "cover")
  )]
)

#free-space(height: 14mm)

#pagebreak()

#directive[아래의 글을 읽어보세요.]

#text-content[
  어떤 규칙에 따라 입력을 읽고 상태를 바꾸면서 작동하는 기계를 한데 일컬어 한 단어로 표현할 수 있다. 이들은 현재 자신의 상태와 이어지는 입력에 따라서 다음 상태가 변화할 수도 있고, 바깥 세계에 어떤 결과물을 내놓을 수도 있다. 이것들을 오토마타(Automata)라고 부른다. 오토마타는 그 자체로 현실에 존재하는 것은 아니다. 자체적으로 동작하며 변화하는 것들을 한 번에 설명하기 위해, 이론으로 정의한 수학적인 모델이다.
]

\

#directive[
  자동차, 고양이, 시계, 자판기는 모두 어딘가 자체적으로 움직이거나 동작할 수 있습니다. 이것들을 오토마타라고 부를 수 있을까요?
]

#v(4mm)

#let grid-park-circle-size = 2cm

#grid(align: horizon, columns: (1fr, 9fr), gutter: 0.5em,
  [#box(
      width: grid-park-circle-size,
      height: grid-park-circle-size,
      radius: 50%,
      clip: true,
      image("assets/images/park-car.jpg", width: 100%, height: 100%, fit: "cover")
  )],
  [#writing-space(rows: 0)[#grid(columns: (1fr, 1fr), grid.cell(align: left)[자동차는], grid.cell(align: right)[이기 때문에])][#grid(columns: (10fr, 1fr), [#align(right)[오토마타라고 할 수]], grid.cell(align: right)[다.])]]
)
#v(4mm)

#grid(align: horizon, columns: (9fr, 1fr), gutter: 0.5em,
  [#writing-space(rows: 0)[#grid(columns: (1fr, 1fr), grid.cell(align: left)[고양이는], grid.cell(align: right)[])][#grid(columns: (10fr, 1fr), [#align(right)[때문에 오토마타라고 할 수]], grid.cell(align: right)[다.])]],
  [#box(
      width: grid-park-circle-size,
      height: grid-park-circle-size,
      radius: 50%,
      clip: true,
      image("assets/images/park-cat.jpg", width: 100%, height: 100%, fit: "cover")
  )]
)

#v(4mm)

#grid(align: horizon, columns: (1fr, 9fr), gutter: 0.5em,
  [#box(
      width: grid-park-circle-size,
      height: grid-park-circle-size,
      radius: 50%,
      clip: true,
      image("assets/images/park-clock.jpg", width: 100%, height: 100%, fit: "cover")
  )],
  [#writing-space(rows: 0)[#grid(columns: (1fr, 1fr), grid.cell(align: left)[시계는], grid.cell(align: right)[])][#grid(columns: (10fr, 1fr), [#align(right)[때문에 오토마타라고 할 수]], grid.cell(align: right)[다.])]]
)
#v(4mm)

#grid(align: horizon, columns: (9fr, 1fr), gutter: 0.5em,
  [#writing-space(rows: 0)[#grid(columns: (1fr, 1fr), grid.cell(align: left)[자판기는], grid.cell(align: right)[])][#grid(columns: (10fr, 1fr), [#align(right)[때문에 오토마타라고 할 수]], grid.cell(align: right)[다.])]],
  [#box(
      width: grid-park-circle-size,
      height: grid-park-circle-size,
      radius: 50%,
      clip: true,
      image("assets/images/park-vending-machine.jpg", width: 100%, height: 100%, fit: "cover")
  )]
)

#v(4mm)

#directive[만약 누군가 바람에 흔들리는 나무를 보고 '오토마타의 모습이 보인다'고 한다면, 동의할 수 있나요? 어떻게 생각하나요?]

#v(4mm)

#grid(align: horizon, columns: (1fr, 9fr), gutter: 0.5em,
  [#box(
      width: grid-park-circle-size,
      height: grid-park-circle-size,
      radius: 50%,
      clip: true,
      image("assets/images/park-tree.jpg", width: 100%, height: 100%, fit: "cover")
  )],
  [#writing-space(rows: 0)[#grid(columns: (1fr, 1fr), grid.cell(align: left)[바람에 흔들리는 나무는], grid.cell(align: right)[])][#grid(columns: (10fr, 1fr), [#align(right)[때문에 오토마타라고 할 수]], grid.cell(align: right)[다.])]]
)

#pagebreak()

#directive[아래의 글을 읽어보세요.]

#figure(image("assets/images/grass-vending-machine.jpeg", width: 90%))

#text-content[
  어떤 대강 만들어진 자판기를 생각해보자. 이 자판기는 대체로 섬세하지 않게 작동하지만, 매우 싼 값에 이용할 수 있다. 자판기는 50원과 100원 동전을 넣을 수 있고, 투입한 돈이 300원 또는 그 이상일 때 커피나 음료수를 내주고 거스름돈을 거슬러주지 않는다. 이러한 자판기 오토마타에서는 투입되는 액수에 따라 상태가 변한다. 먼저 시작 상태에서는 액수가 0원이며, 50원이 투입되면 50원 상태로 가고, 100원이 투입되면 100원 상태로 간다. 100원 상태에서 50원이 투입되면 150원 상태로 이동하고, 이와 같은 과정을 계속하여 300원이나 그 이상의 액수 상태가 되면 음료수를 출력한다.
]

\

#directive[이 자판기를 흐름도로 표현할 수 있을까요? 어떻게 그려야 할까요? 아래 공간에 그려보세요.]

#gridnote(_rows: 15)

#pagebreak()

#directive[아래의 그림을 보세요.]

#figure(image("assets/images/automata.svg", width: 100%))

앞서 그렸던 흐름도와는 다른 형식의 도표가 있습니다. 자판기의 흐름을 표시하는 또 다른 방법으로, 오토마타를 그릴 수 있습니다. 원 안에는 자판기의 상태를 표시하고, 원과 원 사이를 화살표로 이었습니다. 화살표에는 다음 원(즉, 상태)으로 이동할 수 있는 조건이 적혀있습니다.

\

화살표에 작성된 조건은 우리가 자판기에 동전을 넣어야만 달성될 수 있습니다. 다시 말해, 자판기에 동전을 입력해야만, 자판기의 상태가 변화합니다. 자판기는 다음의 특징을 갖는다고 할 수 있습니다:

#text-content[
  1. 자판기는 동전을 입력받을 수 있다. 
  2. 자판기는 음료수를 출력할 수 있다. 동전이 충분히 입력되지 않으면 음료수 출력을 거부한다.
  3. 자판기는 지금 입력된 동전의 액수를 기록할 수 있는 저장 장치를 가지고 있다. 이 저장 장치의 내용은 동전의 입력에 따라서 변경되거나, 자판기가 읽어낼 수 있다.
  4. 자판기의 상태를 제어할 수 있는 제어 장치를 가지고 있다.
]

\

이것을 더 폭넓은 표현으로 이렇게 표현할 수 있습니다:

#text-content[
  1. 오토마타는 입력 데이터를 읽을 수 있는 기능을 가지고 있다.
  2. 오토마타는 특정한 형태의 출력 기능을 가지고 있다. 또한 수락(accept)이나 기각(reject)을 출력할 수 있다.
  3. 오토마타는 임시 저장 장치를 가질 수 있다. 오토마타는 작동에 따라서 이 내용을 읽거나 변경할 수 있다.
  4. 오토마타는 상태를 제어할 수 있는 제어 장치를 가지고 있다. 제어 상황에 따라 상태가 변화할 수 있다.
]

\

= 무더운 여름, 고장난 선풍기

\

#directive[아래의 글을 읽어보세요.]

#text-content[
  제품 개요
  
  본 제품은 최신 기술이 적용된 고성능 가정용 선풍기입니다. 이 선풍기는 실내 공기 순환을 위해 설계되었으며, 여름철 냉방 효율을 높이고 겨울철 난방 효율을 개선하는 데 도움을 줍니다. 특히 에너지 효율성을 고려하여 설계되었으므로, 장시간 사용해도 전기료 부담이 적습니다.

  \
  
  제품의 기본 구조
  
  선풍기는 크게 세 가지 주요 부품으로 구성되어 있습니다. 첫 번째는 전원을 공급받아 회전을 담당하는 모터부입니다. 두 번째는 모터에 의해 움직이는 날개로, 공기를 이동시키는 핵심 역할을 합니다. 세 번째는 선풍기의 전체 틀을 이루는 본체로서, 안전 그릴, 지지대, 전원 코드 등이 포함됩니다.

  \
  
  작동 원리 및 회전 메커니즘
  
  선풍기는 전원이 인가되면 내부 모터가 활성화되어 회전축을 중심으로 날개를 회전시킵니다. 이 과정은 다음과 같이 진행됩니다. 사용자가 전원 스위치를 누르면 선풍기가 대기 상태에 진입합니다. 이 상태에서 선풍기는 전원 신호를 수신하고 있으며, 초기화 절차를 거치게 됩니다. 초기화가 완료되면 선풍기는 저속 모드로 전환되고, 날개가 천천히 회전하기 시작합니다. 사용자가 원한다면 속도 버튼을 눌러 중속 모드로 변경할 수 있습니다. 중속 모드에서 선풍기는 날개를 더욱 빠르게 회전시키며, 더 많은 공기를 이동시킵니다. 사용자가 다시 속도 버튼을 누르면 고속 모드로 진입합니다. 고속 모드에서는 최대 회전 속도로 작동하여 강력한 바람을 배출합니다. 사용자가 한 번 더 속도 버튼을 누르면 선풍기는 다시 대기 상태로 돌아가며, 최종적으로 전원을 완전히 차단하게 됩니다.

  \
  
  풍량 제어 기능
  
  선풍기에는 세 단계의 풍량 조절 기능이 탑재되어 있습니다. 저속 단계에서는 약한 바람을 배출하여 조용한 환경에서의 사용에 적합합니다. 중속 단계는 일반적인 실내 환경에서 적절한 공기 순환을 제공합니다. 고속 단계는 더운 날씨나 큰 공간에서의 빠른 냉방이 필요할 때 사용합니다. 각 단계 간의 전환은 버튼 하나로 간단하게 조작할 수 있으며, 현재 작동 상태는 본체의 표시 LED로 확인할 수 있습니다.

  \
  
  타이머 기능
  
  본 선풍기는 편리한 타이머 기능을 제공합니다. 타이머 버튼을 누르면 선풍기는 타이머 설정 모드로 진입합니다. 이 상태에서 선풍기는 추가 입력을 대기 중입니다. 사용자가 시간을 설정하면 선풍기는 설정된 시간을 메모리에 저장합니다. 저장이 완료되면 선풍기는 정상 작동 상태로 돌아갑니다. 설정된 시간이 경과하면 선풍기는 타이머 만료 신호를 감지하고 종료 모드로 전환됩니다. 종료 모드에서는 회전을 천천히 감속시킨 후 완전히 정지합니다. 이 과정은 약 30초간 진행되어 안전한 종료를 보장합니다.

  \
  
  진동 감지 및 안전 기능
  
  선풍기 내부에는 진동 센서가 장착되어 있습니다. 선풍기가 정상적으로 작동 중일 때 진동 센서는 지정된 범위 내의 진동만을 감지합니다. 만약 비정상적인 진동이 감지되면 선풍기는 즉시 안전 모드로 진입합니다. 안전 모드 진입 시 선풍기는 회전을 멈추고 경고 신호를 발생시킵니다. 경고 신호가 발생하면 사용자는 선풍기의 이상 상태를 인식하고 적절한 조치를 취할 수 있습니다. 경고 신호 후 사용자가 아무런 조치를 하지 않으면 선풍기는 계속 안전 모드 상태를 유지합니다.

  \
  
  온도 모니터링
  
  선풍기의 모터 부근에는 온도 센서가 설치되어 있습니다. 이 센서는 모터의 온도를 지속적으로 감시합니다. 모터 온도가 정상 범위 내에 있을 때는 선풍기가 평소처럼 작동합니다. 그러나 모터 온도가 허용 범위를 초과하면 선풍기는 온도 상승 상태를 감지합니다. 온도 상승을 감지한 선풍기는 회전 속도를 자동으로 낮춥니다. 회전 속도 저하 후에도 온도가 계속 상승하면 선풍기는 냉각 상태로 진입합니다. 냉각 상태에서는 선풍기가 모든 회전을 멈추고 내부 열을 식히기 위해 대기합니다. 충분한 시간이 경과하여 온도가 정상 범위로 돌아오면 선풍기는 다시 작동을 개시합니다.

  \
  
  예방적 유지보수 및 주의사항
  
  선풍기를 안전하고 효율적으로 사용하기 위해서는 정기적인 관리가 필수적입니다. 사용 전에 반드시 선풍기가 안정적인 위치에 설치되어 있는지 확인하십시오. 불안정한 설치는 선풍기의 떨림을 유발할 수 있습니다. 또한 선풍기 주변 50센티미터 이내에 장애물이 없는지 확인하십시오. 장애물이 있으면 공기 흐름이 방해받아 선풍기의 효율이 감소합니다. 매주 한 번씩 외부 그릴과 날개를 부드러운 천으로 닦아 먼지를 제거하십시오. 먼지가 쌓이면 모터의 부하가 증가하여 고장의 원인이 될 수 있습니다.
  
  선풍기를 오래 사용할 계획이라면 일주일에 한 번 정도 몇 시간씩 외출할 때를 이용하여 선풍기를 휴식 상태로 두십시오. 휴식 상태에서는 선풍기가 전원을 받지 않아 내부 부품의 피로를 줄일 수 있습니다. 만약 여러 날 동안 사용하지 않을 계획이라면, 먼저 선풍기를 완전히 종료하고 전원 플러그를 빼십시오. 전원이 차단된 상태에서 선풍기는 대기 상태를 유지하다가 외부 자극이 없으면 자동으로 슬립 모드로 진입합니다. 슬립 모드에서는 선풍기의 모든 시스템이 최소 전력으로 작동하여 에너지 소비를 거의 하지 않습니다.

  \
  
  계절별 사용 팁
  
  여름철에는 선풍기를 주로 고속 모드에서 사용하게 될 것입니다. 이 경우 모터의 부하가 크므로 매일 2시간 정도는 휴식 시간을 가지도록 하십시오. 겨울철에는 에어컨이나 난방기구와 함께 저속 모드로 사용하면 실내 공기를 골고루 순환시켜 난방 효율을 개선할 수 있습니다. 봄이나 가을과 같은 중간 계절에는 중속 모드가 가장 적절합니다.

  \
  
  문제 해결 가이드
  
  선풍기가 제대로 작동하지 않는 경우, 먼저 전원 플러그가 제대로 연결되어 있는지 확인하십시오. 플러그 연결이 정상이면 선풍기를 전원에서 분리한 후 30초간 기다렸다가 다시 연결하십시오. 이 과정을 통해 선풍기의 내부 회로가 초기화됩니다. 초기화 후에도 작동하지 않으면 제조사에 문의하시기 바랍니다.
  
  본 선풍기를 올바르게 사용하시면 오랫동안 쾌적한 실내 환경을 유지할 수 있습니다.
]

\

#directive[선풍기의 동작을 흐름도로 그려보세요.]

#gridnote(_rows: 34)

#pagebreak()

#directive[선풍기의 상태와 입출력은 무엇인가요? 선풍기를 오토마타로 다시 한 번 그려보세요.]

\

#gridnote(_rows: 45)

#pagebreak()

#directive[아래의 글을 읽어보세요.]

#text-content[
  이 무더운 여름날, 아니 이게 무슨 봉변이란 말인가. 나는 선풍기 앞에 서 있다. 그것은 여전히 거기 있다. 검은 그릴 사이로 날개들이 보인다. 하지만 움직이지 않는다. 왜 움직이지 않는가. 나는 버튼을 다시 누른다. 아무것도 일어나지 않는다. 전원 코드는 콘센트에 꽂혀 있다. 나는 그것을 확인했다. 콘센트에서 플러그를 빼내고 다시 꽂는다. 콘센트는 살아 있다. 다른 기구들도 작동한다. 그런데 왜 이놈만?

  \
  
  나는 버튼을 더 세게 누른다. 손가락이 아프다. 하지만 선풍기는 여전히 침묵한다. 그 침묵은 압도적이다. 이 방 안에 있는 모든 열기가 그 침묵 속으로 흘러들어가는 것 같다. 나는 숨이 막힌다. 언제부터였을까. 어제는 분명히 작동했다. 그 부드러운 소음, 그 일정한 회전. 나는 그것을 당연한 것처럼 여겼다. 밤새 그것의 바람을 느끼며 나는 잠들었다. 그리고 오늘 아침, 그것은 나를 배반했다.

  \
  
  나는 선풍기를 들었다 놓기를 반복한다. 무언가 흐릿한 것이 가득 보인다. 그릴 사이에 뭔가 있는 것 같다. 하지만 정확히 무엇인지는 알 수 없다. 빛이 제대로 들어오지 않는다. 그것은 마치 선풍기가 나로부터 무언가를 숨기고 있는 것 같다. 나를 제외하고 누군가와 비밀을 나누고 있는 듯한 느낌이 든다. 나는 설명서를 찾아본다. 설명서는 여전히 새것 같다. 나는 그것을 읽는다. "만약 선풍기가 제대로 작동하지 않는 경우, 먼저 전원 플러그가 제대로 연결되어 있는지 확인하십시오." 전원 플러그는 연결되어 있다. 나는 이미 확인했다. 설명서는 더 이상 말해주지 않는다.

  \
  
  나는 다시 바닥에 앉는다. 선풍기는 여전히 거기 있다. 우리는 서로를 바라본다. 아니다, 나는 그것을 바라보고 있다. 그것은 나를 바라보지 않는다. 그것은 아무것도 바라보지 않는다. 그것은 단지 거기 있을 뿐이다. 불가해한 존재로서. 혹시 내가 뭔가 잘못했을까. 내가 그것을 너무 자주 사용했을까. 아니면 너무 오래 사용했을까. 
  
  \
  
  시간이 흐른다. 시간은 항상 흐른다. 선풍기는 여전히 움직이지 않는다. 나는 더 이상 버튼을 누르지 않는다. 그것도 무의미한 것 같다. 모든 것이 무의미한 것 같다. 이 열기 속에서, 이 침묵 속에서. 단지 남겨져 있을 뿐이다. 설명도 없이.
]

\

#directive[글쓴이는 어떤 상황에 놓여있나요?]

#writing-space()

\

#directive[글쓴이는 상황을 해결하기 위해 무엇을 해 보았나요?]

#writing-space(rows: 2)

#pagebreak()

#directive[설명서에 근거했을 때, 선풍기는 어째서 작동하지 않았을까요?]

#free-space(height: 30mm)

\

#directive[그렇다면 글쓴이는 어떻게 하면 선풍기를 사용할 수 있을까요?]

#free-space(height: 30mm)

#place(bottom + center, dy: 7mm)[#image("assets/images/fan-in-room.jpeg", width: 93%)]

#pagebreak()

= 기술 아이디어 제안하기

\

#directive[아래의 지문을 읽어보세요.]

#text-content[
  페달 오조작 사고 줄인다...운전자 실수 방지 기술개발 사업 추진
  
  \
  
  국토교통부가 운전자의 페달 오조작으로 인한 교통사고를 줄이기 위해 정부 주도 기술 개발에 나섰다. 국토교통과학기술진흥원을 통해 '운전자 페달 오조작 방지 기술개발 사업'을 진행 중이며, 현재 참여 기관을 모집하고 있다.

  \
  
  고령층 사고 비중 심각
  
  페달 오조작 사고는 운전자가 가속 페달을 브레이크로 착각해 발생하는 사고를 뜻한다. 최근 고령 운전자의 증가에 따라 이 같은 사고가 빠르게 증가하고 있는 상황이다.

  지난해 발생한 페달 오조작 사고는 연간 100건을 넘었으며, 이 중 약 70퍼센트인 10건 중 7건이 60대 이상의 고령 운전자에 의해 발생한 것으로 집계됐다. 전문가들은 신체 반응 속도 저하와 판단력 감소가 주요 원인으로 지목하고 있다.

  \
    
  정부는 사고 기록장치 데이터 분석을 이용해 오조작 여부를 판단하는 시스템 개발을 추진한다. 정부는 이번 기술 개발을 통해 페달 오조작으로 인한 사고를 현재의 절반 이하로 줄이는 것을 목표로 하고 있다. 이에 대해 한 관계자는 "고령 사회 진입에 따른 교통안전 대책이 시급한 만큼, 첨단 기술을 통해 예방 가능한 사고를 줄이는 데 집중하겠다"고 밝혔다.
]

\

#directive[위의 '페달 오조작 사고'를 막기 위해 기술을 개발한다면, 어떤 기술을 설계할 수 있을까요? 간단하게 메모해보세요.]

#free-space(height: 34mm)

#pagebreak()

#directive[앞에서 메모한 내용을 토대로 자신이 설계한 기술에 대해 흐름도를 그려보세요.]

#gridnote(_rows: 21)

\

#directive[앞에서 메모한 내용을 토대로 자신이 설계한 기술에 대해 오토마타를 그려보세요.]

#gridnote(_rows: 21)

#pagebreak()

#directive[앞에서 메모한 아이디어와, 그렸던 흐름도와 오토마타에 근거해서 기술개발 제안서를 간단한 문장 중심으로 작성해보세요. 제안서에는 다음의 내용이 들어있어야 합니다:]

1. 기술 개발의 필요성
2. 기술 개발의 목표
3. 개발할 기술의 핵심 아이디어
4. 개발할 기술의 시스템 구조
5. 개발할 기술의 알고리즘과 프로그램 흐름
6. 기대 효과

\

#writing-space(rows: 0)[\#1 ][\ ][\ ][\#2 ][\ ][\ ][\#3 ][\ ][\ ][\#4 ][\ ][\ ][\#5 ][\ ][\ ]

#pagebreak()

#directive[앞에서 작성한 문장들을 이용해서, 기술개발 제안서를 작성해보세요.]

\

#wongoji_grid(rows: 22)

#pagebreak()

#wongoji_grid(rows: 24)

#pagebreak()

#wongoji_grid(rows: 24)
