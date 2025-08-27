# visiting_card_generator

A new Flutter project.

## Getting Started

# Visiting Card Generator App

A Flutter application that allows professionals to create customizable digital visiting cards with social media links and icons, enabling quick profile sharing and enhanced networking efficiency.

## Features

- **Create & Customize Visiting Cards**: Design professional digital visiting cards with personal and professional information
- **Multiple Templates**: Choose from 3 different card templates (Professional, Modern, Minimal)
- **Social Media Integration**: Add social media links with automatic icon detection and URL generation
- **PDF Generation**: Download visiting cards as shareable PDF files
- **Share Functionality**: Instantly share your digital visiting card with contacts
- **Theme Customization**: Select from predefined themes or customize colors to match your brand
- **Multiple Card Management**: Create, edit, and manage multiple visiting cards

## Screenshots

### Main Features:
- **Home Screen**: Manage all your visiting cards
- **Card Creation**: Fill in your details with an intuitive form
- **Social Media Links**: Add links to LinkedIn, Twitter, GitHub, Instagram, and more
- **Card Preview**: View your card in different templates before downloading
- **PDF Export**: Generate and share professional PDFs

## Technology Stack

- **Flutter**: Cross-platform mobile framework
- **Dart**: Programming language
- **PDF Generation**: `pdf` and `printing` packages
- **Social Media**: `url_launcher` for opening social links
- **File Sharing**: `share_plus` for sharing generated PDFs
- **Icons**: `font_awesome_flutter` for social media icons

## Installation

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter plugins
- Android/iOS device or emulator

### Setup Steps

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/visiting_card_generator.git
cd visiting_card_generator
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

## Project Structure

```
visiting_card_generator/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/
│   │   ├── visiting_card.dart    # Visiting card data model
│   │   └── social_media_link.dart# Social media link model
│   ├── screens/
│   │   ├── home_screen.dart      # Main screen with card list
│   │   ├── card_form_screen.dart # Card creation/editing form
│   │   └── card_preview_screen.dart # Card preview and export
│   ├── services/
│   │   └── pdf_service.dart      # PDF generation service
│   └── widgets/
│       └── card_templates.dart   # Card template widgets
├── pubspec.yaml                   # Package dependencies
└── README.md                      # Documentation
```

## Usage Guide

### Creating a New Visiting Card

1. **Open the app** and tap the "Create New Card" button
2. **Fill in your details**:
   - Personal Information (Name, Profession, Company)
   - Contact Information (Email, Phone, Address, Website)
   - Short Bio (Optional)
3. **Add Social Media Links**:
   - Click "Add Social Link"
   - Select platform (LinkedIn, Twitter, GitHub, etc.)
   - Enter your username/handle
4. **Customize Appearance**:
   - Choose a theme (Professional, Creative, Minimal, Dark, Colorful)
   - Select primary and secondary colors
5. **Save** your card

### Generating and Sharing PDFs

1. **Preview your card** by tapping the view icon
2. **Select a template** (Template 1, 2, or 3)
3. **Download PDF** - saves to device storage
4. **Share** - instantly share via email, WhatsApp, etc.

### Managing Cards

- **Edit**: Tap the edit icon to modify card details
- **Delete**: Remove unwanted cards with confirmation
- **Preview**: View cards before exporting

## Supported Social Platforms

- LinkedIn
- Twitter/X
- Facebook
- Instagram
- GitHub
- YouTube
- WhatsApp
- Email
- Phone
- Personal Website

## Key Features Implementation

### Social Media Integration
The app automatically generates social media URLs based on usernames and provides quick redirection to profiles when links are tapped.

### PDF Generation
High-quality PDF generation with three different templates, maintaining design consistency and professional appearance.

### Data Persistence
Cards are temporarily stored in app memory during the session. For production, consider implementing:
- Local storage using SQLite
- Cloud sync with Firebase
- Export/Import functionality

## Development

### Running Tests
```bash
flutter test
```

### Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Future Enhancements

- [ ] QR Code generation for instant card sharing
- [ ] Cloud storage and sync
- [ ] Multiple card designs and layouts
- [ ] Analytics for card views and shares
- [ ] NFC support for contactless sharing
- [ ] Batch export functionality
- [ ] Import contacts from phone
- [ ] Custom fonts and styling options
- [ ] Business card scanner using OCR
- [ ] Team/Company card management

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, email support@visitingcardgenerator.com or open an issue in the GitHub repository.

## Acknowledgments

- Flutter team for the amazing framework
- Package contributors for pdf, printing, and share_plus
- Font Awesome for social media icons
- Community contributors and testers

---

**Developed with ❤️ using Flutter**
