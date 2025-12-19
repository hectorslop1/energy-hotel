import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': _enTranslations,
    'es': _esTranslations,
  };

  String get(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }

  // Common
  String get appName => get('app_name');
  String get welcome => get('welcome');
  String get hello => get('hello');
  String get guest => get('guest');
  String get home => get('home');

  // Home
  String get welcomeToHotel => get('welcome_to_hotel');
  String get quickActions => get('quick_actions');
  String get featuredServices => get('featured_services');
  String get promotions => get('promotions');
  String get checkIn => get('check_in');
  String get checkOut => get('check_out');
  String get daysRemaining => get('days_remaining');
  String get extendStay => get('extend_stay');
  String get roomNumber => get('room_number');

  // Quick Actions
  String get spa => get('spa');
  String get dining => get('dining');
  String get pool => get('pool');
  String get roomService => get('room_service');

  // Profile
  String get profile => get('profile');
  String get services => get('services');
  String get myReservations => get('my_reservations');
  String get upcoming => get('upcoming');
  String get past => get('past');
  String get noReservations => get('no_reservations');
  String get seeAll => get('see_all');
  String get cancel => get('cancel');
  String get cancelReservation => get('cancel_reservation');

  // Settings
  String get settings => get('settings');
  String get language => get('language');
  String get selectLanguage => get('select_language');
  String get notifications => get('notifications');
  String get biometricAuth => get('biometric_auth');
  String get paymentMethods => get('payment_methods');
  String get helpSupport => get('help_support');
  String get logout => get('logout');
  String get logoutConfirm => get('logout_confirm');

  // Biometric Authentication
  String get enableBiometrics => get('enable_biometrics');
  String get enableBiometricTitle => get('enable_biometric_title');
  String get enableBiometricMessage => get('enable_biometric_message');
  String get biometricEnabled => get('biometric_enabled');
  String get biometricDisabled => get('biometric_disabled');
  String get loginWithFaceId => get('login_with_face_id');
  String get loginWithFingerprint => get('login_with_fingerprint');
  String get biometricNotAvailable => get('biometric_not_available');
  String get biometricPrompt => get('biometric_prompt');
  String get biometricFailed => get('biometric_failed');
  String get enable => get('enable');
  String get notNow => get('not_now');

  // Services
  String get roomKey => get('room_key');
  String get billing => get('billing');
  String get rewards => get('rewards');
  String get chat => get('chat');
  String get housekeeping => get('housekeeping');
  String get transport => get('transport');
  String get activities => get('activities');
  String get hotelInfo => get('hotel_info');
  String get feedback => get('feedback');
  String get rateExperience => get('rate_experience');

  // Map
  String get map => get('map');
  String get searchNearby => get('search_nearby');
  String get restaurants => get('restaurants');
  String get attractions => get('attractions');
  String get shopping => get('shopping');
  String get nightlife => get('nightlife');

  // Explore
  String get explore => get('explore');
  String get all => get('all');
  String get viewDetails => get('view_details');
  String get bookNow => get('book_now');

  // Booking
  String get selectDate => get('select_date');
  String get selectTime => get('select_time');
  String get guests => get('guests');
  String get confirm => get('confirm');
  String get confirmed => get('confirmed');
  String get bookingConfirmed => get('booking_confirmed');
  String get total => get('total');
  String get free => get('free');

  // Notifications
  String get noNotifications => get('no_notifications');
  String get markAllRead => get('mark_all_read');

  // Room Key
  String get digitalRoomKey => get('digital_room_key');
  String get tapToUnlock => get('tap_to_unlock');
  String get unlocking => get('unlocking');
  String get doorUnlocked => get('door_unlocked');

  // Billing
  String get currentBalance => get('current_balance');
  String get charges => get('charges');
  String get payNow => get('pay_now');
  String get addTip => get('add_tip');
  String get paymentSuccessful => get('payment_successful');

  // Housekeeping
  String get cleaningServices => get('cleaning_services');
  String get amenities => get('amenities');
  String get schedule => get('schedule');
  String get doNotDisturb => get('do_not_disturb');
  String get submitRequest => get('submit_request');
  String get requestSubmitted => get('request_submitted');

  // Transport
  String get transportation => get('transportation');
  String get taxi => get('taxi');
  String get privateCar => get('private_car');
  String get airportShuttle => get('airport_shuttle');
  String get valetService => get('valet_service');
  String get carRental => get('car_rental');
  String get requestNow => get('request_now');

  // Activities
  String get activitiesEvents => get('activities_events');
  String get events => get('events');
  String get tours => get('tours');
  String get classes => get('classes');
  String get sports => get('sports');
  String get spotsLeft => get('spots_left');

  // Loyalty
  String get loyaltyRewards => get('loyalty_rewards');
  String get availablePoints => get('available_points');
  String get tierProgress => get('tier_progress');
  String get yourBenefits => get('your_benefits');
  String get redeemRewards => get('redeem_rewards');
  String get pointsHistory => get('points_history');
  String get currentTier => get('current_tier');
  String get availableRewards => get('available_rewards');

  // Feedback
  String get overallRating => get('overall_rating');
  String get submitFeedback => get('submit_feedback');
  String get thankYou => get('thank_you');

  // Hotel Info
  String get hotelInformation => get('hotel_information');
  String get wifi => get('wifi');
  String get contacts => get('contacts');
  String get emergencyContacts => get('emergency_contacts');

  // Chat
  String get concierge => get('concierge');
  String get online => get('online');
  String get typeMessage => get('type_message');

  // Common Actions
  String get done => get('done');
  String get save => get('save');
  String get edit => get('edit');
  String get delete => get('delete');
  String get close => get('close');
  String get back => get('back');
  String get next => get('next');
  String get continue_ => get('continue');
  String get loading => get('loading');
  String get error => get('error');
  String get retry => get('retry');
  String get success => get('success');

  // Login
  String get welcomeTo => get('welcome_to');
  String get signIn => get('sign_in');
  String get enterCredentials => get('enter_credentials');
  String get emailAddress => get('email_address');
  String get password => get('password');
  String get languageChangedTo => get('language_changed_to');

  // Errors
  String get errorLoadingPromotions => get('error_loading_promotions');
  String get errorLoadingServices => get('error_loading_services');

  // Misc
  String get perNight => get('per_night');
  String get nights => get('nights');
  String get additionalNights => get('additional_nights');
  String get newCheckoutDate => get('new_checkout_date');
  String get confirmExtension => get('confirm_extension');
  String get stayExtended => get('stay_extended');
  String get description => get('description');
  String get about => get('about');
  String get location => get('location');
  String get viewOnMap => get('view_on_map');
  String get highlights => get('highlights');
  String get reviews => get('reviews');
  String get change => get('change');
  String get customize => get('customize');
  String get preOrderSummary => get('pre_order_summary');
  String get estimatedTotal => get('estimated_total');
  String get preOrder => get('pre_order');
  String get startingFrom => get('starting_from');
  String get bookingSummary => get('booking_summary');
  String get requestServicesAmenities => get('request_services_amenities');
  String get preferredTime => get('preferred_time');
  String get rateByCategory => get('rate_by_category');
  String get passwordCopied => get('password_copied');
  String get termsAndConditions => get('terms_and_conditions');
  String get deliveryInstructions => get('delivery_instructions');
  String get addedToFavorites => get('added_to_favorites');
  String get shareLinkCopied => get('share_link_copied');
  String get reservationCancelled => get('reservation_cancelled');
  String get from => get('from');
  String get callingFrontDesk => get('calling_front_desk');
  String get reserveTable => get('reserve_table');
  String get bookActivity => get('book_activity');
  String get getTickets => get('get_tickets');
  String get claimOffer => get('claim_offer');
  String get reserving => get('reserving');
  String get viewCart => get('view_cart');
  String get addItemsToOrder => get('add_items_to_order');
  String get placingOrder => get('placing_order');
  String get continueText => get('continue_text');
  String get breakfast => get('breakfast');
  String get lunch => get('lunch');
  String get dinner => get('dinner');
  String get snacks => get('snacks');
  String get food => get('food');
  String get sights => get('sights');
  String get searchNearbyPlaces => get('search_nearby_places');
  String get restaurant => get('restaurant');
  String get validUntil => get('valid_until');
  String get orderFoodToYourRoom => get('order_food_to_your_room');
  String get reserve => get('reserve');
  String get reserveSpot => get('reserve_spot');
  String get ticketsBooked => get('tickets_booked');
  String get dealClaimed => get('deal_claimed');
  String get spotReserved => get('spot_reserved');
  String get confirmBooking => get('confirm_booking');
  String get requestService => get('request_service');
  String get submitting => get('submitting');
  String get enterDestination => get('enter_destination');
  String get connectionSpeed => get('connection_speed');
  String get deviceLimit => get('device_limit');
  String get coverage => get('coverage');
  String get needHelp => get('need_help');
  String get upTo100Mbps => get('up_to_100_mbps');
  String get devicesPerRoom => get('devices_per_room');
  String get availableThroughout => get('available_throughout');
  String get callItSupport => get('call_it_support');
  String get selectTreatmentCategory => get('select_treatment_category');
  String get chooseYourTreatment => get('choose_your_treatment');
  String get attraction => get('attraction');
  String get justNow => get('just_now');
  String get minutesAgo => get('minutes_ago');
  String get hoursAgo => get('hours_ago');
  String get daysAgo => get('days_ago');

  // Billing categories
  String get accommodation => get('accommodation');
  String get minibar => get('minibar');

  // Rewards
  String get goldMember => get('gold_member');
  String get memberSince => get('member_since');
  String get tier => get('tier');
  String get toNext => get('to_next');
  String get tenOffDining => get('ten_off_dining');
  String get lateCheckout => get('late_checkout');
  String get roomUpgrade => get('room_upgrade');
  String get spaDiscount => get('spa_discount');

  // Housekeeping tabs and services
  String get cleaning => get('cleaning');
  String get housekeepingWillNotEnter => get('housekeeping_will_not_enter');
  String get fullRoomCleaning => get('full_room_cleaning');
  String get fullRoomCleaningDesc => get('full_room_cleaning_desc');
  String get quickTidyUp => get('quick_tidy_up');
  String get quickTidyUpDesc => get('quick_tidy_up_desc');
  String get turndownService => get('turndown_service');
  String get turndownServiceDesc => get('turndown_service_desc');
  String get selectServicesOrAmenities => get('select_services_or_amenities');

  // Amenities
  String get extraTowels => get('extra_towels');
  String get extraPillows => get('extra_pillows');
  String get extraBlanket => get('extra_blanket');
  String get toiletriesKit => get('toiletries_kit');
  String get bathrobe => get('bathrobe');
  String get slippers => get('slippers');
  String get ironAndBoard => get('iron_and_board');
  String get extraHangers => get('extra_hangers');
  String get coffeeTeaRefill => get('coffee_tea_refill');

  // Schedule
  String get anytime => get('anytime');
  String get firstAvailable => get('first_available');
  String get morning => get('morning');
  String get afternoon => get('afternoon');
  String get evening => get('evening');
  String get requestsFulfilledInfo => get('requests_fulfilled_info');

  // Transport
  String get selectAService => get('select_a_service');
  String get standardTaxiService => get('standard_taxi_service');
  String get metered => get('metered');
  String get sedanWithDriver => get('sedan_with_driver');
  String get spaciousSuvForGroups => get('spacious_suv_for_groups');
  String get directToFromAirport => get('direct_to_from_airport');
  String get scheduled => get('scheduled');
  String get retrieveYourParkedCar => get('retrieve_your_parked_car');
  String get included => get('included');

  // Hotel Info tabs and content
  String get swimmingPool => get('swimming_pool');
  String get groundFloor => get('ground_floor');
  String get towelsAvailableAtPoolDeck => get('towels_available_at_pool_deck');
  String get fitnessCenter => get('fitness_center');
  String get twentyFourHours => get('twenty_four_hours');
  String get secondFloor => get('second_floor');
  String get roomKeyRequiredForAccess => get('room_key_required_for_access');
  String get thirdFloor => get('third_floor');
  String get reservationsRecommended => get('reservations_recommended');
  String get businessCenter => get('business_center');
  String get lobbyLevel => get('lobby_level');
  String get printingServicesAvailable => get('printing_services_available');
  String get kidsClub => get('kids_club');
  String get agesSupervisionIncluded => get('ages_supervision_included');
  String get giftShop => get('gift_shop');

  // Contacts
  String get valet => get('valet');
  String get security => get('security');

  // Promotions
  String get validForHotelGuestsOnly => get('valid_for_hotel_guests_only');
  String get cannotBeCombined => get('cannot_be_combined');
  String get subjectToAvailability => get('subject_to_availability');
  String get nonTransferable => get('non_transferable');

  // Service detail
  String get min => get('min');

  String get complimentary => get('complimentary');
  String get freeEntry => get('free_entry');
  String get capacity => get('capacity');
  String get upToGuests => get('up_to_guests');
  String get duration => get('duration');
  String get price => get('price');
  String get available => get('available');
  String get hours => get('hours');
  String get minutes => get('minutes');
  String get person => get('person');
  String get people => get('people');
  String get selectTreatment => get('select_treatment');
  String get selectRestaurant => get('select_restaurant');
  String get makeReservation => get('make_reservation');
  String get orderItems => get('order_items');
  String get addToOrder => get('add_to_order');
  String get placeOrder => get('place_order');
  String get orderPlaced => get('order_placed');
  String get estimatedDelivery => get('estimated_delivery');
  String get quantity => get('quantity');
  String get subtotal => get('subtotal');
  String get tax => get('tax');
  String get tips => get('tips');
  String get grandTotal => get('grand_total');
  String get paymentMethod => get('payment_method');
  String get roomCharge => get('room_charge');
  String get creditCard => get('credit_card');
  String get cash => get('cash');
  String get pickup => get('pickup');
  String get destination => get('destination');
  String get requestTransport => get('request_transport');
  String get transportRequested => get('transport_requested');
  String get driverOnWay => get('driver_on_way');
  String get register => get('register');
  String get joinEvent => get('join_event');
  String get spotsAvailable => get('spots_available');
  String get points => get('points');
  String get redeem => get('redeem');
  String get earnedPoints => get('earned_points');
  String get usedPoints => get('used_points');
  String get howWasYourStay => get('how_was_your_stay');
  String get leaveComment => get('leave_comment');
  String get feedbackSubmitted => get('feedback_submitted');
  String get wifiName => get('wifi_name');
  String get wifiPassword => get('wifi_password');
  String get frontDesk => get('front_desk');
  String get roomServicePhone => get('room_service_phone');
  String get emergency => get('emergency');
  String get police => get('police');
  String get ambulance => get('ambulance');
  String get fireDepartment => get('fire_department');

  // Billing
  String get billingWallet => get('billing_wallet');
  String get topCharges => get('top_charges');
  String get payYourBill => get('pay_your_bill');
  String get addPaymentMethod => get('add_payment_method');
  String get defaultCard => get('default_card');
  String get expires => get('expires');
  String get tip => get('tip');
  String get none => get('none');
  String get processing => get('processing');
  String get pay => get('pay');
  String get today => get('today');
  String get yesterday => get('yesterday');

  // Spa
  String get spaWellness => get('spa_wellness');
  String get selectCategory => get('select_category');
  String get chooseTreatment => get('choose_treatment');
  String get addEnhancements => get('add_enhancements');
  String get selectDateTime => get('select_date_time');
  String get enhanceExperience => get('enhance_experience');
  String get addExtraTreatments => get('add_extra_treatments');
  String get therapistPreference => get('therapist_preference');
  String get specialRequests => get('special_requests');
  String get anyAllergies => get('any_allergies');
  String get spaBooked => get('spa_booked');
  String get relaxPrepare => get('relax_prepare');

  // Dining
  String get chooseRestaurant => get('choose_restaurant');
  String get preOrderDishes => get('pre_order_dishes');
  String get tableReserved => get('table_reserved');
  String get diningAwaits => get('dining_awaits');
  String get itemsPreOrdered => get('items_pre_ordered');
  String get preOrderOptional => get('pre_order_optional');
  String get skipPreOrder => get('skip_pre_order');

  // Room Service
  String get roomServiceTitle => get('room_service_title');
  String get selectItems => get('select_items');
  String get reviewOrder => get('review_order');
  String get deliveryTime => get('delivery_time');
  String get orderSummary => get('order_summary');
  String get deliveryFee => get('delivery_fee');
  String get orderConfirmed => get('order_confirmed');
  String get preparingOrder => get('preparing_order');

  // Activities
  String get upcomingEvents => get('upcoming_events');
  String get allActivities => get('all_activities');
  String get joinNow => get('join_now');
  String get registered => get('registered');
  String get full => get('full');

  // Housekeeping
  String get requestCleaning => get('request_cleaning');
  String get requestAmenities => get('request_amenities');
  String get scheduleCleaning => get('schedule_cleaning');
  String get asap => get('asap');
  String get inOneHour => get('in_one_hour');
  String get inTwoHours => get('in_two_hours');
  String get tomorrow => get('tomorrow');

  // Transport
  String get selectVehicle => get('select_vehicle');
  String get pickupLocation => get('pickup_location');
  String get hotelLobby => get('hotel_lobby');
  String get estimatedArrival => get('estimated_arrival');
  String get vehicleRequested => get('vehicle_requested');

  // Feedback
  String get rateYourExperience => get('rate_your_experience');
  String get tapToRate => get('tap_to_rate');
  String get additionalComments => get('additional_comments');
  String get submit => get('submit');

  // Hotel Info
  String get hotelAmenities => get('hotel_amenities');
  String get checkInTime => get('check_in_time');
  String get checkOutTime => get('check_out_time');
  String get copyToClipboard => get('copy_to_clipboard');
  String get copied => get('copied');

  // Chat
  String get chatWithConcierge => get('chat_with_concierge');
  String get howCanIHelp => get('how_can_i_help');

  // Common
  String get room => get('room');
  String get date => get('date');
  String get time => get('time');
  String get optional => get('optional');
  String get required => get('required');
  String get select => get('select');
  String get selected => get('selected');
  String get add => get('add');
  String get remove => get('remove');
  String get clear => get('clear');
  String get apply => get('apply');
  String get reset => get('reset');
  String get search => get('search');
  String get filter => get('filter');
  String get sort => get('sort');
  String get more => get('more');
  String get less => get('less');
  String get show => get('show');
  String get hide => get('hide');
  String get yes => get('yes');
  String get no => get('no');
  String get ok => get('ok');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}

