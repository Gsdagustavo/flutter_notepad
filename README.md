````markdown
# 📝 Flutter Notepad

A simple and clean Notepad app built using Flutter. This app allows users to create, edit, and delete notes with a
lightweight and responsive interface, supporting both light and dark themes.

## 🚀 Features

- 📄 Create, edit, and delete notes
- 🌙 Light & Dark mode toggle
- 🔍 Search notes by title or content
- 🧠 Auto-save functionality
- 💾 Local storage using `shared_preferences` and `sqlite`
- 🌐 Full translation for both English and Portuguese languages
- 📱 Responsive design for phones and tablets

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK (comes with Flutter)
- A code editor like VSCode or Android Studio

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Gsdagustavo/flutter_notepad
   cd flutter_notepad
````

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the app:**

   ```bash
   flutter run
   ```

## 📂 Project Structure

```
lib/
├── main.dart
├── models/       # Note models
├── view/         # UI screens for home, editor, etc.        
├── controller/   # Storage or theme services
```

## 🧪 Testing

To run unit or widget tests:

```bash
flutter test
```

Made with ❤️ using Flutter
