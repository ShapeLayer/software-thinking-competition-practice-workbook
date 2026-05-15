#import "rx-note.typ": rx_style, term
#import "wongoji.typ": wongoji_grid


#show: rx_style.with(
  title: "소프트웨어・데이터",
  subtitle: "#1 흐름도",
  primary-color: rgb("#9151B8")
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

#align(center + horizon)[
  #image("assets/images/long-tailed-tit.jpeg", width: 75%)
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

#pagebreak()

= 순서도 (Flowchart)

\

#directive[순서도를 사용하면 어떤 프로그램이나 행동을 알기 쉽게 그림으로 설명할 수 있습니다. 순서도를 이해해봅시다.]

\


#let symbol-size = 60pt

#table(
  columns: (auto, auto, 1fr, 1fr),
  align: center + horizon,
  inset: 1em,
  [기호], [역할], [상세], [예시],
  [
    #image("assets/images/flowchart-start.png", width: symbol-size)
  ], [시작/종료], [어떤 프로그램이나 흐름의 시작/끝], [
    램프가 안 켜진다.\
    이메일 실행.
  ],
  [
    #image("assets/images/flowchart-action.png", width: symbol-size)
  ], [행동], [수행할 행동, 처리], [플러그에 연결한다.],
  [
    #image("assets/images/flowchart-inputoutput.png", width: symbol-size)
  ], [입력/출력], [외부에서 정보를 가져옴 / 외부로 정보를 보냄], [
    비밀번호 재설정.\
    초대할 대상 이메일 입력.
  ],
  [
    #image("assets/images/flowchart-condition.png", width: symbol-size)
  ], [조건(분기)], [다음 단계가 여러 상황으로 갈라질 때, 갈라지는 조건], [
    돈이 부족한가?\
    정보가 유효함.
  ],
  [
    #image("assets/images/arrow.png", width: symbol-size)
  ], [(흐름)], [프로그램의 흐름], []
)

\

#grid(
  columns: 2,
  inset: 10pt,
  align: center + horizon,
  figure(image("assets/images/flowchart-lamp.png", width: 55mm), caption: [램프가 고장났을 때 순서도]),
  figure(image("assets/images/flowchart-wd40.png"), caption: [움직여야 할 것이 움직이지 않는가?])
)

#pagebreak()

= 자판기

#directive[아래의 지문을 읽고 순서도를 그려봅시다.]

#text-content[
  여름날, 학교 복도에 있던 자동 판매기를 이용해 보았다. 동전을 넣고, 내가 마시고 싶은 음료 버튼을 누르면 잠시 후 차가운 음료가 아래쪽 투입구에서 떨어져 나왔다. 겉으로 보기엔 단순해 보이지만, 자판기 안에는 여러 단계가 숨겨져 있다. 먼저, 투입된 동전이나 지폐는 센서가 무게와 전자기적 특성을 검사해 위조품이 아닌지 확인한다. 그 다음, 기계는 투입된 금액을 음료 가격과 비교해 충분하면 버튼을 활성화한다. 사용자가 버튼을 누르면 모터가 작동해 저장된 음료를 회전식 트레이나 스프링 장치로 옮겨 주어진 위치로 내려보낸다. 음료가 정상적으로 배출되면 센서가 이를 감지하고, 남은 금액이 있으면 거스름돈을 계산해 동전 반환구로 전송한다. 이렇게 여러 센서와 제어 장치가 협력해 짧은 시간 안에 정확히 동작한다는 점이 바로 자동 판매기가 우리 생활을 편리하게 만드는 과학적 원리이다.
]

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

#gridnote(_rows:31)

#pagebreak()

= 한글은 디지털에 최적화된 문자

#directive[아래의 지문을 읽어봅시다.]

#text-content[
  우리는 한글을 매우 과학적이고 편리한 문자라고 생각하며 사용합니다. 하지만 우리가 매일 사용하는 스마트폰이나 컴퓨터 서비스를 만드는 IT 개발자들에게 한글은 정복하기 까다로운 대상이기도 합니다. 한글이 가진 독특하고 우수한 특징들이 컴퓨터 세계에서는 복잡한 계산과 처리 과정을 필요로 하기 때문입니다.

  가장 먼저 '조사'의 문제가 있습니다. 우리말은 단어 뒤에 '가', '를', '에서'처럼 다양한 조사가 붙습니다. 컴퓨터가 문장의 의미를 분석하거나 검색 결과를 보여주려면 단어에서 조사를 정확히 떼어내야 하는데, 이는 영어보다 훨씬 어려운 작업입니다. 또한 한글은 구조상 신조어나 줄임말을 만들기 매우 쉽습니다. 사람들이 새로운 말을 만들어낼 때마다 컴퓨터가 이를 같은 뜻으로 이해하도록 가르치는 데 많은 노력이 들어갑니다.
  
  기술적인 환경에서도 한글만의 특징이 나타납니다. 영어는 알파벳 26자만 디자인하면 되지만, 한글은 자음과 모음이 결합하여 만들어지는 글자가 무려 1만 자가 넘습니다. 자주 사용하는 글자만 골라도 수천 자를 일일이 디자인해야 하므로 폰트 파일의 용량이 커지고 웹페이지 속도에도 영향을 줍니다. 우리가 글자를 입력할 때 사용하는 '입력기(IME)' 또한 한글의 조합 원리를 따르기 때문에, 글로벌 기업들이 운영체제를 업데이트할 때마다 한글 입력이 어색해지는 버그가 생기기도 합니다.
  
  특히 많은 사람이 편리하게 사용하는 '초성 검색' 기능에는 개발자들의 정교한 로직이 숨어 있습니다. 컴퓨터는 한글 한 글자를 자음과 모음이 합쳐진 하나의 덩어리로 인식하기 때문에, 특정 단어에서 자음만 바로 골라낼 수 없습니다. 그래서 개발자들은 어떤 문자가 '가'부터 '깋' 사이에 있다면 그 초성을 'ㄱ'으로 추론하는 식의 수식을 만듭니다. 글자마다 부여된 고유의 숫자 값(유니코드)을 계산하여 초성 데이터를 분리해 내는 것입니다.
  
  데이터가 아주 많을 때는 검색할 때마다 초성을 계산하면 속도가 느려지므로, 미리 초성 데이터를 따로 저장해 두는 지혜를 발휘하기도 합니다. 최근에는 이러한 복잡한 과정을 도와주는 전용 도구(라이브러리)들이 개발되어, 우리가 '사'와 'ㄱ'만 입력해도 '사과'를 정확히 추천해 주는 친절한 서비스를 누릴 수 있게 되었습니다.
]

