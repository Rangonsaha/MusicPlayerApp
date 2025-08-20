import 'package:flutter/material.dart';
import 'package:musicplayer/components/neu_box.dart';
import 'package:provider/provider.dart';

import '../models/playlist_provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  //convert duration into min:sec
  String formatTime(Duration duration){
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString();
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds}";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {

        //get playlist
        final playlist = value.playlist;

        //get current song
        final currentSong = playlist[value.currentSongIndex ?? 0];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // app bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // back button
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),

                      // title
                      const Text(
                        "P L A Y L I S T",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      // menu button
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // album artwork + song details inside NeuBox
                  NeuBox(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          // album artwork
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              currentSong.albumArtImagePath,
                              fit: BoxFit.cover,
                              height: 250,
                              width: double.infinity,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // song name + artist + favorite icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // song + artist
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSong.songName,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    currentSong.artistName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),

                              // favorite icon
                              Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                                size: 28,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // song duration progress
                  Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //start time
                              Text(value.currentDuration.toString()),

                              //shuffle icon
                              Icon(Icons.shuffle),

                              //repeat icon
                              Icon(Icons.repeat),

                              //end time
                              Text(value.totalDuration.toString()),
                            ],
                          )
                      ),

                      //song duration progress
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 10),
                        ),
                        child: Slider(
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          value: value.currentDuration.inSeconds.toDouble(),
                          activeColor: Colors.green,
                          onChanged: (newValue) {
                            // optional: update UI while sliding
                          },
                          onChangeEnd: (newValue) {
                            // call the provider's seek
                            value.seek(Duration(seconds: newValue.toInt()));
                          },
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  // playback controls

                  Row(
                    children: [

                      //skip previous
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: NeuBox(
                            child: Icon(Icons.skip_previous),
                          ),
                        ),
                      ),

                      //play or pause
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.PauseOrResume,
                          child: NeuBox(
                            child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                          ),
                        ),
                      ),

                      //skip forward
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: NeuBox(
                            child: Icon(Icons.skip_next),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
