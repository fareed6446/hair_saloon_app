#!/bin/bash

# Hair Salon App - iOS Setup Script
# This script helps set up the iOS environment for the Hair Salon App

echo "🎯 Hair Salon App - iOS Setup"
echo "=============================="

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n 1)"

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode is not installed. Please install Xcode from the App Store."
    exit 1
fi

echo "✅ Xcode found: $(xcodebuild -version | head -n 1)"

# Navigate to project directory
cd "$(dirname "$0")"

echo ""
echo "📱 Setting up Hair Salon App for iOS..."
echo ""

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting Flutter dependencies..."
flutter pub get

# Generate Hive adapters
echo "🔧 Generating Hive adapters..."
flutter pub run build_runner build --delete-conflicting-outputs

# Install iOS pods
echo "🍎 Installing iOS pods..."
cd ios
pod install --repo-update
cd ..

echo ""
echo "🎉 iOS setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Open ios/Runner.xcworkspace in Xcode"
echo "2. Select your development team in project settings"
echo "3. Update bundle identifier if needed"
echo "4. Connect your iOS device or start simulator"
echo "5. Run: flutter run"
echo ""
echo "🚀 To run the app:"
echo "   flutter run"
echo ""
echo "📱 To build for release:"
echo "   flutter build ios --release"
echo ""
echo "Happy coding! 💈✨"

