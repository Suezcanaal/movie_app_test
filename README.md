# Movie App Test

A Flutter application for browsing movies using the OMDb API. Features include searching movies, viewing details, and managing favorites and watchlist.

## Features

- Search for movies by title
- View detailed movie information (plot, genre, rating, etc.)
- Add movies to favorites and watchlist
- Persistent storage using SharedPreferences
- Responsive grid layout for movie cards

## Prerequisites

Before running this app, ensure you have the following installed:

### For Windows Development:
- **Flutter SDK**: Download and install from [flutter.dev](https://flutter.dev/docs/get-started/install/windows)
- **Visual Studio 2022** with Desktop development with C++ workload (for Windows desktop apps)
- Set up environment variables: Add Flutter to PATH

### For Android Development:
- **Android Studio** or Android Command-line Tools
- **Android SDK** with API level 21 or higher
- **Java JDK** (version 11 or higher)

### General Requirements:
- Git (for cloning the repository)
- Internet connection (for API calls and package downloads)

## Dependencies

This app uses the following Flutter packages (automatically installed via `flutter pub get`):

- `http: ^1.1.0` - For making HTTP requests to OMDb API
- `provider: ^6.0.5` - For state management
- `shared_preferences: ^2.2.0` - For local data persistence
- `cached_network_image: ^3.3.0` - For efficient image loading and caching
- `intl: ^0.18.1` - For date formatting
- `percent_indicator: ^4.2.3` - For displaying rating progress bars

## API Key Setup

This app uses the OMDb API for movie data. You need to obtain a free API key:

1. Visit [OMDb API](http://www.omdbapi.com/apikey.aspx)
2. Sign up for a free API key (1000 requests/day)
3. Open `lib/services/api_service.dart`
4. Replace `'YOUR_API_KEY'` with your actual API key in the `apiKey` constant

## Installation and Setup

### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd movie_app_test
```

### Step 2: Install Flutter Dependencies
```bash
flutter pub get
```

### Step 3: Set Up Development Environment

#### For Windows Desktop:
1. Ensure Flutter is properly installed:
   ```bash
   flutter doctor
   ```
2. If there are issues, follow the Flutter installation guide for Windows.

#### For Android:
1. Install Android Studio or command-line tools
2. Set up Android SDK:
   - Download command-line tools from [Android Developer](https://developer.android.com/studio#command-line-tools-only)
   - Extract to a folder (e.g., `C:\Android\cmdline-tools`)
   - Set `ANDROID_HOME` environment variable to your Android SDK path
   - Add `%ANDROID_HOME%\platform-tools` and `%ANDROID_HOME%\cmdline-tools\bin` to PATH
3. Accept Android SDK licenses:
   ```bash
   flutter doctor --android-licenses
   ```
4. If `flutter doctor` shows issues with cmdline-tools, install them via Android Studio or manually

### Step 4: Verify Setup
Run `flutter doctor` to ensure everything is set up correctly:
```bash
flutter doctor
```

## Running the App

### On Windows Desktop:
```bash
flutter run -d windows
```

### On Android Device/Emulator:
1. Connect an Android device or start an emulator
2. Run:
   ```bash
   flutter run -d android
   ```
   Or simply:
   ```bash
   flutter run
   ```
   (Flutter will prompt to select the device)

### On Web (if needed):
```bash
flutter run -d chrome
```

## Building for Production

### For Android APK:
```bash
flutter build apk --release
```

### For Windows:
```bash
flutter build windows --release
```

## Troubleshooting

### Common Issues:

1. **Android licenses not accepted**:
   ```bash
   flutter doctor --android-licenses
   ```

2. **cmdline-tools missing**:
   - Install Android Studio
   - Or download command-line tools manually and update PATH

3. **No connected devices**:
   - For Android: Enable USB debugging on device or start emulator
   - For Windows: Ensure Visual Studio is installed with required components

4. **API errors**:
   - Check your internet connection
   - Verify your OMDb API key is correct and active

5. **Build errors**:
   - Run `flutter clean` then `flutter pub get`
   - Ensure Flutter SDK is up to date: `flutter upgrade`

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── movie.dart           # Movie data model
├── providers/
│   └── movie_provider.dart  # State management
├── screens/
│   ├── home_screen.dart     # Main screen with tabs
│   ├── movies_tab.dart      # Movie search and grid
│   ├── favorites_tab.dart   # Favorite movies
│   ├── watchlist_tab.dart   # Watchlist movies
│   ├── movie_detail_screen.dart # Movie details
│   └── splash_screen.dart   # App splash screen
├── services/
│   └── api_service.dart     # OMDb API integration
└── widgets/
    └── movie_card.dart      # Movie card widget
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is for educational purposes.
