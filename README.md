# TheBoost - Land Investment Platform

TheBoost is a Flutter application that enables users to invest in tokenized land assets through blockchain technology. The platform allows fractional ownership of premium land properties, making real estate investment accessible to everyone.

## Features

- **Asset Tokenization**: Convert land ownership into digital tokens for fractional investing
- **User Authentication**: Secure login, registration, and account management
- **Investment Dashboard**: Track your portfolio performance and recent activity
- **Property Discovery**: Browse and filter available land investment opportunities
- **Investment Calculator**: Calculate potential returns on investment
- **Responsive Design**: Works seamlessly on mobile, tablet, and desktop

## Architecture

This project follows Clean Architecture principles to maintain separation of concerns and testability:

### Core Layer
- Constants (colors, dimensions, text styles)
- Utility functions
- Reusable widgets

### Domain Layer
- Entities (Property, User, Investment)
- Repository interfaces
- Use cases (business logic)

### Data Layer
- Data models
- Repository implementations
- Mock data services

### Presentation Layer
- Controllers (with Provider state management)
- Pages and UI components
- Navigation

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / Xcode for mobile deployment

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/theboost.git
   ```

2. Navigate to the project directory:
   ```
   cd theboost
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. Run the app:
   ```
   flutter run
   ```

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── utils/
│   └── widgets/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── controllers/
│   ├── pages/
│   └── widgets/
├── routes.dart
├── service_locator.dart
└── main.dart
```

## Key Screens

### Landing Page
Introduces users to the platform and its key features.

### Authentication
Secure login and registration with email verification.

### Dashboard
User portfolio overview, recent activity, and featured investment opportunities.

### Investment Page
Browse, filter, and discover available land investment opportunities.

### Property Details
Detailed information about properties, including investment calculator and purchase flow.

## Tech Stack

- **Flutter**: UI framework
- **Provider**: State management
- **Get_it**: Dependency injection
- **Mock Data**: Currently using mock repositories for development

## Future Enhancements

- Connect to real backend services
- Implement real blockchain integration
- Add payment gateway integration
- Enhance analytics and reporting features
- Add social sharing capabilities

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Thanks to all contributors who have invested their time in improving this project
- Design inspiration from modern fintech and real estate platforms

---

*Note: This is a demonstration project and doesn't involve real financial transactions or land ownership.*