// English translations
const Map<String, String> _enTranslations = {
  'app_name': 'Energy Hotel',
  'welcome': 'Welcome',
  'hello': 'Hello',
  'guest': 'Guest',
  'home': 'Home',
  'welcome_to_hotel': 'Welcome to Energy Hotel',
  'quick_actions': 'Quick Actions',
  'featured_services': 'Featured Services',
  'promotions': 'Promotions',
  'check_in': 'Check In',
  'check_out': 'Check Out',
  'days_remaining': 'days remaining',
  'extend_stay': 'Extend Stay',
  'room_number': 'Room',
  'spa': 'Spa',
  'dining': 'Dining',
  'pool': 'Pool',
  'room_service': 'Room Service',
  'profile': 'Profile',
  'services': 'Services',
  'my_reservations': 'My Reservations',
  'upcoming': 'Upcoming',
  'past': 'Past',
  'no_reservations': 'No reservations yet',
  'see_all': 'See All',
  'cancel': 'Cancel',
  'cancel_reservation': 'Cancel Reservation',
  'settings': 'Settings',
  'language': 'Language',
  'select_language': 'Select Language',
  'notifications': 'Notifications',
  'biometric_auth': 'Biometric Authentication',
  'payment_methods': 'Payment Methods',
  'help_support': 'Help & Support',
  'logout': 'Logout',
  'logout_confirm': 'Are you sure you want to logout?',
  'room_key': 'Room Key',
  'billing': 'Billing',
  'rewards': 'Rewards',
  'chat': 'Chat',
  'housekeeping': 'Housekeeping',
  'transport': 'Transport',
  'activities': 'Activities',
  'hotel_info': 'Hotel Info',
  'feedback': 'Feedback',
  'rate_experience': 'Rate Your Experience',
  'map': 'Map',
  'search_nearby': 'Search nearby places...',
  'restaurants': 'Restaurants',
  'attractions': 'Attractions',
  'shopping': 'Shopping',
  'nightlife': 'Nightlife',
  'explore': 'Explore',
  'all': 'All',
  'view_details': 'View Details',
  'book_now': 'Book Now',
  'select_date': 'Select Date',
  'select_time': 'Select Time',
  'guests': 'Guests',
  'confirm': 'Confirm',
  'confirmed': 'Confirmed',
  'booking_confirmed': 'Booking Confirmed!',
  'total': 'Total',
  'free': 'FREE',
  'no_notifications': 'No notifications',
  'mark_all_read': 'Mark all read',
  'digital_room_key': 'Digital Room Key',
  'tap_to_unlock': 'TAP TO UNLOCK',
  'unlocking': 'UNLOCKING...',
  'door_unlocked': 'DOOR UNLOCKED',
  'current_balance': 'Current Balance',
  'charges': 'Charges',
  'pay_now': 'Pay Now',
  'add_tip': 'Add a Tip',
  'payment_successful': 'Payment Successful!',
  'cleaning_services': 'Cleaning Services',
  'amenities': 'Amenities',
  'schedule': 'Schedule',
  'do_not_disturb': 'Do Not Disturb',
  'submit_request': 'Submit Request',
  'request_submitted': 'Request Submitted!',
  'transportation': 'Transportation',
  'taxi': 'Taxi',
  'private_car': 'Private Car',
  'airport_shuttle': 'Airport Shuttle',
  'valet_service': 'Valet Service',
  'car_rental': 'Car Rental',
  'request_now': 'Request Now',
  'activities_events': 'Activities & Events',
  'events': 'Events',
  'tours': 'Tours',
  'classes': 'Classes',
  'sports': 'Sports',
  'spots_left': 'spots left',
  'loyalty_rewards': 'Energy Rewards',
  'available_points': 'Available Points',
  'tier_progress': 'Tier Progress',
  'your_benefits': 'Your Benefits',
  'redeem_rewards': 'Redeem Rewards',
  'points_history': 'Points History',
  'overall_rating': 'Overall Rating',
  'submit_feedback': 'Submit Feedback',
  'thank_you': 'Thank You!',
  'hotel_information': 'Hotel Information',
  'wifi': 'WiFi',
  'contacts': 'Contacts',
  'emergency_contacts': 'Emergency Contacts',
  'concierge': 'Concierge',
  'online': 'Online',
  'type_message': 'Type a message...',
  'done': 'Done',
  'save': 'Save',
  'edit': 'Edit',
  'delete': 'Delete',
  'close': 'Close',
  'back': 'Back',
  'next': 'Next',
  'continue': 'Continue',
  'loading': 'Loading...',
  'error': 'Error',
  'retry': 'Retry',
  'success': 'Success',
  // Login
  'welcome_to': 'Welcome to',
  'sign_in': 'Sign In',
  'enter_credentials': 'Enter your credentials to continue',
  'email_address': 'Email Address',
  'password': 'Password',
  'language_changed_to': 'Language changed to',
  // Errors
  'error_loading_promotions': 'Error loading promotions',
  'error_loading_services': 'Error loading services',
  // Misc
  'per_night': 'per night',
  'nights': 'nights',
  'additional_nights': 'Additional Nights',
  'new_checkout_date': 'New Checkout Date',
  'confirm_extension': 'Confirm Extension',
  'stay_extended': 'Stay Extended!',
  'description': 'Description',
  'duration': 'Duration',
  'price': 'Price',
  'available': 'Available',
  'hours': 'hours',
  'minutes': 'minutes',
  'person': 'person',
  'people': 'people',
  'select_treatment': 'Select Treatment',
  'select_restaurant': 'Select Restaurant',
  'make_reservation': 'Make Reservation',
  'order_items': 'Order Items',
  'add_to_order': 'Add to Order',
  'place_order': 'Place Order',
  'order_placed': 'Order Placed!',
  'estimated_delivery': 'Estimated Delivery',
  'quantity': 'Quantity',
  'subtotal': 'Subtotal',
  'tax': 'Tax',
  'tips': 'Tips',
  'grand_total': 'Grand Total',
  'payment_method': 'Payment Method',
  'room_charge': 'Room Charge',
  'credit_card': 'Credit Card',
  'cash': 'Cash',
  'pickup': 'Pickup',
  'destination': 'Destination',
  'request_transport': 'Request Transport',
  'transport_requested': 'Transport Requested!',
  'driver_on_way': 'Driver on the way',
  'register': 'Register',
  'join_event': 'Join Event',
  'spots_available': 'spots available',
  'points': 'Points',
  'redeem': 'Redeem',
  'earned_points': 'Earned Points',
  'used_points': 'Used Points',
  'how_was_your_stay': 'How was your stay?',
  'leave_comment': 'Leave a comment...',
  'feedback_submitted': 'Feedback Submitted!',
  'wifi_name': 'WiFi Name',
  'wifi_password': 'WiFi Password',
  'front_desk': 'Front Desk',
  'room_service_phone': 'Room Service',
  'emergency': 'Emergency',
  'police': 'Police',
  'ambulance': 'Ambulance',
  'fire_department': 'Fire Department',
  // Billing
  'billing_wallet': 'Billing & Wallet',
  'top_charges': 'Top Charges',
  'pay_your_bill': 'Pay Your Bill',
  'add_payment_method': 'Add Payment Method',
  'default_card': 'Default',
  'expires': 'Expires',
  'tip': 'Tip',
  'none': 'None',
  'processing': 'Processing...',
  'pay': 'Pay',
  'today': 'Today',
  'yesterday': 'Yesterday',
  // Spa
  'spa_wellness': 'Spa & Wellness',
  'select_category': 'Select treatment category',
  'choose_treatment': 'Choose your treatment',
  'add_enhancements': 'Add enhancements',
  'select_date_time': 'Select date & time',
  'enhance_experience': 'Enhance Your Experience',
  'add_extra_treatments': 'Add extra treatments to your session',
  'therapist_preference': 'Therapist Preference',
  'special_requests': 'Special Requests',
  'any_allergies': 'Any allergies, preferences, or special needs...',
  'spa_booked': 'Spa Appointment Booked!',
  'relax_prepare': 'Relax and prepare for your treatment.',
  // Dining
  'choose_restaurant': 'Choose a restaurant',
  'pre_order_dishes': 'Pre-order dishes (optional)',
  'table_reserved': 'Table Reserved!',
  'dining_awaits': 'Your dining experience awaits.',
  'items_pre_ordered': 'items pre-ordered',
  'pre_order_optional':
      'Pre-ordering is optional. You can also order at the restaurant.',
  'skip_pre_order': 'Skip Pre-order',
  // Room Service
  'room_service_title': 'Room Service',
  'select_items': 'Select items',
  'review_order': 'Review order',
  'delivery_time': 'Delivery Time',
  'order_summary': 'Order Summary',
  'delivery_fee': 'Delivery Fee',
  'order_confirmed': 'Order Confirmed!',
  'preparing_order': 'Your order is being prepared.',
  // Activities
  'upcoming_events': 'Upcoming Events',
  'all_activities': 'All Activities',
  'join_now': 'Join Now',
  'registered': 'Registered',
  'full': 'Full',
  // Loyalty
  'current_tier': 'Current Tier',
  'next_tier': 'Next Tier',
  'points_to_next': 'points to next tier',
  'recent_activity': 'Recent Activity',
  'available_rewards': 'Available Rewards',
  // Housekeeping
  'request_cleaning': 'Request Cleaning',
  'request_amenities': 'Request Amenities',
  'schedule_cleaning': 'Schedule Cleaning',
  'asap': 'As soon as possible',
  'in_one_hour': 'In 1 hour',
  'in_two_hours': 'In 2 hours',
  'tomorrow': 'Tomorrow',
  // Transport
  'select_vehicle': 'Select Vehicle',
  'pickup_location': 'Pickup Location',
  'hotel_lobby': 'Hotel Lobby',
  'estimated_arrival': 'Estimated Arrival',
  'vehicle_requested': 'Vehicle Requested!',
  // Feedback
  'rate_your_experience': 'Rate Your Experience',
  'tap_to_rate': 'Tap to rate',
  'additional_comments': 'Additional Comments',
  'submit': 'Submit',
  // Hotel Info
  'hotel_amenities': 'Hotel Amenities',
  'check_in_time': 'Check-in Time',
  'check_out_time': 'Check-out Time',
  'copy_to_clipboard': 'Copy to clipboard',
  'copied': 'Copied!',
  // Chat
  'chat_with_concierge': 'Chat with Concierge',
  'how_can_i_help': 'How can I help you today?',
  // Common
  'room': 'Room',
  'date': 'Date',
  'time': 'Time',
  'optional': 'Optional',
  'required': 'Required',
  'select': 'Select',
  'selected': 'Selected',
  'add': 'Add',
  'remove': 'Remove',
  'clear': 'Clear',
  'apply': 'Apply',
  'reset': 'Reset',
  'search': 'Search',
  'filter': 'Filter',
  'sort': 'Sort',
  'more': 'More',
  'less': 'Less',
  'show': 'Show',
  'hide': 'Hide',
  'yes': 'Yes',
  'no': 'No',
  'ok': 'OK',
  // Place details
  'about': 'About',
  'location': 'Location',
  'view_on_map': 'View on Map',
  'highlights': 'Highlights',
  'reviews': 'Reviews',
  'change': 'Change',
  'customize': 'Customize',
  'pre_order_summary': 'Pre-Order Summary',
  'estimated_total': 'Estimated Total',
  'pre_order': 'Pre-order',
  'starting_from': 'Starting from',
  'booking_summary': 'Booking Summary',
  'request_services_amenities': 'Request services & amenities',
  'preferred_time': 'Preferred Time',
  'rate_by_category': 'Rate by Category',
  'password_copied': 'Password copied!',
  'terms_and_conditions': 'Terms & Conditions',
  'delivery_instructions': 'Delivery Instructions',
  'added_to_favorites': 'Added to favorites',
  'share_link_copied': 'Share link copied!',
  'reservation_cancelled': 'Reservation cancelled',
  'from': 'From',
  'calling_front_desk': 'Calling front desk...',
  'reserve_table': 'Reserve Table',
  'book_activity': 'Book Activity',
  'get_tickets': 'Get Tickets',
  'claim_offer': 'Claim Offer',
  'reserving': 'Reserving...',
  'view_cart': 'View Cart',
  'add_items_to_order': 'Add items to order',
  'placing_order': 'Placing Order...',
  'continue_text': 'Continue',
  'breakfast': 'Breakfast',
  'lunch': 'Lunch',
  'dinner': 'Dinner',
  'snacks': 'Snacks',
  'food': 'Food',
  'sights': 'Sights',
  'search_nearby_places': 'Search nearby places...',
  'restaurant': 'Restaurant',
  'valid_until': 'Valid until',
  'order_food_to_your_room': 'Order food to your room',
  'reserve': 'Reserve',
  'reserve_spot': 'Reserve Spot',
  'tickets_booked': 'Tickets Booked!',
  'deal_claimed': 'Deal Claimed!',
  'spot_reserved': 'Spot Reserved!',
  'confirm_booking': 'Confirm Booking',
  'request_service': 'Request Service',
  'submitting': 'Submitting...',
  'enter_destination': 'Enter destination',
  'connection_speed': 'Connection Speed',
  'device_limit': 'Device Limit',
  'coverage': 'Coverage',
  'need_help': 'Need Help?',
  'up_to_100_mbps': 'Up to 100 Mbps download',
  'devices_per_room': '5 devices per room',
  'available_throughout': 'Available throughout the property',
  'call_it_support': 'Call IT Support: Dial 7',
  'select_treatment_category': 'Select treatment category',
  'choose_your_treatment': 'Choose your treatment',
  'attraction': 'Attraction',
  'just_now': 'Just now',
  'minutes_ago': 'm ago',
  'hours_ago': 'h ago',
  'days_ago': 'd ago',

  // Billing categories
  'accommodation': 'Accommodation',
  'minibar': 'Minibar',

  // Rewards
  'gold_member': 'Gold Member',
  'member_since': 'Member since',
  'tier': 'Tier',
  'to_next': 'To Next',
  'ten_off_dining': '10% off dining',
  'late_checkout': 'Late checkout (3 PM)',
  'room_upgrade': 'Room upgrade',
  'spa_discount': 'Spa discount',

  // Housekeeping
  'cleaning': 'Cleaning',
  'housekeeping_will_not_enter': 'Housekeeping will not enter your room',
  'full_room_cleaning': 'Full Room Cleaning',
  'full_room_cleaning_desc':
      'Complete cleaning including bed making, vacuuming, and bathroom',
  'quick_tidy_up': 'Quick Tidy Up',
  'quick_tidy_up_desc': 'Light cleaning, trash removal, and bed making',
  'turndown_service': 'Turndown Service',
  'turndown_service_desc': 'Evening bed preparation with chocolates',
  'select_services_or_amenities': 'Select Services or Amenities',

  // Amenities
  'extra_towels': 'Extra Towels',
  'extra_pillows': 'Extra Pillows',
  'extra_blanket': 'Extra Blanket',
  'toiletries_kit': 'Toiletries Kit',
  'bathrobe': 'Bathrobe',
  'slippers': 'Slippers',
  'iron_and_board': 'Iron & Board',
  'extra_hangers': 'Extra Hangers',
  'coffee_tea_refill': 'Coffee/Tea Refill',

  // Schedule
  'anytime': 'Anytime',
  'first_available': 'First available',
  'morning': 'Morning',
  'afternoon': 'Afternoon',
  'evening': 'Evening',
  'requests_fulfilled_info':
      'Requests are typically fulfilled within 30 minutes during selected time window.',

  // Transport
  'select_a_service': 'Select a service',
  'standard_taxi_service': 'Standard taxi service',
  'metered': 'Metered',
  'sedan_with_driver': 'Sedan with professional driver',
  'spacious_suv_for_groups': 'Spacious SUV for groups',
  'direct_to_from_airport': 'Direct to/from airport',
  'scheduled': 'Scheduled',
  'retrieve_your_parked_car': 'Retrieve your parked car',
  'included': 'Included',

  // Hotel Info
  'swimming_pool': 'Swimming Pool',
  'ground_floor': 'Ground Floor',
  'towels_available_at_pool_deck': 'Towels available at pool deck',
  'fitness_center': 'Fitness Center',
  'twenty_four_hours': '24 Hours',
  'second_floor': '2nd Floor',
  'room_key_required_for_access': 'Room key required for access',
  'third_floor': '3rd Floor',
  'reservations_recommended': 'Reservations recommended',
  'business_center': 'Business Center',
  'lobby_level': 'Lobby Level',
  'printing_services_available': 'Printing services available',
  'kids_club': 'Kids Club',
  'ages_supervision_included': 'Ages 4-12, supervision included',
  'gift_shop': 'Gift Shop',

  // Contacts
  'valet': 'Valet',
  'security': 'Security',

  // Promotions
  'valid_for_hotel_guests_only': 'Valid for hotel guests only',
  'cannot_be_combined': 'Cannot be combined with other offers',
  'subject_to_availability': 'Subject to availability',
  'non_transferable': 'Non-transferable',

  // Service detail
  'min': 'min',

  'complimentary': 'Complimentary',
  'free_entry': 'Free Entry',
  'capacity': 'Capacity',
  'up_to_guests': 'Up to 2 guests',

  // Biometric Authentication
  'enable_biometrics': 'Enable Face ID / Fingerprint',
  'enable_biometric_title': 'Enable Biometric Login',
  'enable_biometric_message':
      'Would you like to enable biometric login? This will allow you to sign in faster and more securely using Face ID or Fingerprint.',
  'biometric_enabled': 'Biometric login enabled successfully',
  'biometric_disabled': 'Biometric login disabled',
  'login_with_face_id': 'Log In with Face ID',
  'login_with_fingerprint': 'Log In with Fingerprint',
  'biometric_not_available':
      'Biometric authentication is not available on this device',
  'biometric_prompt': 'Authenticate to continue',
  'biometric_failed': 'Authentication failed',
  'enable': 'Enable',
  'not_now': 'Not Now',
};

