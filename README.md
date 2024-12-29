# Weather App ⛅

A modern Flutter weather application that provides real-time weather information and forecasts using the OpenWeatherMap API.

## Download ⬇️

[Download Latest APK](https://github.com/DxDForge/wether_app/releases/latest)

## Setup Instructions 🛠️

### Prerequisites
- Flutter SDK (>=3.0.0)
- OpenWeatherMap API key
- Android Studio / VS Code
- Git

### Step 1: Clone the Repository
```bash
git clone https://github.com/DxDForge/wether_app.git
cd wether_app
```

### Step 2: API Key Setup
1. Sign up at [OpenWeatherMap](https://openweathermap.org/api)
2. Get your API key from the account dashboard
3. Create a `.env` file in the project root
4. Add your API key:
```
OPENWEATHER_API_KEY=your_api_key_here
```

### Step 3: Install Dependencies
```bash
flutter pub get
```

### Step 4: Run the App
```bash
flutter run
```

## Building from Source 🔨

### Debug Build
```bash
flutter build apk --debug
```

### Release Build
```bash
flutter build apk --release
```

## Known Limitations ⚠️

1. API Limitations
   - Weather forecast limited to 5 days (OpenWeatherMap free tier)
   - Limited API calls per minute
   - City search requires exact name matches

2. Technical Limitations
   - Requires location permissions
   - Internet connection needed for first load
   - Weather icons require internet connection

3. Device Requirements
   - Android 5.0 (API level 21) or higher
   - Location services enabled
   - Internet connection for updates

## Testing 🧪

Run the tests:
```bash
flutter test
```

## Project Structure 📁

```
lib/
├── models/
│   └── weather_model.dart      # Data models
├── screens/
│   └── home_screen.dart        # Main screen
├── services/
│   ├── weather_service.dart    # API handling
│   └── cache_service.dart      # Local storage
├── widgets/
│   ├── current_weather_widget.dart
│   └── forecast_widget.dart
└── main.dart                   # Entry point
```

## Features Implemented ✅

- [x] Current weather display
- [x] 7-day forecast
- [x] Location-based weather
- [x] City search
- [x] Offline support
- [x] Error handling
- [x] Data caching
- [x] Pull-to-refresh

## Contact & Support 📧

For support, email [your-email] or open an issue in the repository.

## License 📄

<!-- This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. -->