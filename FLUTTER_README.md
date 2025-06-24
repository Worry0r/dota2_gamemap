# Dota 2 Game Map - Flutter Android Implementation

This is a Flutter implementation of the Dota 2 Game Map component, designed to run on Android devices. It provides real-time visualization of Dota 2 matches with interactive controls and WebSocket connectivity.

## Features

### 🎮 Core Functionality
- **Real-time WebSocket connection** for live game data streaming
- **Interactive map visualization** showing heroes, buildings, and creeps
- **Animation controls** with play/pause, speed control, and frame slider
- **Hero tooltips** on tap interaction
- **Team-based color coding** (Radiant green, Dire red)
- **Connection status indicators** with live heartbeat monitoring

### 📱 Mobile-Optimized UI
- **Responsive design** that adapts to different screen sizes
- **Touch-friendly controls** with proper button sizing
- **Material Design** components for consistent Android experience
- **Gesture support** for hero interaction
- **Orientation support** (portrait and landscape)

### 🔧 Technical Features
- **State management** using ChangeNotifier pattern
- **WebSocket heartbeat** for connection stability
- **Coordinate conversion** from game world to screen coordinates
- **Memory-efficient** data processing
- **Error handling** for network issues

## Setup Instructions

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Android Studio or VS Code with Flutter extension
- Android device or emulator
- WebSocket server running (for live data)

### Installation

1. **Clone or create the project:**
   ```bash
   flutter create dota2_gamemap
   cd dota2_gamemap
   ```

2. **Replace the default files with the provided implementation:**
   - Copy `flutter_gamemap.dart` to `lib/main.dart`
   - Copy `pubspec.yaml` to the project root
   - Add the required assets to the `assets/` folder

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Add assets to your project:**
   - Create an `assets/` folder
   - Add the Dota 2 map image (`7.33.webp`)
   - Add tower image (`LightRook.webp`)
   - Add hero minimap icons to `assets/minimap_icons/`

5. **Run the app:**
   ```bash
   flutter run
   ```

## Project Structure

```
dota2_gamemap/
├── lib/
│   └── main.dart                 # Main Flutter implementation
├── assets/
│   ├── 7.33.webp                # Dota 2 map background
│   ├── LightRook.webp           # Tower image
│   └── minimap_icons/           # Hero icons
├── pubspec.yaml                 # Dependencies and assets
└── README.md                    # This file
```

## Key Components

### GameDataManager
- Manages WebSocket connections
- Processes incoming game data
- Handles position tracking for all game entities
- Manages animation state and timing

### GameMapWidget
- Main UI component
- Renders the game map with all entities
- Handles user interactions
- Manages animation controls

### Data Models
- `Position`: 2D coordinate system
- `HeroData`: Hero information and team affiliation
- `BuildingData`: Building status and position
- `CreepData`: Creep information and lifecycle
- `GameState`: Complete game state snapshot
- `MatchTick`: WebSocket message format

## WebSocket Protocol

The app expects WebSocket messages in the following format:

```json
{
  "type": "match_tick",
  "second": 120,
  "match_id": "match-123",
  "game_state": {
    "heroes": {
      "CDOTA_Unit_Hero_Juggernaut": {
        "teamNum": 2,
        "position": {"x": 5000, "y": 3000}
      }
    },
    "buildings": {
      "building_1": {
        "teamNum": 2,
        "position": {"x": 4000, "y": 2000},
        "is_alive": true
      }
    },
    "creeps": {
      "creep_1": {
        "teamNum": 2,
        "position": {"x": 4500, "y": 2500},
        "is_alive": true
      }
    }
  }
}
```

## Configuration

### WebSocket URL
The default WebSocket URL format is:
```
ws://127.0.0.1:8000/match/ws/{matchId}
```

You can modify this in the `_connectToMatch()` method in `GameMapWidget`.

### Coordinate System
The app uses a coordinate conversion system to map Dota 2 world coordinates to screen coordinates:

```dart
double _convertX(double y) {
  return ((y - 6650) / 19000) * 800;
}

double _convertY(double x) {
  return 800 - ((x - 6700) / 19500) * 800;
}
```

## Android-Specific Features

### Permissions
Add the following permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

### Performance Optimization
- The app uses efficient rendering with `Positioned` widgets
- WebSocket connections are properly managed and cleaned up
- Memory usage is optimized for mobile devices

## Testing

### Local Testing
1. Start your WebSocket server
2. Run the Flutter app
3. Enter the WebSocket URL in the connection form
4. Test with sample data

### Sample Data
You can create a test WebSocket server that sends mock data to test the visualization:

```python
import asyncio
import websockets
import json

async def test_server(websocket, path):
    # Send sample match tick data
    sample_data = {
        "type": "match_tick",
        "second": 0,
        "match_id": "test-match",
        "game_state": {
            "heroes": {
                "CDOTA_Unit_Hero_Juggernaut": {
                    "teamNum": 2,
                    "position": {"x": 5000, "y": 3000}
                }
            }
        }
    }
    await websocket.send(json.dumps(sample_data))

start_server = websockets.serve(test_server, "localhost", 8000)
asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
```

## Troubleshooting

### Common Issues

1. **WebSocket Connection Failed**
   - Check if the server is running
   - Verify the WebSocket URL format
   - Ensure network permissions are granted

2. **Assets Not Loading**
   - Verify assets are properly declared in `pubspec.yaml`
   - Run `flutter clean` and `flutter pub get`
   - Check asset file paths

3. **Performance Issues**
   - Reduce animation frame rate
   - Limit the number of entities rendered
   - Use `const` widgets where possible

## Future Enhancements

- **Hero icons**: Add actual hero minimap icons
- **Path visualization**: Show movement trails
- **Team information**: Display team stats and composition
- **Chat integration**: Add in-game chat support
- **Offline mode**: Cache game data for offline viewing
- **Multiple maps**: Support for different Dota 2 maps

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is for educational and demonstration purposes. Please respect Dota 2's intellectual property rights. 