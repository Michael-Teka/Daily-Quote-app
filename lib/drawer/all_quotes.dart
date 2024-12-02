// import 'package:daily_quotes_app/model/add_quote.dart';
// import 'package:flutter/material.dart';
// // import '../quote_manager.dart';

// class AllQuotesScreen extends StatelessWidget {
//   const AllQuotesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Quotes'),
//       ),
//       body: ValueListenableBuilder<List<Quote>>(
//         valueListenable: QuoteManager().quotesNotifier,
//         builder: (context, quotes, _) {
//           if (quotes.isEmpty) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return ListView.builder(
//             itemCount: quotes.length,
//             itemBuilder: (context, index) {
//               final quote = quotes[index];
//               return ListTile(
//                 title: Text(quote.text),
//                 subtitle: Text('- ${quote.author}'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:daily_quotes_app/model/favorites_manager.dart';
import 'package:flutter/material.dart';
import 'package:daily_quotes_app/model/add_quote.dart';

class AllQuotesScreen extends StatefulWidget {
  const AllQuotesScreen({Key? key}) : super(key: key);

  @override
  State<AllQuotesScreen> createState() => _AllQuotesScreenState();
}

class _AllQuotesScreenState extends State<AllQuotesScreen> {
  final QuoteManager quoteManager = QuoteManager(); // Instance of QuoteManager

  @override
  void initState() {
    super.initState();
    quoteManager.loadQuotes(); // Load all quotes at the start
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Quotes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ), // Custom title color
        ),
        backgroundColor: Colors.black, // AppBar background color
        iconTheme:
            const IconThemeData(color: Colors.white), // Adjusts icon color
      ),
      body: ValueListenableBuilder<List<Quote>>(
        valueListenable: quoteManager.quotesNotifier,
        builder: (context, quotes, _) {
          if (quotes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: quotes.length,
            itemBuilder: (context, index) {
              final quote = quotes[index];
              final isFavorite = FavoritesManager.instance.isFavorite(quote);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        FavoritesManager.instance.toggleFavorite(quote);
                      });
                      final snackBarMessage = isFavorite
                          ? 'Removed from Favorites'
                          : 'Added to Favorites';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(snackBarMessage)),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
