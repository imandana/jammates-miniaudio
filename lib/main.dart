import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'JAMMATES DEMO MINIAUDIO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _methodChannel = const MethodChannel("method_channel");
  bool _isPlaying = false;
  int _drumVolume = 100;
  int _bassVolume = 100;
  int _pianoVolume = 100;
  double _playbackSpeed = 1.0; // Default playback speed
  PlaybackSpeed _activePlaybackSpeed =
      PlaybackSpeed.normal; // Enum to track active playback speed

  void _togglePlay() {
    if (_isPlaying) {
      _methodChannel.invokeMethod("playSound", {"text": '=====TEST====='});
    } else {
      // _methodChannel.invokeMethod("stopSound", {"text": '=====TEST====='});
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  // void _updateDrumVolume(double value) {
  //   setState(() {
  //     _drumVolume = value.round();
  //   });
  //   _methodChannel.invokeMethod("updateDrumVolume", {"volume": _drumVolume});
  // }

  // void _updateBassVolume(double value) {
  //   setState(() {
  //     _bassVolume = value.round();
  //   });
  //   _methodChannel.invokeMethod("updateBassVolume", {"volume": _bassVolume});
  // }

  // void _updatePianoVolume(double value) {
  //   setState(() {
  //     _pianoVolume = value.round();
  //   });
  //   _methodChannel.invokeMethod("updatePianoVolume", {"volume": _pianoVolume});
  // }

  // void _changePlaybackSpeed(double speed) {
  //   setState(() {
  //     _playbackSpeed = speed;
  //   });
  //   _methodChannel
  //       .invokeMethod("changePlaybackSpeed", {"speed": _playbackSpeed});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                onPressed: _togglePlay,
                child: Text(_isPlaying ? 'Pause' : 'Play'),
              ),
              SizedBox(height: 20),
              // Text(
              //   'Drum',
              //   style: Theme.of(context).textTheme.headline6,
              // ),
              // Slider(
              //   value: _drumVolume.toDouble(),
              //   min: 0,
              //   max: 100,
              //   onChanged: _updateDrumVolume,
              // ),
              // SizedBox(height: 20),
              // Text(
              //   'Bass',
              //   style: Theme.of(context).textTheme.headline6,
              // ),
              // Slider(
              //   value: _bassVolume.toDouble(),
              //   min: 0,
              //   max: 100,
              //   onChanged: _updateBassVolume,
              // ),
              // SizedBox(height: 20),
              // Text(
              //   'Piano',
              //   style: Theme.of(context).textTheme.headline6,
              // ),
              // Slider(
              //   value: _pianoVolume.toDouble(),
              //   min: 0,
              //   max: 100,
              //   onChanged: _updatePianoVolume,
              // ),
              // SizedBox(height: 20),
              // Text(
              //   'Playback Speed',
              //   style: Theme.of(context).textTheme.headline6,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     PlaybackSpeedButton(
              //       speed: PlaybackSpeed.slow,
              //       activeSpeed: _activePlaybackSpeed,
              //       onPressed: () {
              //         _changePlaybackSpeed(0.5);
              //         setState(() {
              //           _activePlaybackSpeed = PlaybackSpeed.slow;
              //         });
              //       },
              //     ),
              //     PlaybackSpeedButton(
              //       speed: PlaybackSpeed.normal,
              //       activeSpeed: _activePlaybackSpeed,
              //       onPressed: () {
              //         _changePlaybackSpeed(1.0);
              //         setState(() {
              //           _activePlaybackSpeed = PlaybackSpeed.normal;
              //         });
              //       },
              //     ),
              //     PlaybackSpeedButton(
              //       speed: PlaybackSpeed.fast,
              //       activeSpeed: _activePlaybackSpeed,
              //       onPressed: () {
              //         _changePlaybackSpeed(1.5);
              //         setState(() {
              //           _activePlaybackSpeed = PlaybackSpeed.fast;
              //         });
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

enum PlaybackSpeed {
  slow,
  normal,
  fast,
}

class PlaybackSpeedButton extends StatelessWidget {
  final PlaybackSpeed speed;
  final PlaybackSpeed activeSpeed;
  final VoidCallback onPressed;

  const PlaybackSpeedButton({
    required this.speed,
    required this.activeSpeed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = speed == activeSpeed ? Colors.blue : Colors.grey;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
      ),
      child: Text(speed
          .toString()
          .split('.')
          .last), // Display button text based on enum value
    );
  }
}