#text-content[
  컴퓨터는 우리가 보는 '가'나 '강' 같은 글자를 자음과 모음이 결합된 형태가 아니라, 각각에 부여된 '고유한 숫자 값(유니코드)'으로 기억합니다. 예를 들어 한글이 시작되는 서두인 '가'는 '44032'라는 숫자로 약속되어 있고, 그다음 글자인 '각'은 '44033'이 됩니다. 이런 식으로 한글의 모든 조합은 규칙적인 숫자 순서대로 배열되어 있습니다. 개발자들은 바로 이 '숫자의 규칙성'을 이용해 초성을 분리해 냅니다. 한글은 초성 순서대로 일정한 간격을 두고 배치되어 있는데, '가'부터 '나'가 나오기 직전까지의 모든 글자는 초성이 'ㄱ'이고, '나'부터 '다' 직전까지의 글자는 모두 초성이 'ㄴ'이 되는 식입니다. 구체적으로는 '가'부터 '깋'까지 총 588개의 글자가 하나의 초성(ㄱ) 묶음을 이룹니다. 따라서 어떤 글자의 초성을 알고 싶다면, 그 글자의 고유 숫자에서 한글 시작 번호인 44032를 뺀 뒤, 이를 588로 나누는 수학적 계산을 거치게 됩니다. 이때 나오는 결과 값에 따라 0이면 'ㄱ', 1이면 'ㄲ', 2이면 'ㄴ'과 같이 미리 정해둔 초성 목록에서 해당 자음을 매칭하여 가져오는 것입니다. 우리가 검색창에 단순히 'ㄱㄴ'이라고만 쳐도 컴퓨터가 순식간에 '강남'을 찾아낼 수 있는 이유는, 이처럼 모든 한글을 숫자로 바꾸어 그 안에 숨겨진 순서를 빠르게 계산해 내는 수학적 로직이 작동하고 있기 때문입니다.
]

#pagebreak()

#align(center)[#image("assets/images/king-sejong.jpeg", width: 70%)]

#directive[지문의 저자가 설명하고자 하는 내용은 무엇인가요? 도식으로 표현해봅시다.]

#gridnote(
  _rows: 30
)

#pagebreak()

#directive[초성 검색은 어떻게 구현할 수 있을까요? 과정을 흐름도로 그려봅시다.]

#gridnote(
  _rows: 47
)

#pagebreak()

= 2단계 인증

#text-content[
  우리 기관 포털 보안이 한층 강화된다. 정보화본부는 최근 기관을 겨냥한 사이버 위협에 대응하기 위해 오는 16일 기관 전 구성원 대상 포털 2단계 인증 의무화를 추진한다. 앞으로 학내 구성원들은 포털 로그인 시 △모바일 어플리케이션 (AnyAUTH) △QR코드 △OTP(일회용 비밀번호) 중 하나를 반드시 거쳐야 한다. 학생들 사이에서는 보안 강화의 필요성에는 공감하지만, 반복되는 인증의 번거로움과 특정 보안 솔루션에 대한 불신을 우려하는 목소리도 있었다.

  정보화본부 관계자는 "타 기관에 대한 공격 시도가 빈번해지면서 국정감사 등에서 기관 정보보안 강화에 대한 강력한 지적이 있었다"며 "특히 교육부의 '정보 보호 수준 진단' 평가 항목에 학생 대상 2차 인증 도입 여부가 필수로 포함되어 보안을 강화하는 상황이다"고 말했다.
  
  2차 인증을 이용해본 ㄱ씨는 "2차 인증이나 OTP를 자주 사용하는 사람이라면 크게 불편하지는 않을 것 같다"면서도 "로그인 할 때마다 거쳐야 하는 번거로움은 분명히 있다"고 솔직한 심정을 전했다. 정보화본부는 이러한 우려를 인지하고 편의성 보완책을 마련했다. 기존과 동일하게 포털 아이디와 비밀번호를 입력하고 OTP 인증 후 '신뢰할 수 있는 기기'로 등록하면 1개월간 추가 인증이 필요 없이 로그인할 수 있다.
  
  ㄴ씨는 "보안을 위해 생소한 앱 설치를 강제하는 것보다 기업들이 주도하는 글로벌 표준인 '패스키(Passkey)'를 도입하면 좋겠다"며 "브라우저 내에서 지문 인식을 하는 등의 방법이라면 더욱 안전할 것이다"고 지적했다.
  
  현재 우리 기관 포털은 시스템의 정착을 위해 '시범운영' 단계를 거치고 있으며, 이 기간에는 기존 방식대로 접속할 수 있는 '아이디(임시)' 탭이 유지된다. 오는 16일 정식 도입 이후에는 기존 로그인 방식을 이용할 수 없다.
]

#directive[지문의 저자가 설명하고자 하는 내용은 무엇인가요? 도식으로 표현해봅시다.]

#gridnote(
  _rows: 20
)
