import 'package:daily_quotes_app/model/add_quote.dart';
import 'package:flutter/material.dart';
import '../model/favorites_manager.dart';

class FavoriteQuotesScreen extends StatefulWidget {
  const FavoriteQuotesScreen({super.key});

  @override
  State<FavoriteQuotesScreen> createState() => _FavoriteQuotesScreenState();
}

class _FavoriteQuotesScreenState extends State<FavoriteQuotesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesManager.instance.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Quotes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ), // Custom title color
        ),
        backgroundColor: Colors.black, // AppBar background color
        iconTheme:
            const IconThemeData(color: Colors.white), // Adjusts icon color
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorite quotes yet.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final quote = favorites[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      quote.text,
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      '- ${quote.author}',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.black),
                      onPressed: () {
                        _removeFromFavorites(quote);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _removeFromFavorites(Quote quote) {
    setState(() {
      FavoritesManager.instance.toggleFavorite(quote); // Remove the quote
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Quote Removed from favorites')),
    );
  }
}
