# Hair Salon App - Flutter

A professional Hair Salon booking application built with Flutter, GetX for state management, and Hive for local data storage.

## Features

### 🎯 **17 Complete Screens**

✨ **Onboarding & Authentication (5 Screens)**

- Beautiful 3-page onboarding (first-time users)
- Splash screen with smart routing
- Login with phone number
- Registration with validation
- Persistent sessions with Hive

💇 **Service Browsing & Booking (6 Screens)**

- Service catalog with images
- Detailed service information
- Package selection
- Date & time picker
- Stylist selection (optional)
- Booking confirmation
- Booking history (Upcoming/Past/Cancelled tabs)
- Booking details with status

🎁 **Loyalty & Rewards (2 Screens)**

- Loyalty program overview
- Points balance display
- Transaction history
- Rewards tiers
- Program rules

👤 **Profile & Account (7 Screens)**

- User profile display
- Edit profile (name, email)
- Change password
- Notifications center
- Settings & preferences
- Help & Support with FAQs
- About page

📬 **Additional Features**

- Real-time notifications
- Offline data caching
- Pull to refresh
- Empty states
- Loading states
- Error handling

## Tech Stack

- **Framework**: Flutter 3.8+
- **State Management**: GetX 4.6+
- **Local Database**: Hive 2.2+
- **HTTP Client**: Dio 5.4+
- **Date Formatting**: intl 0.19+
- **Image Caching**: cached_network_image 3.3+
- **Architecture**: MVC Pattern

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── bindings/                # Dependency injection
│   └── initial_binding.dart
├── constants/               # App constants
│   ├── app_colors.dart
│   ├── app_constants.dart
│   └── app_theme.dart
├── controllers/             # GetX controllers (4)
│   ├── auth_controller.dart
│   ├── booking_controller.dart
│   ├── notification_controller.dart
│   └── service_controller.dart
├── models/                  # Data models with Hive (8)
│   ├── booking_model.dart
│   ├── loyalty_transaction_model.dart
│   ├── notification_model.dart
│   ├── onboarding_model.dart
│   ├── service_model.dart
│   ├── stylist_model.dart
│   ├── time_slot_model.dart
│   └── user_model.dart
├── routes/                  # Navigation routes
│   ├── app_pages.dart (18 routes)
│   └── app_routes.dart
├── services/                # Services layer
│   ├── api_service.dart
│   └── hive_service.dart
├── utils/                   # Utility functions
│   ├── date_formatter.dart
│   └── validators.dart
└── views/                   # UI layer
    ├── screens/            # 17 Complete Screens
    │   ├── about_screen.dart ⭐NEW
    │   ├── booking_detail_screen.dart
    │   ├── bookings_screen.dart
    │   ├── create_booking_screen.dart
    │   ├── edit_profile_screen.dart ⭐NEW
    │   ├── help_support_screen.dart ⭐NEW
    │   ├── home_screen.dart
    │   ├── login_screen.dart
    │   ├── loyalty_history_screen.dart ⭐NEW
    │   ├── loyalty_program_screen.dart ⭐NEW
    │   ├── notifications_screen.dart ⭐NEW
    │   ├── onboarding_screen.dart ⭐NEW
    │   ├── profile_screen.dart
    │   ├── register_screen.dart
    │   ├── select_stylist_screen.dart ⭐NEW
    │   ├── service_detail_screen.dart
    │   ├── settings_screen.dart ⭐NEW
    │   └── splash_screen.dart
    └── widgets/
        ├── booking_card.dart
        └── service_card.dart
```

## Installation

### Prerequisites

- Flutter SDK (3.8.0 or higher)
- Dart SDK (3.8.0 or higher)
- Android Studio / VS Code with Flutter plugins
- A device or emulator for testing

### Steps

1. **Clone the repository**

   ```bash
   cd hair_salon_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters**

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Configure API endpoint**

   Update the base URL in `lib/constants/app_constants.dart`:

   ```dart
   static const String baseUrl = 'YOUR_API_URL/api';
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## Configuration

### API Base URL

Set your backend API URL in `lib/constants/app_constants.dart`:

```dart
static const String baseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://127.0.0.1:8000/api',
);
```

Or use environment variables:

```bash
flutter run --dart-define=API_BASE_URL=https://your-api.com/api
```

### Business Rules

Configure loyalty program and booking rules in `lib/constants/app_constants.dart`:

- `loyaltyPointsPerHundred`: Points earned per 100 PKR
- `minPointsForRedemption`: Minimum points required for redemption
- `maxBookingDaysInAdvance`: How far ahead users can book (days)
- `apiTimeout`: API request timeout duration

## Features in Detail

### Authentication Flow

1. **Splash Screen** → Checks if user is logged in
2. **Login/Register** → JWT token authentication
3. **Home Screen** → Main dashboard with services

### Booking Flow

1. **Browse Services** → View all available services
2. **Service Details** → View packages and pricing
3. **Create Booking** → Select date, time, and package
4. **Confirmation** → Booking created and saved locally
5. **View Bookings** → Track upcoming and past bookings

### Offline Support

- Services cached locally using Hive
- Bookings stored for offline viewing
- User profile cached
- Automatic sync when online

## API Integration

The app expects a REST API with the following endpoints:

```
POST   /api/auth/register    - User registration
POST   /api/auth/login       - User login
POST   /api/auth/logout      - User logout
GET    /api/auth/me          - Get current user
GET    /api/services         - List all services
GET    /api/services/:id     - Get service details
GET    /api/time-slots       - Get available time slots
POST   /api/bookings         - Create booking
GET    /api/users/:id/bookings - Get user bookings
POST   /api/bookings/:id/cancel - Cancel booking
```

See the Laravel backend documentation in the parent project for API details.

## Testing

Run tests with:

```bash
flutter test
```

Check for code issues:

```bash
flutter analyze
```

## Building for Production

### Android

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## Troubleshooting

### Hive Adapter Errors

If you encounter Hive adapter errors, regenerate them:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### API Connection Issues

- Check `baseUrl` in `app_constants.dart`
- Ensure backend is running
- Check network permissions in AndroidManifest.xml

### Build Errors

```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## Future Enhancements

- [ ] Push notifications for booking reminders
- [ ] Social media authentication (Google, Apple)
- [ ] Payment gateway integration
- [ ] Stylist rating system
- [ ] Photo gallery for services
- [ ] Multi-language support
- [ ] Dark mode toggle
- [ ] In-app chat with salon

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is for educational and commercial purposes.

## Support

For issues and questions:

- Create an issue in the repository
- Contact: support@hairsalon.com

## Authors

- Development Team - Hair Salon App

---

**Note**: This app requires a backend API server. See the Laravel backend code in the parent project directory for complete backend implementation.
