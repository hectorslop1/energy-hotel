// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Energy Hotel';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get loginButton => 'Sign In';

  @override
  String get logout => 'Logout';

  @override
  String get home => 'Home';

  @override
  String get explore => 'Explore';

  @override
  String get map => 'Map';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get biometrics => 'Biometric Authentication';

  @override
  String get enableBiometrics => 'Enable Face ID / Fingerprint';

  @override
  String get wallet => 'Wallet';

  @override
  String get addCard => 'Add Card';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String get defaultCard => 'Default';

  @override
  String get pay => 'Pay';

  @override
  String get book => 'Book Now';

  @override
  String get bookingConfirmed => 'Booking Confirmed';

  @override
  String get paymentSuccess => 'Payment Successful';

  @override
  String get activities => 'Activities';

  @override
  String get restaurants => 'Restaurants';

  @override
  String get amenities => 'Amenities';

  @override
  String get nearbyPlaces => 'Nearby Places';

  @override
  String get featured => 'Featured';

  @override
  String get recommended => 'Recommended for You';

  @override
  String get seeAll => 'See All';

  @override
  String get search => 'Search';

  @override
  String get filters => 'Filters';

  @override
  String get price => 'Price';

  @override
  String get description => 'Description';

  @override
  String get details => 'Details';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get noResults => 'No results found';

  @override
  String greeting(String name) {
    return 'Hello, $name';
  }

  @override
  String get cardNumber => 'Card Number';

  @override
  String get expiryDate => 'Expiry Date';

  @override
  String get cvv => 'CVV';

  @override
  String get cardholderName => 'Cardholder Name';

  @override
  String get saveCard => 'Save Card';

  @override
  String get selectCard => 'Select Payment Method';

  @override
  String get confirmPayment => 'Confirm Payment';

  @override
  String get total => 'Total';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get done => 'Done';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get invalidPassword => 'Password must be at least 6 characters';

  @override
  String get loginFailed => 'Login failed. Please try again.';

  @override
  String get biometricPrompt => 'Authenticate to continue';

  @override
  String get biometricFailed => 'Authentication failed';

  @override
  String get biometricAuth => 'Biometric Login';

  @override
  String get enableBiometricTitle => 'Enable Biometric Login';

  @override
  String get enableBiometricMessage =>
      'Would you like to enable biometric login? This will allow you to sign in faster and more securely using Face ID or Fingerprint.';

  @override
  String get biometricEnabled => 'Biometric login enabled successfully';

  @override
  String get biometricDisabled => 'Biometric login disabled';

  @override
  String get loginWithFaceId => 'Log In with Face ID';

  @override
  String get loginWithFingerprint => 'Log In with Fingerprint';

  @override
  String get biometricNotAvailable =>
      'Biometric authentication is not available on this device';

  @override
  String get enable => 'Enable';

  @override
  String get notNow => 'Not Now';
}
