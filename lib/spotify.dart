import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify/spotify.dart';

class Spotify {
  static Future<Track> getMusic(List<String> genreList, Market? market) async {
    final credentials = SpotifyApiCredentials(
        dotenv.env['spotify_client_id'], dotenv.env['spotify_client_secret']);
    final spotify = SpotifyApi(credentials);
    final music = await spotify.recommendations.get(
      limit: 1,
      seedArtists: [],
      seedTracks: [],
      market: market,
      seedGenres: genreList,
    );
    return await spotify.tracks.get(music.tracks?.first.id ?? "11dFghVXANMlKmJXsNCbNl");
  }
}