import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/providers/article_provider.dart';
import 'package:news_app/providers/saved_article_provider.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/widgets/article_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArticleProvider>().loadNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF000666);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: textColor),
          onPressed: () => context.read<ThemeProvider>().toggleTheme(),
        ),
        title: Text(
          'Editorial Intelligence',
          style: GoogleFonts.newsreader(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: const [
          SizedBox(width: 48), 
        ],
      ),
      body: Consumer<ArticleProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
          }
          if (provider.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    provider.errorMessage,
                    style: GoogleFonts.workSans(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.loadNews(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (provider.articles.isEmpty) {
            return Center(child: Text('No articles found.', style: TextStyle(color: textColor)));
          }

          final featuredArticle = provider.articles.first;
          final otherArticles = provider.articles.skip(1).toList();

          return RefreshIndicator(
            onRefresh: () => provider.loadNews(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeaturedArticle(featuredArticle, isDark, textColor),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'For You',
                          style: GoogleFonts.newsreader(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            color: textColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'CUSTOMIZE',
                            style: GoogleFonts.workSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.blueAccent,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: otherArticles.length,
                    itemBuilder: (context, index) {
                      return ArticleCard(article: otherArticles[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlaceholder(Article article, bool isDark) {
    final initial = article.sourceName.isNotEmpty ? article.sourceName[0].toUpperCase() : 'N';
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent.withAlpha((0.3 * 255).toInt()),
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
            fontSize: 120,
            fontWeight: FontWeight.bold,
            color: Colors.white.withAlpha((0.3 * 255).toInt()),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedArticle(Article article, bool isDark, Color textColor) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      height: 400,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withAlpha((0.3 * 255).toInt()) : const Color(0xFF000666).withAlpha((0.08 * 255).toInt()),
            blurRadius: 30,
            offset: const Offset(0, 15),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            if (article.url.isEmpty) return;
            try {
              final Uri url = Uri.parse(article.url);
              await launchUrl(url);
            } catch (e) {
              debugPrint('Error launching url: \$e');
            }
          },
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: article.urlToImage.isEmpty
                  ? _buildPlaceholder(article, isDark)
                  : Image.network(
                      article.urlToImage,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(article, isDark),
                    ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, (isDark ? const Color(0xFF0A1237) : Colors.black).withAlpha((0.85 * 255).toInt())],
                    stops: const [0.3, 1.0],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.newsreader(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        article.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.workSans(
                          fontSize: 14,
                          color: Colors.grey[300],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              article.sourceName,
                              style: GoogleFonts.workSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
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
                                color: Colors.grey[400],
                              ),
                            ),
                          const SizedBox(width: 8),
                          Consumer<SavedArticleProvider>(
                            builder: (context, provider, _) {
                              final isSaved = provider.isSaved(article.url);
                              return IconButton(
                                icon: Icon(
                                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                                  color: isSaved ? Colors.blueAccent : Colors.grey[400],
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
                ),
              ),
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
