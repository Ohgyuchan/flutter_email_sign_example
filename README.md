# Flutter Firebase Email & Password Login Example

> 필요한 패키지  
> 설치 방법  
> `pubspec.yaml` 에 copy & paste 후 `flutter pub get` 명령어 실행
> ```yaml
> get: ^4.6.1
> firebase_auth: ^3.3.5
> cloud_firestore: ^3.1.6
> firebase_core: ^1.11.0
> ```
> `terminal` 에 아래 명령어 입력
> ```shell
> $ flutter pub add get
> $ flutter pub add firebase_auth
> $ flutter pub add cloud_firestore
> $ flutter pub add firebase_core
> ```
## 1. UI 생성

## 2. Firebase 연결
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

## 3. Authentication 작업

## 4. 각종 예외 처리

## 5. 이메일 인증 처리