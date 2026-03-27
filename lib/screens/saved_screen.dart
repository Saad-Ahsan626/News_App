import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/saved_article_provider.dart';
import 'package:news_app/widgets/article_card.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF000666);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Saved Intelligence',
          style: GoogleFonts.newsreader(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<SavedArticleProvider>(
        builder: (context, provider, child) {
          if (provider.savedArticles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No saved articles yet.',
                    style: GoogleFonts.workSans(
                      fontSize: 18,
                      color: isDark ? Colors.grey[600] : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            itemCount: provider.savedArticles.length,
            itemBuilder: (context, index) {
              return ArticleCard(article: provider.savedArticles[index]);
            },
          );
        },
      ),
    );
  }
}
