import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

// Data Models
class Position {
  final double x;
  final double y;
  
  Position({required this.x, required this.y});
  
  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      x: json['x']?.toDouble() ?? 0.0,
      y: json['y']?.toDouble() ?? 0.0,
    );
  }
}

class HeroData {
  final int teamNum;
  final Position? position;
  
  HeroData({required this.teamNum, this.position});
  
  factory HeroData.fromJson(Map<String, dynamic> json) {
    return HeroData(
      teamNum: json['teamNum'] ?? 2,
      position: json['position'] != null ? Position.fromJson(json['position']) : null,
    );
  }
}

class BuildingData {
  final int teamNum;
  final Position? position;
  final bool isAlive;
  
  BuildingData({required this.teamNum, this.position, this.isAlive = true});
  
  factory BuildingData.fromJson(Map<String, dynamic> json) {
    return BuildingData(
      teamNum: json['teamNum'] ?? 2,
      position: json['position'] != null ? Position.fromJson(json['position']) : null,
      isAlive: json['is_alive'] ?? true,
    );
  }
}

class CreepData {
  final int teamNum;
  final Position? position;
  final bool isAlive;
  
  CreepData({required this.teamNum, this.position, this.isAlive = true});
  
  factory CreepData.fromJson(Map<String, dynamic> json) {
    return CreepData(
      teamNum: json['teamNum'] ?? 2,
      position: json['position'] != null ? Position.fromJson(json['position']) : null,
      isAlive: json['is_alive'] ?? true,
    );
  }
}

class GameState {
  final Map<String, HeroData> heroes;
  final Map<String, BuildingData> buildings;
  final Map<String, CreepData> creeps;
  
  GameState({
    required this.heroes,
    required this.buildings,
    required this.creeps,
  });
  
  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      heroes: (json['heroes'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, HeroData.fromJson(value)),
      ) ?? {},
      buildings: (json['buildings'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, BuildingData.fromJson(value)),
      ) ?? {},
      creeps: (json['creeps'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, CreepData.fromJson(value)),
      ) ?? {},
    );
  }
}

class MatchTick {
  final String type;
  final int second;
  final String matchId;
  final GameState gameState;
  
  MatchTick({
    required this.type,
    required this.second,
    required this.matchId,
    required this.gameState,
  });
  
  factory MatchTick.fromJson(Map<String, dynamic> json) {
    return MatchTick(
      type: json['type'] ?? '',
      second: json['second'] ?? 0,
      matchId: json['match_id'] ?? '',
      gameState: GameState.fromJson(json['game_state'] ?? {}),
    );
  }
}

// Game Data Manager
class GameDataManager extends ChangeNotifier {
  Map<String, List<Position>> heroPositions = {};
  Map<String, List<Position>> buildingPositions = {};
  Map<String, List<Position>> creepPositions = {};
  
  Map<String, Color> heroColors = {};
  Map<String, Color> buildingColors = {};
  Map<String, Color> creepColors = {};
  
  Map<String, int> buildingDeathTimes = {};
  Map<String, int> creepDeathTimes = {};
  
  int maxFrames = 0;
  bool isConnected = false;
  String? connectionError;
  
  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;
  
  // Connect to WebSocket
  void connectWebSocket(String url) {
    try {
      _channel = IOWebSocketChannel.connect(Uri.parse(url));
      isConnected = true;
      connectionError = null;
      
      _channel!.stream.listen(
        (data) {
          _handleWebSocketMessage(data);
        },
        onError: (error) {
          connectionError = 'Connection error: $error';
          isConnected = false;
          notifyListeners();
        },
        onDone: () {
          isConnected = false;
          notifyListeners();
        },
      );
      
      // Send initial connection message
      _channel!.sink.add(jsonEncode({
        'type': 'connection_established',
        'client': 'game_map'
      }));
      
      // Start heartbeat
      _startHeartbeat();
      
      notifyListeners();
    } catch (e) {
      connectionError = 'Failed to connect: $e';
      isConnected = false;
      notifyListeners();
    }
  }
  
