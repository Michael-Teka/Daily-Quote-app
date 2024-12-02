import 'add_quote.dart';

class SharedQuotesManager {
  static final SharedQuotesManager _instance = SharedQuotesManager._internal();

  SharedQuotesManager._internal();

  static SharedQuotesManager get instance => _instance;

  final List<Quote> _sharedQuotes = [];

  List<Quote> get sharedQuotes => _sharedQuotes;

  void addSharedQuote(Quote quote) {
    if (!_sharedQuotes.contains(quote)) {
      _sharedQuotes.add(quote);
    }
  }
}
