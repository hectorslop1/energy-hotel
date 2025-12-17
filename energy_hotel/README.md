# Energy Hotel App

A premium, modern, Airbnb-style mobile application for hotel guests, built with Flutter.

## Features

- **Authentication**: Email/password login with session persistence
- **Home Screen**: Airbnb-style layout with services, promotions, and quick actions
- **Explore**: Discover nearby places with category filters
- **Interactive Map**: OpenStreetMap integration with markers and bottom sheet details
- **Profile & Settings**: User profile, language selection, biometric toggle

## Tech Stack

- **Framework**: Flutter / Dart
- **State Management**: Riverpod
- **Architecture**: Clean Architecture (Feature-based)
- **Maps**: flutter_map with OpenStreetMap
- **Storage**: flutter_secure_storage, SharedPreferences
- **Biometrics**: local_auth

## Project Structure

```
lib/
├── core/
│   ├── theme/          # App theme, colors, text styles
│   ├── widgets/        # Reusable UI components
│   ├── services/       # Core services (storage, biometrics)
│   ├── utils/          # Validators, formatters
│   └── constants/      # App constants, durations, spacing
│
├── features/
│   ├── auth/           # Authentication feature
│   ├── home/           # Home screen feature
│   ├── explore/        # Explore places feature
│   ├── map/            # Interactive map feature
│   └── profile/        # Profile & settings feature
│
├── l10n/               # Localization files (en, es)
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK ^3.8.1
- Dart SDK ^3.8.1

### Installation

```bash
# Clone the repository
cd energy_hotel

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Demo Credentials

- **Email**: guest@energyhotel.com
- **Password**: password123

## Architecture

This app follows **Clean Architecture** principles:

- **Presentation Layer**: UI widgets, screens, providers (Riverpod)
- **Domain Layer**: Entities, repositories (abstract), use cases
- **Data Layer**: Models, data sources, repository implementations

## Design Principles

- Modern, clean, Airbnb-inspired UI
- Subtle, fast animations (150ms-300ms)
- Offline/local-first demo
- Backend-ready (prepared for Supabase integration)

## License

This project is for demonstration purposes.
