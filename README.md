# Flutter Firebase Email & Password Login

## UI 생성

## Firebase 연결
[Android]
google-service.json 다운로드
<img src='assets/1.png'>

Firebase 초기화
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 비동기 실행을 위한 코드
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(const MyApp());
}
```

## Authentication 작업

## 각종 예외 처리