  void _startHeartbeat() {
    _heartbeatTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      if (isConnected && _channel != null) {
        _channel!.sink.add(jsonEncode({'type': 'heartbeat'}));
      }
    });
  }
  
  void _handleWebSocketMessage(dynamic data) {
    try {
      final jsonData = jsonDecode(data);
      
      if (jsonData['type'] == 'heartbeat') {
        _channel!.sink.add(jsonEncode({'type': 'heartbeat_response'}));
      } else if (jsonData['type'] == 'match_tick') {
        _processTickData(MatchTick.fromJson(jsonData));
      }
    } catch (e) {
      print('Error processing WebSocket message: $e');
    }
  }
  
  void _processTickData(MatchTick tick) {
    final second = tick.second;
    final gameState = tick.gameState;
    
    // Process heroes
    gameState.heroes.forEach((heroName, heroData) {
      if (heroData.position != null) {
        if (!heroPositions.containsKey(heroName)) {
          heroPositions[heroName] = [];
        }
        heroPositions[heroName]!.add(heroData.position!);
        
        // Set hero color based on team
        heroColors[heroName] = heroData.teamNum == 2 
            ? Color(0xFF2AC500) // Radiant green
            : Color(0xFFC50000); // Dire red
      }
    });
    
    // Process buildings
    gameState.buildings.forEach((buildingId, buildingData) {
      if (!buildingData.isAlive) {
        buildingDeathTimes[buildingId] = second;
        return;
      }
      
      if (buildingData.position != null) {
        if (!buildingPositions.containsKey(buildingId)) {
          buildingPositions[buildingId] = [];
        }
        buildingPositions[buildingId]!.add(buildingData.position!);
        
        // Set building color based on team
        buildingColors[buildingId] = buildingData.teamNum == 2 
            ? Color(0xFF2AC500) // Radiant green
            : Color(0xFFC50000); // Dire red
      }
    });
    
    // Process creeps
    gameState.creeps.forEach((creepId, creepData) {
      if (!creepData.isAlive) {
        creepDeathTimes[creepId] = second;
        return;
      }
      
      if (creepData.position != null) {
        if (!creepPositions.containsKey(creepId)) {
          creepPositions[creepId] = [];
        }
        creepPositions[creepId]!.add(creepData.position!);
        
        // Set creep color based on team
        creepColors[creepId] = creepData.teamNum == 2 
            ? Color(0xFF2AC500) // Radiant green
            : Color(0xFFC50000); // Dire red
      }
    });
    
    // Update max frames
    if (second > maxFrames) {
      maxFrames = second;
    }
    
    notifyListeners();
  }
  
  Map<String, Map<String, Position>>? getPositionsAtFrame(int frame) {
    if (maxFrames == 0) return null;
    
    final heroPositionsAtFrame = <String, Position>{};
    final buildingPositionsAtFrame = <String, Position>{};
    final creepPositionsAtFrame = <String, Position>{};
    
    // Get hero positions
    heroPositions.forEach((heroName, positions) {
      if (positions.length > frame) {
        heroPositionsAtFrame[heroName] = positions[frame];
      }
    });
    
    // Get building positions
    buildingPositions.forEach((buildingId, positions) {
      if (buildingDeathTimes[buildingId] != null && 
          buildingDeathTimes[buildingId]! <= frame) {
        return; // Building is dead
      }
      if (positions.length > frame) {
        buildingPositionsAtFrame[buildingId] = positions[frame];
      }
    });
    
    // Get creep positions
    creepPositions.forEach((creepId, positions) {
      if (creepDeathTimes[creepId] != null && 
          creepDeathTimes[creepId]! <= frame) {
        return; // Creep is dead
      }
      if (positions.length > frame) {
        creepPositionsAtFrame[creepId] = positions[frame];
      }
    });
    
    return {
      'heroes': heroPositionsAtFrame,
      'buildings': buildingPositionsAtFrame,
      'creeps': creepPositionsAtFrame,
    };
  }
  
  void disconnect() {
    _heartbeatTimer?.cancel();
    _channel?.sink.close();
    _channel = null;
    isConnected = false;
    notifyListeners();
  }
  
  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}