// Spanish translations
const Map<String, String> _esTranslations = {
  'app_name': 'Energy Hotel',
  'welcome': 'Bienvenido',
  'hello': 'Hola',
  'guest': 'Huésped',
  'home': 'Inicio',
  'welcome_to_hotel': 'Bienvenido a Energy Hotel',
  'quick_actions': 'Acciones Rápidas',
  'featured_services': 'Servicios Destacados',
  'promotions': 'Promociones',
  'check_in': 'Entrada',
  'check_out': 'Salida',
  'days_remaining': 'días restantes',
  'extend_stay': 'Extender Estancia',
  'room_number': 'Habitación',
  'spa': 'Spa',
  'dining': 'Restaurantes',
  'pool': 'Piscina',
  'room_service': 'Servicio a la Habitación',
  'profile': 'Perfil',
  'services': 'Servicios',
  'my_reservations': 'Mis Reservaciones',
  'upcoming': 'Próximas',
  'past': 'Pasadas',
  'no_reservations': 'Sin reservaciones aún',
  'see_all': 'Ver Todo',
  'cancel': 'Cancelar',
  'cancel_reservation': 'Cancelar Reservación',
  'settings': 'Configuración',
  'language': 'Idioma',
  'select_language': 'Seleccionar Idioma',
  'notifications': 'Notificaciones',
  'biometric_auth': 'Autenticación Biométrica',
  'payment_methods': 'Métodos de Pago',
  'help_support': 'Ayuda y Soporte',
  'logout': 'Cerrar Sesión',
  'logout_confirm': '¿Estás seguro de que deseas cerrar sesión?',
  'room_key': 'Llave Digital',
  'billing': 'Facturación',
  'rewards': 'Recompensas',
  'chat': 'Chat',
  'housekeeping': 'Limpieza',
  'transport': 'Transporte',
  'activities': 'Actividades',
  'hotel_info': 'Info del Hotel',
  'feedback': 'Comentarios',
  'rate_experience': 'Califica tu Experiencia',
  'map': 'Mapa',
  'search_nearby': 'Buscar lugares cercanos...',
  'restaurants': 'Restaurantes',
  'attractions': 'Atracciones',
  'shopping': 'Compras',
  'nightlife': 'Vida Nocturna',
  'explore': 'Explorar',
  'all': 'Todo',
  'view_details': 'Ver Detalles',
  'book_now': 'Reservar Ahora',
  'select_date': 'Seleccionar Fecha',
  'select_time': 'Seleccionar Hora',
  'guests': 'Huéspedes',
  'confirm': 'Confirmar',
  'confirmed': 'Confirmado',
  'booking_confirmed': '¡Reservación Confirmada!',
  'total': 'Total',
  'free': 'GRATIS',
  'no_notifications': 'Sin notificaciones',
  'mark_all_read': 'Marcar todo leído',
  'digital_room_key': 'Llave Digital',
  'tap_to_unlock': 'TOCA PARA ABRIR',
  'unlocking': 'ABRIENDO...',
  'door_unlocked': 'PUERTA ABIERTA',
  'current_balance': 'Saldo Actual',
  'charges': 'Cargos',
  'pay_now': 'Pagar Ahora',
  'add_tip': 'Agregar Propina',
  'payment_successful': '¡Pago Exitoso!',
  'cleaning_services': 'Servicios de Limpieza',
  'amenities': 'Amenidades',
  'schedule': 'Horario',
  'do_not_disturb': 'No Molestar',
  'submit_request': 'Enviar Solicitud',
  'request_submitted': '¡Solicitud Enviada!',
  'transportation': 'Transporte',
  'taxi': 'Taxi',
  'private_car': 'Auto Privado',
  'airport_shuttle': 'Shuttle al Aeropuerto',
  'valet_service': 'Servicio Valet',
  'car_rental': 'Renta de Autos',
  'request_now': 'Solicitar Ahora',
  'activities_events': 'Actividades y Eventos',
  'events': 'Eventos',
  'tours': 'Tours',
  'classes': 'Clases',
  'sports': 'Deportes',
  'spots_left': 'lugares disponibles',
  'loyalty_rewards': 'Energy Rewards',
  'available_points': 'Puntos Disponibles',
  'tier_progress': 'Progreso de Nivel',
  'your_benefits': 'Tus Beneficios',
  'redeem_rewards': 'Canjear Recompensas',
  'points_history': 'Historial de Puntos',
  'overall_rating': 'Calificación General',
  'submit_feedback': 'Enviar Comentarios',
  'thank_you': '¡Gracias!',
  'hotel_information': 'Información del Hotel',
  'wifi': 'WiFi',
  'contacts': 'Contactos',
  'emergency_contacts': 'Contactos de Emergencia',
  'concierge': 'Concierge',
  'online': 'En línea',
  'type_message': 'Escribe un mensaje...',
  'done': 'Listo',
  'save': 'Guardar',
  'edit': 'Editar',
  'delete': 'Eliminar',
  'close': 'Cerrar',
  'back': 'Atrás',
  'next': 'Siguiente',
  'continue': 'Continuar',
  'loading': 'Cargando...',
  'error': 'Error',
  'retry': 'Reintentar',
  'success': 'Éxito',
  // Login
  'welcome_to': 'Bienvenido a',
  'sign_in': 'Iniciar Sesión',
  'enter_credentials': 'Ingresa tus credenciales para continuar',
  'email_address': 'Correo Electrónico',
  'password': 'Contraseña',
  'language_changed_to': 'Idioma cambiado a',
  // Errors
  'error_loading_promotions': 'Error al cargar promociones',
  'error_loading_services': 'Error al cargar servicios',
  // Misc
  'per_night': 'por noche',
  'nights': 'noches',
  'additional_nights': 'Noches Adicionales',
  'new_checkout_date': 'Nueva Fecha de Salida',
  'confirm_extension': 'Confirmar Extensión',
  'stay_extended': '¡Estancia Extendida!',
  'description': 'Descripción',
  'duration': 'Duración',
  'price': 'Precio',
  'available': 'Disponible',
  'hours': 'horas',
  'minutes': 'minutos',
  'person': 'persona',
  'people': 'personas',
  'select_treatment': 'Seleccionar Tratamiento',
  'select_restaurant': 'Seleccionar Restaurante',
  'make_reservation': 'Hacer Reservación',
  'order_items': 'Ordenar Artículos',
  'add_to_order': 'Agregar al Pedido',
  'place_order': 'Realizar Pedido',
  'order_placed': '¡Pedido Realizado!',
  'estimated_delivery': 'Entrega Estimada',
  'quantity': 'Cantidad',
  'subtotal': 'Subtotal',
  'tax': 'Impuesto',
  'tips': 'Propinas',
  'grand_total': 'Total General',
  'payment_method': 'Método de Pago',
  'room_charge': 'Cargo a Habitación',
  'credit_card': 'Tarjeta de Crédito',
  'cash': 'Efectivo',
  'pickup': 'Recoger',
  'destination': 'Destino',
  'request_transport': 'Solicitar Transporte',
  'transport_requested': '¡Transporte Solicitado!',
  'driver_on_way': 'Conductor en camino',
  'register': 'Registrarse',
  'join_event': 'Unirse al Evento',
  'spots_available': 'lugares disponibles',
  'points': 'Puntos',
  'redeem': 'Canjear',
  'earned_points': 'Puntos Ganados',
  'used_points': 'Puntos Usados',
  'how_was_your_stay': '¿Cómo fue tu estancia?',
  'leave_comment': 'Deja un comentario...',
  'feedback_submitted': '¡Comentarios Enviados!',
  'wifi_name': 'Nombre WiFi',
  'wifi_password': 'Contraseña WiFi',
  'front_desk': 'Recepción',
  'room_service_phone': 'Servicio a la Habitación',
  'emergency': 'Emergencia',
  'police': 'Policía',
  'ambulance': 'Ambulancia',
  'fire_department': 'Bomberos',
  // Billing
  'billing_wallet': 'Facturación y Cartera',
  'top_charges': 'Cargos Principales',
  'pay_your_bill': 'Pagar tu Cuenta',
  'add_payment_method': 'Agregar Método de Pago',
  'default_card': 'Predeterminado',
  'expires': 'Expira',
  'tip': 'Propina',
  'none': 'Ninguna',
  'processing': 'Procesando...',
  'pay': 'Pagar',
  'today': 'Hoy',
  'yesterday': 'Ayer',
  // Spa
  'spa_wellness': 'Spa y Bienestar',
  'select_category': 'Selecciona categoría de tratamiento',
  'choose_treatment': 'Elige tu tratamiento',
  'add_enhancements': 'Agregar mejoras',
  'select_date_time': 'Seleccionar fecha y hora',
  'enhance_experience': 'Mejora tu Experiencia',
  'add_extra_treatments': 'Agrega tratamientos extra a tu sesión',
  'therapist_preference': 'Preferencia de Terapeuta',
  'special_requests': 'Solicitudes Especiales',
  'any_allergies': 'Alergias, preferencias o necesidades especiales...',
  'spa_booked': '¡Cita de Spa Reservada!',
  'relax_prepare': 'Relájate y prepárate para tu tratamiento.',
  // Dining
  'choose_restaurant': 'Elige un restaurante',
  'pre_order_dishes': 'Pre-ordenar platillos (opcional)',
  'table_reserved': '¡Mesa Reservada!',
  'dining_awaits': 'Tu experiencia gastronómica te espera.',
  'items_pre_ordered': 'artículos pre-ordenados',
  'pre_order_optional':
      'Pre-ordenar es opcional. También puedes ordenar en el restaurante.',
  'skip_pre_order': 'Omitir Pre-orden',
  // Room Service
  'room_service_title': 'Servicio a la Habitación',
  'select_items': 'Seleccionar artículos',
  'review_order': 'Revisar pedido',
  'delivery_time': 'Tiempo de Entrega',
  'order_summary': 'Resumen del Pedido',
  'delivery_fee': 'Costo de Envío',
  'order_confirmed': '¡Pedido Confirmado!',
  'preparing_order': 'Tu pedido está siendo preparado.',
  // Activities
  'upcoming_events': 'Próximos Eventos',
  'all_activities': 'Todas las Actividades',
  'join_now': 'Unirse Ahora',
  'registered': 'Registrado',
  'full': 'Lleno',
  // Loyalty
  'current_tier': 'Nivel Actual',
  'next_tier': 'Siguiente Nivel',
  'points_to_next': 'puntos para el siguiente nivel',
  'recent_activity': 'Actividad Reciente',
  'available_rewards': 'Recompensas Disponibles',
  // Housekeeping
  'request_cleaning': 'Solicitar Limpieza',
  'request_amenities': 'Solicitar Amenidades',
  'schedule_cleaning': 'Programar Limpieza',
  'asap': 'Lo antes posible',
  'in_one_hour': 'En 1 hora',
  'in_two_hours': 'En 2 horas',
  'tomorrow': 'Mañana',
  // Transport
  'select_vehicle': 'Seleccionar Vehículo',
  'pickup_location': 'Lugar de Recogida',
  'hotel_lobby': 'Lobby del Hotel',
  'estimated_arrival': 'Llegada Estimada',
  'vehicle_requested': '¡Vehículo Solicitado!',
  // Feedback
  'rate_your_experience': 'Califica tu Experiencia',
  'tap_to_rate': 'Toca para calificar',
  'additional_comments': 'Comentarios Adicionales',
  'submit': 'Enviar',
  // Hotel Info
  'hotel_amenities': 'Amenidades del Hotel',
  'check_in_time': 'Hora de Entrada',
  'check_out_time': 'Hora de Salida',
  'copy_to_clipboard': 'Copiar al portapapeles',
  'copied': '¡Copiado!',
  // Chat
  'chat_with_concierge': 'Chat con Concierge',
  'how_can_i_help': '¿Cómo puedo ayudarte hoy?',
  // Common
  'room': 'Habitación',
  'date': 'Fecha',
  'time': 'Hora',
  'optional': 'Opcional',
  'required': 'Requerido',
  'select': 'Seleccionar',
  'selected': 'Seleccionado',
  'add': 'Agregar',
  'remove': 'Eliminar',
  'clear': 'Limpiar',
  'apply': 'Aplicar',
  'reset': 'Reiniciar',
  'search': 'Buscar',
  'filter': 'Filtrar',
  'sort': 'Ordenar',
  'more': 'Más',
  'less': 'Menos',
  'show': 'Mostrar',
  'hide': 'Ocultar',
  'yes': 'Sí',
  'no': 'No',
  'ok': 'OK',
  // Place details
  'about': 'Acerca de',
  'location': 'Ubicación',
  'view_on_map': 'Ver en Mapa',
  'highlights': 'Destacados',
  'reviews': 'Reseñas',
  'change': 'Cambiar',
  'customize': 'Personalizar',
  'pre_order_summary': 'Resumen de Pre-orden',
  'estimated_total': 'Total Estimado',
  'pre_order': 'Pre-ordenar',
  'starting_from': 'Desde',
  'booking_summary': 'Resumen de Reserva',
  'request_services_amenities': 'Solicitar servicios y amenidades',
  'preferred_time': 'Hora Preferida',
  'rate_by_category': 'Calificar por Categoría',
  'password_copied': '¡Contraseña copiada!',
  'terms_and_conditions': 'Términos y Condiciones',
  'delivery_instructions': 'Instrucciones de Entrega',
  'added_to_favorites': 'Agregado a favoritos',
  'share_link_copied': '¡Enlace copiado!',
  'reservation_cancelled': 'Reservación cancelada',
  'from': 'Desde',
  'calling_front_desk': 'Llamando a recepción...',
  'reserve_spot': 'Reservar Lugar',
  'tickets_booked': '¡Boletos Reservados!',
  'deal_claimed': '¡Oferta Reclamada!',
  'spot_reserved': '¡Lugar Reservado!',
  'confirm_booking': 'Confirmar Reserva',
  'request_service': 'Solicitar Servicio',
  'submitting': 'Enviando...',
  'enter_destination': 'Ingresa destino',
  'connection_speed': 'Velocidad de Conexión',
  'device_limit': 'Límite de Dispositivos',
  'coverage': 'Cobertura',
  'need_help': '¿Necesitas Ayuda?',
  'up_to_100_mbps': 'Hasta 100 Mbps de descarga',
  'devices_per_room': '5 dispositivos por habitación',
  'available_throughout': 'Disponible en toda la propiedad',
  'call_it_support': 'Llama a Soporte TI: Marca 7',
  'select_treatment_category': 'Selecciona categoría de tratamiento',
  'choose_your_treatment': 'Elige tu tratamiento',
  'attraction': 'Atracción',
  'just_now': 'Ahora',
  'minutes_ago': 'm',
  'hours_ago': 'h',
  'days_ago': 'd',

  // Billing categories
  'accommodation': 'Alojamiento',
  'minibar': 'Minibar',

  // Rewards
  'gold_member': 'Miembro Gold',
  'member_since': 'Miembro desde',
  'tier': 'Nivel',
  'to_next': 'Para Siguiente',
  'ten_off_dining': '10% desc. en restaurantes',
  'late_checkout': 'Salida tardía (3 PM)',
  'room_upgrade': 'Mejora de habitación',
  'spa_discount': 'Descuento en spa',

  // Housekeeping
  'cleaning': 'Limpieza',
  'housekeeping_will_not_enter':
      'El servicio de limpieza no entrará a tu habitación',
  'full_room_cleaning': 'Limpieza Completa',
  'full_room_cleaning_desc':
      'Limpieza completa incluyendo tendido de cama, aspirado y baño',
  'quick_tidy_up': 'Arreglo Rápido',
  'quick_tidy_up_desc': 'Limpieza ligera, retiro de basura y tendido de cama',
  'turndown_service': 'Servicio Nocturno',
  'turndown_service_desc': 'Preparación de cama con chocolates',
  'select_services_or_amenities': 'Seleccionar Servicios o Amenidades',

  // Amenities
  'extra_towels': 'Toallas Extra',
  'extra_pillows': 'Almohadas Extra',
  'extra_blanket': 'Cobija Extra',
  'toiletries_kit': 'Kit de Tocador',
  'bathrobe': 'Bata de Baño',
  'slippers': 'Pantuflas',
  'iron_and_board': 'Plancha y Tabla',
  'extra_hangers': 'Ganchos Extra',
  'coffee_tea_refill': 'Recarga Café/Té',

  // Schedule
  'anytime': 'Cualquier Hora',
  'first_available': 'Primera disponible',
  'morning': 'Mañana',
  'afternoon': 'Tarde',
  'evening': 'Noche',
  'requests_fulfilled_info':
      'Las solicitudes se atienden típicamente en 30 minutos durante la ventana de tiempo seleccionada.',

  // Transport
  'select_a_service': 'Selecciona un servicio',
  'standard_taxi_service': 'Servicio de taxi estándar',
  'metered': 'Taxímetro',
  'sedan_with_driver': 'Sedán con conductor profesional',
  'spacious_suv_for_groups': 'SUV espacioso para grupos',
  'direct_to_from_airport': 'Directo al/desde aeropuerto',
  'scheduled': 'Programado',
  'retrieve_your_parked_car': 'Recupera tu auto estacionado',
  'included': 'Incluido',

  // Hotel Info
  'swimming_pool': 'Piscina',
  'ground_floor': 'Planta Baja',
  'towels_available_at_pool_deck': 'Toallas disponibles en la piscina',
  'fitness_center': 'Gimnasio',
  'twenty_four_hours': '24 Horas',
  'second_floor': '2do Piso',
  'room_key_required_for_access': 'Se requiere llave de habitación',
  'third_floor': '3er Piso',
  'reservations_recommended': 'Se recomiendan reservaciones',
  'business_center': 'Centro de Negocios',
  'lobby_level': 'Nivel Lobby',
  'printing_services_available': 'Servicios de impresión disponibles',
  'kids_club': 'Club de Niños',
  'ages_supervision_included': 'Edades 4-12, supervisión incluida',
  'gift_shop': 'Tienda de Regalos',

  // Contacts
  'valet': 'Valet',
  'security': 'Seguridad',

  // Promotions
  'valid_for_hotel_guests_only': 'Válido solo para huéspedes del hotel',
  'cannot_be_combined': 'No se puede combinar con otras ofertas',
  'subject_to_availability': 'Sujeto a disponibilidad',
  'non_transferable': 'No transferible',

  // Service detail
  'min': 'min',

  'reserve_table': 'Reservar Mesa',
  'book_activity': 'Reservar Actividad',
  'get_tickets': 'Obtener Boletos',
  'claim_offer': 'Reclamar Oferta',
  'reserving': 'Reservando...',
  'view_cart': 'Ver Carrito',
  'add_items_to_order': 'Agregar al pedido',
  'placing_order': 'Realizando Pedido...',
  'continue_text': 'Continuar',
  'breakfast': 'Desayuno',
  'lunch': 'Almuerzo',
  'dinner': 'Cena',
  'snacks': 'Bocadillos',
  'food': 'Comida',
  'sights': 'Lugares',
  'search_nearby_places': 'Buscar lugares cercanos...',
  'restaurant': 'Restaurante',
  'order_food_to_your_room': 'Ordena comida a tu habitación',
  'reserve': 'Reservar',
  'complimentary': 'Cortesía',
  'free_entry': 'Entrada Gratis',
  'capacity': 'Capacidad',
  'up_to_guests': 'Hasta 2 huéspedes',

  // Biometric Authentication
  'enable_biometrics': 'Habilitar Face ID / Huella',
  'enable_biometric_title': 'Habilitar Inicio Biométrico',
  'enable_biometric_message':
      '¿Te gustaría habilitar el inicio de sesión biométrico? Esto te permitirá iniciar sesión más rápido y de forma más segura usando Face ID o Huella.',
  'biometric_enabled': 'Inicio biométrico habilitado exitosamente',
  'biometric_disabled': 'Inicio biométrico deshabilitado',
  'login_with_face_id': 'Iniciar con Face ID',
  'login_with_fingerprint': 'Iniciar con Huella',
  'biometric_not_available':
      'La autenticación biométrica no está disponible en este dispositivo',
  'biometric_prompt': 'Autentícate para continuar',
  'biometric_failed': 'Autenticación fallida',
  'enable': 'Habilitar',
  'not_now': 'Ahora No',
};
