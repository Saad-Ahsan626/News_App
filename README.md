# Editorial Intelligence (News App)

A highly-personalized Flutter news application focusing on delivering curated global intelligence and breaking news. The app features state-of-the-art navigation, offline bookmarking persistence, and a highly polished Light/Dark theme ecosystem.

## ✨ Core Features

*   **Personalized Onboarding**: First-time users are greeted with a beautifully styled wizard to select their favorite topics (Tech, Science, Politics, etc.), up to 10 interests.
*   **Dynamic Theme Switcher**: 100% responsive global Theme scaling. Users can effortlessly jump between a pristine Light Mode and a deep-navy frosted-glass Dark Mode by tapping the indicator in the top-left of the feed.
*   **Offline Bookmarking Network**: Native `shared_preferences` integration powering the `SavedScreen`. Users can tap the bookmark icon on any `ArticleCard` to instantly save it. These curated articles survive application restarts and device reboots.
*   **Live Target Data Engine**: Integrates natively with the NewsAPI. Formats requests via HTTP to query relevant news sources strictly filtered to user interests and default local queries.  
*   **Interactive Intents**: Entirely interactive layout using `InkWell`. Tapping an article parses the source string securely and deep-links the user to the physical phone browser using `url_launcher`.
*   **Instant Navigation**: Employs an `IndexedStack` to cache the `FeedScreen` and `SavedScreen` in background memory, completely eliminating UI reload flashes or lost scroll states when hopping between tabs.

## 🛠️ Technology Stack

*   **Framework**: Flutter (Dart)
*   **Architecture Pattern**: Provider (State Management)
*   **Networking**: `http` (REST API integration)
*   **Data Persistence**: `shared_preferences` (Offline bookmarks and chosen topics caching)
*   **Environment Protection**: `flutter_dotenv` 
*   **Typography**: `google_fonts` (Newsreader & Work Sans)
*   **Native Capabilities**: `url_launcher`

## 🚀 Getting Started

To run this project, make sure you have the Flutter SDK installed on your machine.

### Prerequisites

1.  **NewsAPI Key**: You must possess a free API key from [NewsAPI.org](https://newsapi.org/).
2.  **Environment Setup**: Create a `.env` file at the root of the project to secure your key.

```bash
# Inside the root of your project
touch .env
```

Inside the `.env` file, place your key like so:
```text
NEWS_API_KEY=your_actual_api_key_here
```

### Installation

1.  Navigate into your project folder.
2.  Install the required dependencies:
```bash
flutter pub get
```
3.  Launch the application on your physical device or emulator:
```bash
flutter run
```

## 📂 Project Structure

```text
lib/
├── data/
│   ├── api/            # HTTP implementations targeting NewsAPI endpoints
│   ├── models/         # Article serialization models (fromJson / toJson)
│   └── repositories/   # Domain logic separating the API layer from providers
├── providers/
│   ├── article_provider.dart         # Manages remote news feeds
│   ├── navigation_provider.dart      # Controls MainScreen's IndexedStack states
│   ├── saved_article_provider.dart   # Controls the offline SharedPreferences memory store
│   └── theme_provider.dart           # Drives the Light/Dark Mode toggler globally
├── screens/
│   ├── explore_screen.dart           # Trending layout module
│   ├── feed_screen.dart              # Core news display (Hero layout + feed)
│   ├── home_screen.dart              # Onboarding categories interface
│   ├── main_screen.dart              # Main hub wiring the BottomNavigationBar
│   ├── saved_screen.dart             # Caches rendered bookmark UI
│   └── splash_screen.dart            # Intelligent routing hub on startup
├── services/
│   └── preferences_service.dart      # Pure offline data handler bridging plugins
├── widgets/
│   ├── article_card.dart             # Reusable interactive card rendering
│   └── category_screen.dart          # Reusable ChoiceChip layouts
└── main.dart                         # Root orchestrator and Theme engine
```

## 🔒 Error Handling
The application actively uses `try-catch` structures around intent link launchers and SharedPreferences JSON marshaling. If an unexpected runtime anomaly happens (corrupted URLs, missing schemes, dead API responses), the app dynamically catches the event without crashing the layout matrix. Wait-states use standard `CircularProgressIndicator` designs, while hard network dropouts render an actionable `Retry` graphic.
