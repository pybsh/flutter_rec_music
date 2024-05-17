import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rec_music/screens/setting_screen.dart';
import 'package:rec_music/spotify.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = false;
  bool isClicked = false;
  String musicName = "-";
  String musicAlbum = "-";
  String musicArtist = "-";
  String musicAlbumImageUrl = "";

  void getMusic() {
    setState(() {
      isLoaded = false;
      isClicked = true;
    });
    Spotify.getMusic().then((music) {
      setState(() {
        musicName = music.name ?? "곡 이름";
        musicAlbum = music.album?.name ?? "앨범";
        musicArtist = music.artists?.first.name ?? "아티스트";
        musicAlbumImageUrl =
            music.album?.images?.first.url ?? "https://http.cat/400";
        isLoaded = true;
        isClicked = false;
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
                Container(
                  margin: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height / 2) - 300),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: isClicked
                        ? const SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFA79277),
                              ),
                            ),
                          )
                        : isLoaded
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(musicAlbumImageUrl),
                              )
                            : const Icon(Icons.music_note,
                                size: 100, color: Color(0xFFA79277)),
                  ),
                ),
                if (isLoaded)
                  Column(
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
                Container(
                  margin: const EdgeInsets.only(top: 160),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.not_interested_outlined,
                          size: 50,
                          color: Color(0xFFA79277),
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 50),
                      IconButton(
                        icon: const Icon(
                          Icons.my_library_music_rounded,
                          size: 50,
                          color: Color(0xFFA79277),
                        ),
                        onPressed: getMusic,
                      ),
                      const SizedBox(width: 50),
                      IconButton(
                        icon: const Icon(
                          Icons.settings,
                          size: 50,
                          color: Color(0xFFA79277),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SettingScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
