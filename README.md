# 나만의 TV (My TV)

[나만의 라디오](https://ssangku2-tech.github.io/my-radio/)의 짝꿍. 한국 TV와 해외 영어 방송을 한 화면에서 누르면 바로 보는 설치형 웹앱(PWA)입니다.
**영어 방송은 화면 아래에 실시간 2줄 자막**이 나옵니다 (영어만, 또는 영어 1줄 + 한글 번역 1줄).

## 채널

- **한국**: KBS 1TV·2TV·뉴스24·WORLD·Story·Kids, EBS 1TV·2TV·English·Plus1, KTV 국민방송, 국악TV, TBS TV
- **해외 (영어 자막)**: Arirang TV, NBC News, CBS News, LiveNOW from FOX, Scripps News, CBC News, GB News, Al Jazeera English, DW English, France 24 English, NHK WORLD-JAPAN, CNA, TRT World, CGTN, Africanews
- **전 세계 찾기**: iptv-org 공개 목록의 인터넷 TV 채널을 이름으로 찾아 보고 내 채널에 추가

## 기능

- 채널 카드 한 번 누르면 바로 켜짐, 채널 바꿀 땐 브라운관 지지직과 채널 번호 표시
- 영어 자막: 끔 / 영어 / 영어+한글 (C 키로 바꿈), 전체 화면에서도 자막이 같이 커짐
- ▲▼ 채널 이동, 숫자키로 채널 번호 바로 가기, 즐겨찾기(★)는 목록 맨 앞
- 황동 볼륨 노브(돌리기·휠·−/+), 누르면 음소거
- 전체 화면(버튼·더블클릭·Enter), 보는 동안 화면 꺼짐 막기
- 취침 타이머(마지막 30초 소리가 서서히 작아짐), 끄기 버튼
- PWA: PC·폰 홈 화면에 앱으로 설치

## 자막은 이렇게 만듭니다

```
방송(HLS) ─▶ hls.js ─┬─▶ 화면 재생 (실제 화면보다 수십 초 앞서 미리 받아 둠)
                     └─▶ 미리 받은 소리 조각을 가로채 16kHz WAV로 변환
                          ─▶ Cloudflare 워커 /transcribe (Whisper) ─▶ 단어 + 말한 시각
화면 재생 시각이 그 단어의 시각에 오면 한 단어씩 2줄 자막에 채움 → 말소리와 자막이 맞음
'영어+한글'이면 문장이 끝날 때마다 워커 /translate 로 한국어 번역
```

받아쓰기·번역 워커는 나만의 라디오와 같은 것(`my-radio.ssangku2.workers.dev`, 코드는 my-radio 저장소 `cloudflare/`)을 씁니다.

## 파일

| 파일 | 역할 |
| --- | --- |
| `index.html` | 앱 전체(화면·채널 목록·재생·자막) |
| `manifest.webmanifest`, `sw.js`, `icons/` | PWA 설치 정보, 오프라인 캐시, 앱 아이콘 |

방송의 권리는 각 방송사에 있으며, 이 앱은 방송사가 공개한 웹 재생 주소를 이어 줄 뿐입니다. 방송사가 주소를 바꾸거나 지역을 막으면 일부 채널이 안 나올 수 있습니다.
