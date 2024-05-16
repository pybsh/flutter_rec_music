import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rec_music/spotify.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPlaying = false;
  String musicName = "";
  String musicAlbum = "";
  String musicArtist = "";
  String musicAlbumImageUrl = "";

  void getMusic() {
    Spotify.getMusic().then((music) {
      setState(() {
        musicName = music.name ?? "곡 이름";
        musicAlbum = music.album?.name ?? "앨범";
        musicArtist = music.artists?.first.name ?? "아티스트";
        musicAlbumImageUrl =
            music.album?.images?.first.url ?? "https://http.cat/400";
        isPlaying = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: getMusic,
                  child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: isPlaying
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(musicAlbumImageUrl),
                            )
                          : const Icon(
                              Icons.music_note,
                              size: 100,
                              color: Color(0xFFA79277),
                            )),
                ),
                if(isPlaying) Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 24,
                      child: AutoSizeText(
                        musicName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 24,
                      child: AutoSizeText(
                        musicAlbum,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 24,
                      child: AutoSizeText(
                        musicArtist,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
