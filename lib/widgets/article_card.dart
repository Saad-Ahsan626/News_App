import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/providers/saved_article_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  Future<void> _launchUrl() async {
    if (article.url.isEmpty) return;
    try {
      final Uri url = Uri.parse(article.url);
      if (!await launchUrl(url)) {
        debugPrint('Could not launch \$url');
      }
    } catch (e) {
      debugPrint('Error launching url: \$e');
    }
  }

  Widget _buildPlaceholder(bool isDark) {
    final initial = article.sourceName.isNotEmpty ? article.sourceName[0].toUpperCase() : 'N';
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent.withAlpha((0.7 * 255).toInt()),
            isDark ? const Color(0xFF0A1237) : const Color(0xFF000666),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          initial,
          style: GoogleFonts.newsreader(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: Colors.white.withAlpha((0.5 * 255).toInt()),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF000666);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withAlpha((0.2 * 255).toInt()) : const Color(0xFF000666).withAlpha((0.08 * 255).toInt()),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
        onTap: _launchUrl,
        borderRadius: BorderRadius.circular(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: article.urlToImage.isEmpty
              ? _buildPlaceholder(isDark)
              : Image.network(
                  article.urlToImage,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _buildPlaceholder(isDark),
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NEWS', 
                  style: GoogleFonts.workSans(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.newsreader(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        article.sourceName,
                        style: GoogleFonts.workSans(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (_timeAgo(article.publishedAt).isNotEmpty)
                      Text(
                        '• ${_timeAgo(article.publishedAt)}',
                        style: GoogleFonts.workSans(
                          fontSize: 12,
                          color: isDark ? Colors.grey[500] : Colors.grey[700],
                        ),
                      ),
                    const SizedBox(width: 8),
                    Consumer<SavedArticleProvider>(
                      builder: (context, provider, _) {
                        final isSaved = provider.isSaved(article.url);
                        return IconButton(
                          icon: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: isSaved ? Colors.blueAccent : (isDark ? Colors.grey[600] : Colors.grey[400]),
                            size: 20,
                          ),
                          onPressed: () => provider.toggleSaved(article),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      ),
      ),
    );
  }

  String _timeAgo(String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      final date = DateTime.parse(dateStr);
      final difference = DateTime.now().difference(date);
      if (difference.inDays > 0) return '${difference.inDays}d ago';
      if (difference.inHours > 0) return '${difference.inHours}h ago';
      if (difference.inMinutes > 0) return '${difference.inMinutes}m ago';
      return 'Just now';
    } catch (_) {
      return '';
    }
  }
}
