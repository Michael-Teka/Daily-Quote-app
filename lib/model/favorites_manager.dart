import 'add_quote.dart';

class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();

  FavoritesManager._internal();

  static FavoritesManager get instance => _instance;

  final List<Quote> _favorites = [];

  List<Quote> get favorites => _favorites;

  void toggleFavorite(Quote quote) {
    if (_favorites.contains(quote)) {
      _favorites.remove(quote);
    } else {
      _favorites.add(quote);
    }
  }

  bool isFavorite(Quote quote) => _favorites.contains(quote);
}
