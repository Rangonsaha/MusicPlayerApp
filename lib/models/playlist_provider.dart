import 'package:flutter/cupertino.dart';
import 'package:musicplayer/models/song.dart';

class PlaylistProvider extends ChangeNotifier{
  // play list of songs
  final List<Song> _playlist = [
    //song 1
    Song(
        songName: "Alone",
        artistName: "Alan Walker",
        albumArtImagePath: "assets/images/alone.png",
        audioPath: "audio/Alone.mp3"
    ),

    Song(
        songName: "Faded",
        artistName: "Alan Walker",
        albumArtImagePath: "assets/images/faded.png",
        audioPath: "audio/Faded.mp3"
    ),

    Song(
        songName: "Sing me to sleep",
        artistName: "Alan Walker",
        albumArtImagePath: "assets/images/singMeToSleep.png",
        audioPath: "audio/SingMeToSleep.mp3"
    ),
  ];

  int? _currentSongIndex;

  //getters
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  //setters
  set currentSongIndex(int? index){
    //update current song index
    _currentSongIndex = index;

    //update UI
    notifyListeners();
  }
}