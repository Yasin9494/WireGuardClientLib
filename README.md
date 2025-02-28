# WireGuardClientLib

WireGuardClientLib is a simple, cross-platform (iOS & Android) library for managing WireGuard VPN connections from React Native applications.

## 🚀 Features

- Connect and disconnect WireGuard tunnels
- Retrieve connection status
- Monitor packet upload/download statistics
- Ping functionality for checking server availability

## 📦 Installation

### React Native Project Integration

Install the library using yarn or npm:

```bash
yarn add https://github.com/Yasin9494/WireGuardClientLib.git
```

or

```bash
npm install https://github.com/Yasin9494/WireGuardClientLib.git
```

## ⚙️ Native Setup

### iOS Setup

Navigate to the `ios` folder of your React Native project and install pods:

```bash
cd ios
pod install
```

### Android Setup

Ensure your project-level `settings.gradle` includes:

```gradle
include ':WireGuardClientLibAndroid'
project(':WireGuardClientLibAndroid').projectDir = new File(settingsDir, '../node_modules/WireGuardClientLib/WireGuardClientLibAndroid/app')
```

In your app-level `build.gradle` (usually located at `android/app/build.gradle`), add:

```gradle
dependencies {
    implementation project(':WireGuardClientLibAndroid')
}
```

Ensure your `AndroidManifest.xml` has the necessary VPN permissions:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.BIND_VPN_SERVICE" />
```

## 🚦 Usage

Here's a basic example of how to use the library:

```javascript
import WireGuardClient from 'WireGuardClientLib';

// Connect to WireGuard VPN
WireGuardClient.connect(wgQuickConfigString)
  .then(() => console.log('Connected successfully'))
  .catch((error) => console.error('Connection failed', error));

// Disconnect from WireGuard VPN
WireGuardClient.disconnect()
  .then(() => console.log('Disconnected successfully'))
  .catch((error) => console.error('Disconnection failed', error));

// Get Connection Status
WireGuardClient.getStatus()
  .then((status) => console.log('VPN Status:', status));

// Get VPN Statistics
WireGuardClient.getStats()
  .then((stats) => console.log('Stats:', stats));

// Ping the VPN server
WireGuardClient.pingServer('8.8.8.8')
  .then((time) => console.log('Ping successful:', time, 'ms'))
  .catch((error) => console.error('Ping failed:', error));
```

## 🛠️ Development Setup

Clone the repo:

```bash
git clone https://github.com/Yasin9494/WireGuardClientLib.git
cd WireGuardClientLib
```

Set up dependencies:

- **iOS**

```bash
cd Sources
pod install
```

- **Android**

Open in Android Studio or use Gradle commands:

```bash
cd WireGuardClientLibAndroid
./gradlew clean
./gradlew assembleDebug
```

## 🤝 Contribution

Contributions are welcome! Feel free to open an issue or submit a pull request.

## 📃 License

This project is licensed under the MIT License.
