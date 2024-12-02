import 'package:daily_quotes_app/drawer/about_app.dart';
import 'package:daily_quotes_app/drawer/all_quotes.dart';
import 'package:daily_quotes_app/drawer/favorite_quotes.dart';
import 'package:daily_quotes_app/drawer/shared_quotes.dart';
import 'package:daily_quotes_app/model/add_quote.dart';
import 'package:daily_quotes_app/model/favorites_manager.dart';
import 'package:daily_quotes_app/model/sharedquotes_manager.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final QuoteManager quoteManager = QuoteManager();
  Quote? currentQuote;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    quoteManager.loadQuotes();
    quoteManager.quotesNotifier
        .addListener(_setInitialQuote); // Listen for quotes
  }

  @override
  void dispose() {
    quoteManager.quotesNotifier.removeListener(_setInitialQuote);
    super.dispose();
  }

  void _setInitialQuote() {
    if (quoteManager.quotesNotifier.value.isNotEmpty) {
      setState(() {
        currentQuote = quoteManager.getDailyQuote();
      });
    }
  }

  void refreshQuote() {
    final quotes = quoteManager.quotesNotifier.value;
    if (quotes.isNotEmpty) {
      setState(() {
        // Pick a random quote
        currentQuote = quotes[random.nextInt(quotes.length)];
      });
    }
  }

  void toggleFavorite(Quote quote) {
    setState(() {
      FavoritesManager.instance.toggleFavorite(quote);
    });

    final isFavorite = FavoritesManager.instance.isFavorite(quote);
    final snackBarMessage =
        isFavorite ? 'Added to Favorites' : 'Removed from Favorites';
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(snackBarMessage)));
  }

  void shareQuote(Quote quote) {
    SharedQuotesManager.instance.addSharedQuote(quote);
    Share.share('"${quote.text}"\n- ${quote.author}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Quote shared successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Quotes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ), // Custom title color
        ),
        backgroundColor: Colors.black, // AppBar background color
        iconTheme:
            const IconThemeData(color: Colors.white), // Adjusts icon color
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text(
                'Daily Quotes App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // backgroundColor: Colors.teal,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Daily Quote',
                style: TextStyle(
                  color: Colors.white,
                  // fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // backgroundColor: Colors.teal,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'All Quotes',
                style: TextStyle(
                  color: Colors.white,
                  //  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // backgroundColor: Colors.teal,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllQuotesScreen()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Favorite Quotes',
                style: TextStyle(
                  color: Colors.white,
                  // fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // backgroundColor: Colors.teal,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoriteQuotesScreen()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Shared Quotes',
                style: TextStyle(
                  color: Colors.white,
                  // fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // backgroundColor: Colors.teal,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SharedQuotesScreen()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'About this App',
                style: TextStyle(
                  color: Colors.white,
                  // fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // backgroundColor: Colors.teal,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutThisApp()),
                );
              },
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder<List<Quote>>(
        valueListenable: quoteManager.quotesNotifier,
        builder: (context, quotes, _) {
          if (quotes.isEmpty || currentQuote == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final isFavorite =
              FavoritesManager.instance.isFavorite(currentQuote!);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: const Color.fromARGB(255, 125, 155, 206),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentQuote!.text,
                          style: const TextStyle(
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "- ${currentQuote!.author}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? Colors.red
                                    : const Color.fromARGB(255, 236, 8, 187),
                              ),
                              onPressed: () {
                                toggleFavorite(currentQuote!);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.share),
                              onPressed: () {
                                shareQuote(currentQuote!);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: refreshQuote,
                  child: const Text("Refresh"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
