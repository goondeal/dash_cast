import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:flutter_sound/flutter_sound.dart';

final String url = 'https://itsallwidgets.com/podcast/feed';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DashCastApp(),
      ),
    );
  }
}

class DashCastApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(url),
      builder: (_, response) {
        if (response.hasData) {
          final rss = RssFeed.parse(response.data.body);
          final tmp = rss.items.first;
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text(tmp.title),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Player(tmp.guid))),
              )
            ],
          );
        }
      },
    );
  }
}

class Player extends StatelessWidget {
  Player(this.url);
  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 9,
            child: Placeholder(),
          ),
          Flexible(
            flex: 2,
            child: AudioController(),
          )
        ],
      ),
    );
  }
}

class AudioController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[PlaybackButtons()],
    );
  }
}

class PlaybackButtons extends StatefulWidget {
  @override
  _PlaybackButtonsState createState() => _PlaybackButtonsState();
}

class _PlaybackButtonsState extends State<PlaybackButtons> {
  bool _isPlaying = false;
  FlutterSound _sound;
  double _playPosition;
  Stream<PlayStatus> _playerSubscription;

  @override
  void initState() {
    super.initState();
    _sound = FlutterSound();
    _playPosition = 0.0;
  }

  void _stop() async {
    await _sound.stopPlayer();
    setState( () => _isPlaying = false);
  }
  

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
