# NordShield VPN — Flutter приложение

## 📱 Что это
Бесплатное VPN приложение для Android.
Использует серверы VPN Gate (университет Цукуба, Япония) — 7000+ бесплатных серверов по всему миру.

---

## 🛠 Установка за 5 шагов

### Шаг 1 — Установи Flutter
1. Зайди на https://flutter.dev/docs/get-started/install
2. Выбери Windows (или macOS/Linux)
3. Скачай Flutter SDK, распакуй в папку C:\flutter
4. Добавь C:\flutter\bin в PATH (переменные среды)
5. Открой командную строку, напиши: `flutter doctor`
   Должно показать зелёные галочки

### Шаг 2 — Установи Android Studio
1. Скачай с https://developer.android.com/studio
2. Установи, при установке выбери "Android Virtual Device"
3. В Android Studio: File → Settings → Plugins → ищи "Flutter" → Install
4. Перезапусти Android Studio

### Шаг 3 — Скопируй проект
1. Создай папку, например C:\Projects\nordshield_vpn
2. Скопируй ВСЕ файлы из архива в эту папку
   Структура должна быть такой:
   ```
   nordshield_vpn/
   ├── lib/
   │   ├── main.dart
   │   ├── models/
   │   │   └── vpn_server.dart
   │   ├── services/
   │   │   └── vpngate_service.dart
   │   ├── screens/
   │   │   └── home_screen.dart
   │   └── widgets/
   │       ├── connect_button.dart
   │       ├── server_card.dart
   │       └── stats_row.dart
   ├── android/
   │   └── app/src/main/AndroidManifest.xml
   └── pubspec.yaml
   ```

### Шаг 4 — Запусти проект
Открой терминал в папке проекта и выполни:
```bash
flutter pub get
flutter run
```

Или открой папку в Android Studio → нажми зелёный треугольник ▶

### Шаг 5 — Собери APK для телефона
```bash
flutter build apk --release
```
APK будет в: `build/app/outputs/flutter-apk/app-release.apk`
Перекинь на телефон и установи (нужно включить "установку из неизвестных источников").

---

## 📡 Как работает
- При запуске загружает список серверов с VPN Gate API
- Если нет интернета — показывает встроенный список из 12 серверов
- Серверы отсортированы по пингу (самые быстрые вверху)
- Можно искать по стране

## ⚠ Важно
Эта версия — интерфейс с симуляцией подключения.
Для реального VPN-туннеля нужно добавить пакет `openvpn_flutter`:
1. Добавь в pubspec.yaml: `openvpn_flutter: ^1.3.3`
2. Получи OpenVPN конфиг с VPN Gate (кнопка "OpenVPN Config" на сайте)
3. Используй `OpenVPN.connect(config, ...)` для подключения

## 🆓 Бесплатные серверы
VPN Gate API: https://www.vpngate.net/api/iphone/
Возвращает CSV список всех доступных серверов каждые несколько минут.

---
Создано с Claude — claude.ai
