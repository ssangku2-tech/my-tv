# 나만의 TV (My TV)

[나만의 라디오](https://ssangku2-tech.github.io/my-radio/)의 짝꿍. 검은 유리와 보라·청록 빛의 미래형 화면에서 한국 TV와 해외 영어 방송을 한 화면에서 누르면 바로 보는 설치형 웹앱(PWA)입니다.
**영어 방송('AI 자막' 표시)은 화면 아래에 실시간 2줄 자막**이 나옵니다 (영어만, 또는 영어 1줄 + 한글 번역 1줄).
자막은 배경 상자 없이 글자 외곽 그림자로 읽히고, 방송 자막처럼 아래에서 위로 한 줄씩 부드럽게 올라가며 새 단어는 스며들듯 나타납니다.

## 채널

- **한국**: KBS 1TV·2TV·뉴스24·WORLD·Story·Kids, EBS 1TV·2TV·English·Plus1, KTV 국민방송, 국악TV, TBS TV
- **해외 (영어 자막)**: Arirang TV, NBC News, CBS News, LiveNOW from FOX, Scripps News, CBC News, GB News, Al Jazeera English, DW English, France 24 English, NHK WORLD-JAPAN, CNA, TRT World, CGTN, Africanews
- **영화 (영어 자막)**: AMC Thrillers, MovieSphere, Hallmark Movies & More, Scares by Shudder, OuterSphere, Charge!, Gravitas Movies, 24 Hour Free Movies, Maverick Black Cinema, GREAT! movies
- **스포츠 (영어 자막)**: NBC Sports NOW, Fox Sports News, FIFA+, PGA Tour, Tennis Channel, Eurovision Sport, Stadium, talkSPORT, Rally TV, Monster Jam (모두 광고가 붙는 무료 공식 채널, 큰 경기 생중계는 없음)
- **다큐멘터리 (영어 자막)**: BBC Earth, Documentary+, MagellanTV Now, NatureTime, WildEarth, INWILD, Love The Planet, WaterBear, Adventure Earth, Danger TV, CNA Originals, CGTN Documentary, Wedo Big Stories, Get.factual
- **전 세계 찾기**: iptv-org 공개 목록의 인터넷 TV 채널을 이름으로 찾아 보고 내 채널에 추가

## 기능

- 채널 타일 한 번 누르면 바로 켜짐, 채널 바꿀 땐 빛 고리와 채널 번호 표시
- 영어 자막: 끔 / 영어 / 영어+한글 (C 키로 바꿈), 전체 화면에서도 자막이 같이 커짐
- ⌃⌄ 채널 이동, 숫자키로 채널 번호 바로 가기, 세계 채널 찾기에서 ＋한 채널은 '내 채널' 분류에
- 빛 고리 볼륨 다이얼(돌리기·휠·−/+), 가운데 누르면 음소거
- 전체 화면(버튼·두 번 톡·Enter): 폰을 가로로 돌리면 자동으로 화면 가득, 전체 화면에서 화면을 톡 치면 채널 ⌃⌄·닫기 버튼, 아이폰도 자막 유지
- 보는 동안 화면 꺼짐 막기
- 취침 타이머(마지막 30초 소리가 서서히 작아짐), 끄기 버튼
- PWA: PC·폰 홈 화면에 앱으로 설치
- **PC 화면**: 폰에서 고른 채널을 집 PC 모니터에 화면 가득 (자막도 PC에서), 폰은 리모컨

## 자막은 이렇게 만듭니다

```
방송(HLS) ─▶ hls.js ─┬─▶ 화면 재생 (실제 화면보다 수십 초 앞서 미리 받아 둠)
                     └─▶ 미리 받은 소리 조각을 가로채 16kHz WAV로 변환
                          ─▶ Cloudflare 워커 /transcribe (Whisper) ─▶ 단어 + 말한 시각
화면 재생 시각이 그 단어의 시각에 오면 한 단어씩 2줄 자막에 채움 → 말소리와 자막이 맞음
'영어+한글'이면 문장이 끝날 때마다 워커 /translate 로 한국어 번역
```

받아쓰기·번역 워커는 나만의 라디오와 같은 것(`my-radio.ssangku2.workers.dev`, 코드는 my-radio 저장소 `cloudflare/`)을 씁니다.

## PC 화면으로 보기 (폰 → 집 PC 모니터)

```
폰 앱 ──https──▶ ntfy.sh (<코드>-tv) ──▶ PC의 'PC TV' 창 (이 앱을 ?screen 으로 연 Edge 창)
   ◀──────────── ntfy.sh (<코드>-tv-st) ◀── 재생 상태
```

- 연결 코드는 나만의 라디오 'PC 스피커'와 같은 코드(대시보드 ntfy 채널 이름)입니다. 같은 주소(github.io)라서
  폰에서 라디오를 연결해 두었으면 TV도 자동으로 연결됩니다. 아니면 `…/my-tv/#pc=<코드>` 링크로 한 번 엽니다.
- PC에서는 `pc/pc-tv.vbs`의 `CODE`에 코드를 넣고 더블클릭하면 'PC TV' 창이 열립니다 (코드는 저장소에 넣지 않음).
- 노트4 서버는 거치지 않습니다. PC TV로 보낼 때 라디오가 PC 스피커로 나오고 있으면 꺼서 소리가 겹치지 않게 합니다.
- 상태는 바뀔 때만 보냅니다 (ntfy.sh 무료 사용량 하루 제한 때문에 주기 보고 없음).

## 파일

| 파일 | 역할 |
| --- | --- |
| `index.html` | 앱 전체(화면·채널 목록·재생·자막) |
| `manifest.webmanifest`, `sw.js`, `icons/` | PWA 설치 정보, 오프라인 캐시, 앱 아이콘 |
| `pc/pc-tv.vbs` | PC에서 'PC TV' 창을 여는 실행 파일 (코드를 넣어 씀) |

방송의 권리는 각 방송사에 있으며, 이 앱은 방송사가 공개한 웹 재생 주소를 이어 줄 뿐입니다. 방송사가 주소를 바꾸거나 지역을 막으면 일부 채널이 안 나올 수 있습니다.
