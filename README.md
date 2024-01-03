# UniverseToday
매일 업데이트 되는 천문학 정보를 확인하는 앱
<p align="center">
  <img src="https://github.com/mayeonn/UniverseToday/assets/82192918/4ba7f051-4e39-40fc-a496-47a313310718">
</p>

## 📋 Summary
처음으로 Storyboard 없이 UIKit를 코드로 구현한 프로젝트입니다. 실시간으로 업데이트 되는 천문학 정보(오늘의 천문학 사진, 최근 우주발사체 정보, 최근 천문학 뉴스)를 확인할 수 있으며 홈 화면에서 보고싶은 카테고리를 구성하고 편집할 수 있습니다.

## ✨ Key Functions
**Open API**</br>
&emsp;오늘의 천문학 사진, 최근 우주발사체 정보, 최근 천문학 뉴스를 실시간으로 업데이트
**카테고리 수정**</br>
&emsp;홈 화면에서 확인할 카테고리를 추가/삭제/순서 변경 가능</br>
&emsp;UserDefaults에 유저의 카테고리 설정을 저장하여 앱을 다시 실행해도 유지됨
**뉴스 웹뷰**</br>
&emsp;뉴스를 앱 내에서 웹뷰(WKWebView)로 확인할 수 있음

## 🏃 Learned
- UIKit를 코드로 구현하고, Snapkit을 사용해 Auto Layout을 적용할 수 있게 됨
- 서버에서 가져와 동적인 크기를 가지는 이미지를 UITableViewCell에 비율을 유지하며 넣는 방법을 고안하면서 Reactive Programming과 Swift Concurrency에 대해 이해하게 됨
- UserDefaults를 사용한 영구 데이터 저장
- Delegate Pattern, Notification Center를 사용한 비동기 이벤트 처리
