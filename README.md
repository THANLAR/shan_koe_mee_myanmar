
# 🃏 Shan Koe Mee Myanmar

A beautifully crafted Flutter implementation of the beloved traditional Burmese card game — **Shan Koe Mee (ရွမ်းကိုယ်မီး)**. Built with ❤️ using modern Flutter architecture, offline-first logic, and optimized for smooth performance on both Android and iOS.

---

## 🚀 Features

- 🇲🇲 **Myanmar-localized UI** for better cultural immersion.
- ♠️ **Card animations** and realistic shuffle effects.
- 🧠 **Smart AI opponents** and multiplayer support (in progress).
- 📶 **Offline-first gameplay** (Hive-based local storage).
- 🔄 **Clean Architecture** + `flutter_bloc` + `get_it` + `freezed`.
- 💥 Lightning-fast rendering with **Impeller (OpenGLES)** backend.

---

## 📱 Screenshots

> Coming soon...

---

## 🧱 Architecture

The project follows **Clean Architecture**:
```
lib/
├── core/               # Reusable utilities (constants, themes, error handlers, etc.)
├── data/               # Data sources (Hive/local DB)
├── domain/             # Entities, Repositories, UseCases
├── presentation/       # UI layer: widgets, blocs, pages
├── di/                 # Dependency injection (get_it)
├── main.dart           # Entry point
```

---

## 🔧 Setup Instructions

### ✅ Prerequisites

- Flutter SDK >= 3.10.0
- Dart >= 3.0.0
- Android Studio or VS Code
- Hive CLI (optional, for codegen)

### 📦 Install Dependencies

```bash
flutter pub get
```

### 💾 Hive Codegen (if needed)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### ▶️ Run the App

```bash
flutter run
```

Use `flutter run -d chrome` to run on web (if supported).

---

## 🛠 Dev Tools & Stack

| Technology       | Purpose                        |
|------------------|--------------------------------|
| Flutter          | Cross-platform UI              |
| Hive             | Local DB (offline support)     |
| flutter_bloc     | State management               |
| get_it           | Dependency injection           |
| freezed          | Code generation + unions       |
| Impeller (OpenGL)| Rendering backend              |
| Firebase (opt.)  | Analytics, Crashlytics         |

---

## ⚠️ Debug Log Insight

> If you're seeing logs like:

```
E/GoogleApiManager: java.lang.SecurityException: Unknown calling package name 'com.google.android.gms'.
```

This is related to `Firebase` or `Google Play Services` on emulators and **safe to ignore during local testing**. Just ensure your Firebase config (`google-services.json`) is valid.

---

## ✍️ Author

**Aung Ye Zaw**  
Senior Flutter Developer @ [Phluid World Pte Ltd](https://phluid.world/)  
🇲🇲 Born to build beautiful apps with code & coffee.

- [LinkedIn](https://www.linkedin.com/in/aungyezawdev/)
- [GitHub](https://github.com/AungYeZawDev)
- [Twitter](https://twitter.com/aungyezawdev)

---

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🙏 Acknowledgements

- Inspired by the cultural beauty of **Shan Koe Mee**.
- Card assets and animations by [TBD].
- Special thanks to Myanmar Flutter community!

---

> _"နည်းပညာနဲ့ သဘာဝလှပမှုကို ပေါင်းပြီး မြန်မာ့ဂိမ်းတစ်ခုကို Digital World ထဲမှာ ပြန်ဖန်တီးတာပါ။"_  
> – Aung Ye Zaw
