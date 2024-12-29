# Weather App ⛅

A modern Flutter weather application that provides real-time weather information and forecasts using the OpenWeatherMap API.

## Features 🌟

- **Real-time Weather Data**
  - 🌡️ Current temperature
  - 💧 Humidity levels
  - 🌪️ Wind speed
  - 🎯 Precise weather descriptions
  - 🖼️ Weather condition icons

- **Location Services**
  - 📍 Automatic current location detection
  - 🔍 Search weather by city name
  - 🌍 Worldwide coverage

- **Advanced Features**
  - 📊 7-day weather forecast
  - 💾 Offline mode with data caching
  - 🔄 Pull-to-refresh updates
  - ⚡ Fast and responsive UI

## Screenshots 📱

<p float="left">
  <img src="assets/screenshots/home_screen.png" width="200" alt="Home Screen"/>

</p>

## Installation 🚀

1. **Clone the repository**
- git clone https://github.com/DxDForge/wether_app.git

2. **Set up environment variables**
   - Create a `.env` file in the project root
   - Add your OpenWeatherMap API key:

3. **Install dependencies**

4. **Run the app**

## Tech Stack 💻

- **Framework**: Flutter
- **API**: OpenWeatherMap
- **Local Storage**: SharedPreferences
- **Location Services**: Geolocator
- **HTTP Client**: http package
- **Environment**: flutter_dotenv
- **Date Formatting**: intl

## Project Structure 📁

## Features in Detail 📋

- **Current Weather**
  - Real-time temperature display
  - Humidity and wind information
  - Weather condition description
  - Visual weather indicators

- **Weather Forecast**
  - 7-day weather prediction
  - Daily temperature ranges
  - Weather condition forecasts
  - Easy-to-read format

- **Location Features**
  - Automatic location detection
  - City search functionality
  - Location permission handling

- **Offline Capabilities**
  - Local data caching
  - Offline mode support
  - Automatic data refresh

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Building 🔨

To build the release version:

```bash
flutter build apk --release
```

The APK file will be available at: `build/app/outputs/flutter-apk/app-release.apk`

## Known Issues 🐛

- Weather forecast limited to 5 days (OpenWeatherMap API free tier limitation)
- City search requires exact name matches
- Weather icons may take time to load on slow connections

## Future Improvements 🚀

- [ ] Dark mode support
- [ ] Multiple location saving
- [ ] Weather notifications
- [ ] More detailed weather information
- [ ] Weather maps integration
- [ ] Unit tests implementation

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments 🙏

- OpenWeatherMap for providing the weather data API
- Flutter team for the amazing framework
- All contributors who help improve this project

## Contact 📧

DxDForge - [GitHub](https://github.com/DxDForge)

Project Link: [https://github.com/DxDForge/wether_app](https://github.com/DxDForge/wether_app)