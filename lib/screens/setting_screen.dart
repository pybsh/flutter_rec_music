import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:rec_music/prefs.dart';
import 'package:rec_music/screens/home_screen.dart';
import 'package:spotify/spotify.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final List<String> _genreList = [
    "acoustic",
    "afrobeat",
    "alt-rock",
    "alternative",
    "ambient",
    "anime",
    "black-metal",
    "bluegrass",
    "blues",
    "bossanova",
    "brazil",
    "breakbeat",
    "british",
    "cantopop",
    "chicago-house",
    "children",
    "chill",
    "classical",
    "club",
    "comedy",
    "country",
    "dance",
    "dancehall",
    "death-metal",
    "deep-house",
    "detroit-techno",
    "disco",
    "disney",
    "drum-and-bass",
    "dub",
    "dubstep",
    "edm",
    "electro",
    "electronic",
    "emo",
    "folk",
    "forro",
    "french",
    "funk",
    "garage",
    "german",
    "gospel",
    "goth",
    "grindcore",
    "groove",
    "grunge",
    "guitar",
    "happy",
    "hard-rock",
    "hardcore",
    "hardstyle",
    "heavy-metal",
    "hip-hop",
    "holidays",
    "honky-tonk",
    "house",
    "idm",
    "indian",
    "indie",
    "indie-pop",
    "industrial",
    "iranian",
    "j-dance",
    "j-idol",
    "j-pop",
    "j-rock",
    "jazz",
    "k-pop",
    "kids",
    "latin",
    "latino",
    "malay",
    "mandopop",
    "metal",
    "metal-misc",
    "metalcore",
    "minimal-techno",
    "movies",
    "mpb",
    "new-age",
    "new-release",
    "opera",
    "pagode",
    "party",
    "philippines-opm",
    "piano",
    "pop",
    "pop-film",
    "post-dubstep",
    "power-pop",
    "progressive-house",
    "psych-rock",
    "punk",
    "punk-rock",
    "r-n-b",
    "rainy-day",
    "reggae",
    "reggaeton",
    "road-trip",
    "rock",
    "rock-n-roll",
    "rockabilly",
    "romance",
    "sad",
    "salsa",
    "samba",
    "sertanejo",
    "show-tunes",
    "singer-songwriter",
    "ska",
    "sleep",
    "songwriter",
    "soul",
    "soundtracks",
    "spanish",
    "study",
    "summer",
    "swedish",
    "synth-pop",
    "tango",
    "techno",
    "trance",
    "trip-hop",
    "turkish",
    "work-out",
    "world-music"
  ];
  final List<String> _localeList = Market.values.map((e) => e.name).toList();
  List<String> _currentGenre = [];
  String? _locale = "";

  void setGenreList(List<String> list) {
    setState(() {
      _currentGenre = list;
    });
  }

  void setLocale(String? locale) {
    setState(() {
      _locale = locale;
    });
  }

  bool disabledItemFn(String? item) {
    return _currentGenre.length > 5 ? true : false;
  }

  @override
  void initState() {
    Prefs.getGenre().then((genre) {
      Prefs.getLocale().then((locale) {
        if (genre != null && locale != null) {
          setState(() {
            _currentGenre = genre;
            _locale = locale;
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          leading: IconButton(
            onPressed: () {
              setState(() {
                Prefs.setGenre(_currentGenre);
                Prefs.setLocale(_locale!);
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DropdownSearch<String>.multiSelection(
                      items: _genreList,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Genre Settings",
                          hintText: "Select Genre",
                        ),
                      ),
                      popupProps: const PopupPropsMultiSelection.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      onChanged: setGenreList,
                      selectedItems: _currentGenre,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DropdownSearch<String>(
                      items: _localeList,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Market Settings",
                          hintText: "Select Locale",
                        ),
                      ),
                      popupProps: const PopupPropsMultiSelection.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      onChanged: setLocale,
                      selectedItem: _locale,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
