import 'package:audioplayers/audioplayers.dart';
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

  //Audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider(){
    listenToDuration();
  }

  //initially not playing
  bool _isPlaying = false;

  //play the song
  /*void play() async{
    final String path = _playlist[_currentSongIndex].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource((path))); //play the new song
    _isPlaying = true;
    notifyListeners();
  }*/

  void play() async {
    if (_currentSongIndex == null) return; // do nothing if no song is selected

    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path)); // play the new song
    _isPlaying = true;
    notifyListeners();
  }


  //pause the song
  void pause() async{
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async{
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void PauseOrResume() async{
    if(_isPlaying){
      pause();
    }else{
      resume();
    }
    notifyListeners();
  }

  //seek to a specific position in the current song
  void seek(Duration position) async{
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  //play next song
  void playNextSong() async{
    if(_currentSongIndex != null){
      if(_currentSongIndex! < _playlist.length - 1){
        _currentSongIndex = _currentSongIndex! + 1;
      }else{
        currentSongIndex = 0;
      }
    }
  }

  //play previous osng
  void playPreviousSong() async{
    if(_currentDuration.inSeconds > 2){
      await _audioPlayer.seek(Duration.zero);
    }else{
      if(_currentSongIndex! > 0){
        _currentSongIndex = _currentSongIndex! - 1;
      }else{
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //list to duration
  void listenToDuration(){
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();

    });

    //listen for song completed
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });

  }

  //dispose audio player

  //getters
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  bool get isPlaying => _isPlaying;

  //setters
  set currentSongIndex(int? index){
    //update current song index
    _currentSongIndex = index;
    if(index != null){
      play();
    }

    //update UI
    notifyListeners();
  }
}