// Main Game Map Widget
class GameMapWidget extends StatefulWidget {
  final String? matchId;
  
  const GameMapWidget({Key? key, this.matchId}) : super(key: key);
  
  @override
  _GameMapWidgetState createState() => _GameMapWidgetState();
}

class _GameMapWidgetState extends State<GameMapWidget> {
  final GameDataManager _gameDataManager = GameDataManager();
  
  int _currentFrame = 0;
  bool _isPlaying = false;
  double _currentPlaybackSpeed = 1.0;
  Timer? _animationTimer;
  
  final List<double> _playbackSpeeds = [0.5, 1.0, 2.0, 4.0, 8.0];
  
  String? _hoveredHero;
  Offset _tooltipPosition = Offset.zero;
  
  @override
  void initState() {
    super.initState();
    _gameDataManager.addListener(_onGameDataChanged);
    
    // Connect to WebSocket if matchId is provided
    if (widget.matchId != null) {
      _connectToMatch();
    }
  }
  
  void _connectToMatch() {
    final wsUrl = 'ws://127.0.0.1:8000/match/ws/${widget.matchId}';
    _gameDataManager.connectWebSocket(wsUrl);
  }
  
  void _onGameDataChanged() {
    setState(() {});
  }
  
  void _togglePlay() {
    if (_gameDataManager.maxFrames == 0) return;
    
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    });
  }
  
  void _startAnimation() {
    _animationTimer = Timer.periodic(
      Duration(milliseconds: (1000 / _currentPlaybackSpeed).round()),
      (timer) {
        setState(() {
          _currentFrame = (_currentFrame + 1) % _gameDataManager.maxFrames;
          if (_currentFrame == _gameDataManager.maxFrames - 1) {
            _stopAnimation();
          }
        });
      },
    );
  }
  
  void _stopAnimation() {
    _animationTimer?.cancel();
    _animationTimer = null;
    setState(() {
      _isPlaying = false;
    });
  }
  
  void _resetAnimation() {
    _stopAnimation();
    setState(() {
      _currentFrame = 0;
    });
  }
  
  void _setPlaybackSpeed(double speed) {
    setState(() {
      _currentPlaybackSpeed = speed;
      if (_isPlaying) {
        _stopAnimation();
        _startAnimation();
      }
    });
  }
  
  // Coordinate conversion functions
  double _convertX(double y) {
    return ((y - 6650) / 19000) * 800;
  }
  
  double _convertY(double x) {
    return 800 - ((x - 6700) / 19500) * 800;
  }
  
  @override
  Widget build(BuildContext context) {
    final currentPositions = _gameDataManager.getPositionsAtFrame(_currentFrame);
    final hasGameData = _gameDataManager.maxFrames > 0;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Dota 2 Game Map'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Controls
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              children: [
                // Connection Status
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: _gameDataManager.isConnected 
                        ? Colors.green[100] 
                        : Colors.red[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _gameDataManager.isConnected 
                        ? 'Connected' 
                        : _gameDataManager.connectionError ?? 'Disconnected',
                    style: TextStyle(
                      color: _gameDataManager.isConnected 
                          ? Colors.green[800] 
                          : Colors.red[800],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                
                // Playback Controls
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: hasGameData ? _togglePlay : null,
                      child: Text(_isPlaying ? 'Pause' : 'Play'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: hasGameData ? _resetAnimation : null,
                      child: Text('Reset'),
                    ),
                    SizedBox(width: 8),
                    
                    // Playback Speed Dropdown
                    PopupMenuButton<double>(
                      onSelected: _setPlaybackSpeed,
                      itemBuilder: (context) => _playbackSpeeds
                          .map((speed) => PopupMenuItem(
                                value: speed,
                                child: Text('${speed}x'),
                              ))
                          .toList(),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('Speed ${_currentPlaybackSpeed}x'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                
                // Frame Slider
                if (hasGameData) ...[
                  Slider(
                    value: _currentFrame.toDouble(),
                    min: 0,
                    max: (_gameDataManager.maxFrames - 1).toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _currentFrame = value.round();
                        _stopAnimation();
                      });
                    },
                  ),
                  Text(
                    'Game Time: ${(_currentFrame / 60).floor()}:${(_currentFrame % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ],
            ),
          ),
          
          // Game Map
          Expanded(
            child: Container(
              width: 800,
              height: 800,
              child: Stack(
                children: [
                  // Background Map
                  Container(
                    width: 800,
                    height: 800,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      image: DecorationImage(
                        image: AssetImage('assets/7.33.webp'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  // Game Elements
                  if (currentPositions != null) ...[
                    // Buildings
                    ...currentPositions['buildings']!.entries.map((entry) {
                      final building = entry.value;
                      final color = _gameDataManager.buildingColors[entry.key] ?? Colors.grey;
                      
                      return Positioned(
                        left: _convertX(building.y) - 13,
                        top: _convertY(building.x) - 13,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(color: Colors.black, width: 1.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }),
                    
                    // Creeps
                    ...currentPositions['creeps']!.entries.map((entry) {
                      final creep = entry.value;
                      final color = _gameDataManager.creepColors[entry.key] ?? Colors.grey;
                      
                      return Positioned(
                        left: _convertX(creep.y) - 5,
                        top: _convertY(creep.x) - 5,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                      );
                    }),
                    
                    // Heroes
                    ...currentPositions['heroes']!.entries.map((entry) {
                      final hero = entry.value;
                      final color = _gameDataManager.heroColors[entry.key] ?? Colors.grey;
                      final heroName = entry.key.replaceAll('CDOTA_Unit_Hero_', '');
                      
                      return Positioned(
                        left: _convertX(hero.y) - 15,
                        top: _convertY(hero.x) - 15,
                        child: GestureDetector(
                          onTapDown: (details) {
                            setState(() {
                              _hoveredHero = heroName;
                              _tooltipPosition = details.globalPosition;
                            });
                          },
                          onTapUp: (details) {
                            setState(() {
                              _hoveredHero = null;
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: color,
                              border: Border.all(color: Colors.black, width: 1.5),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                heroName.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                  
                  // Hero Tooltip
                  if (_hoveredHero != null)
                    Positioned(
                      left: _tooltipPosition.dx + 10,
                      top: _tooltipPosition.dy + 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _hoveredHero!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  
                  // Connection Indicator
                  if (_gameDataManager.isConnected)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Live',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  // No Data Overlay
                  if (!hasGameData)
                    Container(
                      width: 800,
                      height: 800,
                      color: Colors.white.withOpacity(0.7),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _gameDataManager.isConnected 
                                ? 'Waiting for game data...' 
                                : 'Connect to WebSocket to receive game data',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Connection Controls
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'WebSocket URL',
                    hintText: 'ws://127.0.0.1:8000/match/ws/{matchId}',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (url) {
                    if (url.isNotEmpty) {
                      _gameDataManager.connectWebSocket(url);
                    }
                  },
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _connectToMatch(),
                      child: Text('Connect'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _gameDataManager.disconnect,
                      child: Text('Disconnect'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _gameDataManager.removeListener(_onGameDataChanged);
    _gameDataManager.dispose();
    _animationTimer?.cancel();
    super.dispose();
  }
}

// Main App
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dota 2 Game Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GameMapWidget(matchId: 'test-match-123'),
    );
  }
} 