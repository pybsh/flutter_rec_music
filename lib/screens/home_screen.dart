import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rec_music/screens/setting_screen.dart';
import 'package:rec_music/spotify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../prefs.dart';

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
  String musicURL = "https://http.cat/400";

  void getMusic() {
    Prefs.getGenre().then((genre) => {
      if(genre != null && genre.isNotEmpty) {
        setState(() {
          isLoaded = false;
          isClicked = true;
        }),
        Spotify.getMusic(genre).then((music) {
          setState(() {
            musicName = music.name ?? "곡 이름";
            musicAlbum = music.album?.name ?? "앨범";
            musicArtist = music.artists?.first.name ?? "아티스트";
            musicAlbumImageUrl =
                music.album?.images?.first.url ?? "https://http.cat/400";
            musicURL = music.externalUrls?.spotify ?? "https://http.cat/400";
            isLoaded = true;
            isClicked = false;
          });
        })
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Genre not selected.'),
            content: const Text('Please select at least one genre.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      }
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
                          Icons.headset_rounded,
                          size: 50,
                          color: Color(0xFFA79277),
                        ),
                        onPressed: _launchUrl,
                      ),
                      const SizedBox(width: 50),
                      IconButton(
                        icon: const Icon(
                          Icons.download,
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
                            MaterialPageRoute(
                                builder: (context) => const SettingScreen()),
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

  Future<void> _launchUrl() async {
    if(isLoaded) {
      if (!await launchUrl(Uri.parse(musicURL))) {
        throw Exception('Could not launch $musicURL');
      }
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Music not loaded'),
          content: const Text('Please load music first.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

}
