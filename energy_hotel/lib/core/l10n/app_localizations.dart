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
    'fr': _frTranslations,
    'de': _deTranslations,
    'it': _itTranslations,
    'pt': _ptTranslations,
    'zh': _zhTranslations,
    'ja': _jaTranslations,
    'ko': _koTranslations,
    'ar': _arTranslations,
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
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'es',
      'fr',
      'de',
      'it',
      'pt',
      'zh',
      'ja',
      'ko',
      'ar',
    ].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
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
};

// French translations
const Map<String, String> _frTranslations = {
  'app_name': 'Energy Hotel',
  'welcome': 'Bienvenue',
  'hello': 'Bonjour',
  'guest': 'Client',
  'welcome_to_hotel': 'Bienvenue à Energy Hotel',
  'quick_actions': 'Actions Rapides',
  'featured_services': 'Services en Vedette',
  'promotions': 'Promotions',
  'check_in': 'Arrivée',
  'check_out': 'Départ',
  'days_remaining': 'jours restants',
  'extend_stay': 'Prolonger le Séjour',
  'room_number': 'Chambre',
  'spa': 'Spa',
  'dining': 'Restaurant',
  'pool': 'Piscine',
  'room_service': 'Service en Chambre',
  'profile': 'Profil',
  'services': 'Services',
  'my_reservations': 'Mes Réservations',
  'upcoming': 'À venir',
  'past': 'Passées',
  'no_reservations': 'Pas encore de réservations',
  'see_all': 'Voir Tout',
  'cancel': 'Annuler',
  'cancel_reservation': 'Annuler la Réservation',
  'settings': 'Paramètres',
  'language': 'Langue',
  'select_language': 'Sélectionner la Langue',
  'notifications': 'Notifications',
  'biometric_auth': 'Authentification Biométrique',
  'payment_methods': 'Moyens de Paiement',
  'help_support': 'Aide et Support',
  'logout': 'Déconnexion',
  'logout_confirm': 'Êtes-vous sûr de vouloir vous déconnecter?',
  'room_key': 'Clé Numérique',
  'billing': 'Facturation',
  'rewards': 'Récompenses',
  'chat': 'Chat',
  'housekeeping': 'Ménage',
  'transport': 'Transport',
  'activities': 'Activités',
  'hotel_info': 'Info Hôtel',
  'feedback': 'Commentaires',
  'rate_experience': 'Évaluez Votre Expérience',
  'map': 'Carte',
  'search_nearby': 'Rechercher des lieux...',
  'restaurants': 'Restaurants',
  'attractions': 'Attractions',
  'shopping': 'Shopping',
  'nightlife': 'Vie Nocturne',
  'explore': 'Explorer',
  'all': 'Tout',
  'view_details': 'Voir Détails',
  'book_now': 'Réserver',
  'select_date': 'Sélectionner Date',
  'select_time': 'Sélectionner Heure',
  'guests': 'Invités',
  'confirm': 'Confirmer',
  'confirmed': 'Confirmé',
  'booking_confirmed': 'Réservation Confirmée!',
  'total': 'Total',
  'free': 'GRATUIT',
  'no_notifications': 'Pas de notifications',
  'mark_all_read': 'Tout marquer lu',
  'digital_room_key': 'Clé Numérique',
  'tap_to_unlock': 'APPUYEZ POUR OUVRIR',
  'unlocking': 'OUVERTURE...',
  'door_unlocked': 'PORTE OUVERTE',
  'current_balance': 'Solde Actuel',
  'charges': 'Frais',
  'pay_now': 'Payer',
  'add_tip': 'Ajouter Pourboire',
  'payment_successful': 'Paiement Réussi!',
  'cleaning_services': 'Services de Ménage',
  'amenities': 'Équipements',
  'schedule': 'Horaire',
  'do_not_disturb': 'Ne Pas Déranger',
  'submit_request': 'Envoyer Demande',
  'request_submitted': 'Demande Envoyée!',
  'transportation': 'Transport',
  'taxi': 'Taxi',
  'private_car': 'Voiture Privée',
  'airport_shuttle': 'Navette Aéroport',
  'valet_service': 'Service Voiturier',
  'car_rental': 'Location de Voiture',
  'request_now': 'Demander',
  'activities_events': 'Activités et Événements',
  'events': 'Événements',
  'tours': 'Tours',
  'classes': 'Cours',
  'sports': 'Sports',
  'spots_left': 'places restantes',
  'loyalty_rewards': 'Energy Rewards',
  'available_points': 'Points Disponibles',
  'tier_progress': 'Progression Niveau',
  'your_benefits': 'Vos Avantages',
  'redeem_rewards': 'Échanger Récompenses',
  'points_history': 'Historique Points',
  'overall_rating': 'Note Globale',
  'submit_feedback': 'Envoyer Commentaires',
  'thank_you': 'Merci!',
  'hotel_information': 'Informations Hôtel',
  'wifi': 'WiFi',
  'contacts': 'Contacts',
  'emergency_contacts': 'Contacts d\'Urgence',
  'concierge': 'Concierge',
  'online': 'En ligne',
  'type_message': 'Tapez un message...',
  'done': 'Terminé',
  'save': 'Enregistrer',
  'edit': 'Modifier',
  'delete': 'Supprimer',
  'close': 'Fermer',
  'back': 'Retour',
  'next': 'Suivant',
  'continue': 'Continuer',
  'loading': 'Chargement...',
  'error': 'Erreur',
  'retry': 'Réessayer',
  'success': 'Succès',
};

// German translations
const Map<String, String> _deTranslations = {
  'app_name': 'Energy Hotel',
  'welcome': 'Willkommen',
  'hello': 'Hallo',
  'guest': 'Gast',
  'welcome_to_hotel': 'Willkommen im Energy Hotel',
  'quick_actions': 'Schnellaktionen',
  'featured_services': 'Empfohlene Services',
  'promotions': 'Angebote',
  'check_in': 'Check-in',
  'check_out': 'Check-out',
  'days_remaining': 'Tage verbleibend',
  'extend_stay': 'Aufenthalt Verlängern',
  'room_number': 'Zimmer',
  'spa': 'Spa',
  'dining': 'Restaurant',
  'pool': 'Pool',
  'room_service': 'Zimmerservice',
  'profile': 'Profil',
  'services': 'Services',
  'my_reservations': 'Meine Reservierungen',
  'upcoming': 'Bevorstehend',
  'past': 'Vergangen',
  'no_reservations': 'Noch keine Reservierungen',
  'see_all': 'Alle Anzeigen',
  'cancel': 'Abbrechen',
  'cancel_reservation': 'Reservierung Stornieren',
  'settings': 'Einstellungen',
  'language': 'Sprache',
  'select_language': 'Sprache Auswählen',
  'notifications': 'Benachrichtigungen',
  'biometric_auth': 'Biometrische Authentifizierung',
  'payment_methods': 'Zahlungsmethoden',
  'help_support': 'Hilfe & Support',
  'logout': 'Abmelden',
  'logout_confirm': 'Möchten Sie sich wirklich abmelden?',
  'room_key': 'Digitaler Schlüssel',
  'billing': 'Abrechnung',
  'rewards': 'Prämien',
  'chat': 'Chat',
  'housekeeping': 'Housekeeping',
  'transport': 'Transport',
  'activities': 'Aktivitäten',
  'hotel_info': 'Hotel Info',
  'feedback': 'Feedback',
  'rate_experience': 'Bewerten Sie Ihre Erfahrung',
  'map': 'Karte',
  'search_nearby': 'Orte in der Nähe suchen...',
  'restaurants': 'Restaurants',
  'attractions': 'Sehenswürdigkeiten',
  'shopping': 'Einkaufen',
  'nightlife': 'Nachtleben',
  'explore': 'Entdecken',
  'all': 'Alle',
  'view_details': 'Details Anzeigen',
  'book_now': 'Jetzt Buchen',
  'select_date': 'Datum Wählen',
  'select_time': 'Zeit Wählen',
  'guests': 'Gäste',
  'confirm': 'Bestätigen',
  'confirmed': 'Bestätigt',
  'booking_confirmed': 'Buchung Bestätigt!',
  'total': 'Gesamt',
  'free': 'KOSTENLOS',
  'no_notifications': 'Keine Benachrichtigungen',
  'mark_all_read': 'Alle als gelesen markieren',
  'digital_room_key': 'Digitaler Zimmerschlüssel',
  'tap_to_unlock': 'TIPPEN ZUM ÖFFNEN',
  'unlocking': 'ÖFFNE...',
  'door_unlocked': 'TÜR GEÖFFNET',
  'current_balance': 'Aktueller Saldo',
  'charges': 'Gebühren',
  'pay_now': 'Jetzt Bezahlen',
  'add_tip': 'Trinkgeld Hinzufügen',
  'payment_successful': 'Zahlung Erfolgreich!',
  'cleaning_services': 'Reinigungsservice',
  'amenities': 'Ausstattung',
  'schedule': 'Zeitplan',
  'do_not_disturb': 'Bitte Nicht Stören',
  'submit_request': 'Anfrage Senden',
  'request_submitted': 'Anfrage Gesendet!',
  'transportation': 'Transport',
  'taxi': 'Taxi',
  'private_car': 'Privatauto',
  'airport_shuttle': 'Flughafen-Shuttle',
  'valet_service': 'Parkservice',
  'car_rental': 'Autovermietung',
  'request_now': 'Jetzt Anfordern',
  'activities_events': 'Aktivitäten & Events',
  'events': 'Events',
  'tours': 'Touren',
  'classes': 'Kurse',
  'sports': 'Sport',
  'spots_left': 'Plätze frei',
  'loyalty_rewards': 'Energy Rewards',
  'available_points': 'Verfügbare Punkte',
  'tier_progress': 'Stufen-Fortschritt',
  'your_benefits': 'Ihre Vorteile',
  'redeem_rewards': 'Prämien Einlösen',
  'points_history': 'Punkte-Verlauf',
  'overall_rating': 'Gesamtbewertung',
  'submit_feedback': 'Feedback Senden',
  'thank_you': 'Danke!',
  'hotel_information': 'Hotel Informationen',
  'wifi': 'WLAN',
  'contacts': 'Kontakte',
  'emergency_contacts': 'Notfallkontakte',
  'concierge': 'Concierge',
  'online': 'Online',
  'type_message': 'Nachricht eingeben...',
  'done': 'Fertig',
  'save': 'Speichern',
  'edit': 'Bearbeiten',
  'delete': 'Löschen',
  'close': 'Schließen',
  'back': 'Zurück',
  'next': 'Weiter',
  'continue': 'Fortfahren',
  'loading': 'Laden...',
  'error': 'Fehler',
  'retry': 'Wiederholen',
  'success': 'Erfolg',
};

// Italian translations
const Map<String, String> _itTranslations = {
  'app_name': 'Energy Hotel',
  'welcome': 'Benvenuto',
  'hello': 'Ciao',
  'guest': 'Ospite',
  'welcome_to_hotel': 'Benvenuto all\'Energy Hotel',
  'quick_actions': 'Azioni Rapide',
  'featured_services': 'Servizi in Evidenza',
  'promotions': 'Promozioni',
  'check_in': 'Check-in',
  'check_out': 'Check-out',
  'days_remaining': 'giorni rimanenti',
  'extend_stay': 'Estendi Soggiorno',
  'room_number': 'Camera',
  'spa': 'Spa',
  'dining': 'Ristorante',
  'pool': 'Piscina',
  'room_service': 'Servizio in Camera',
  'profile': 'Profilo',
  'services': 'Servizi',
  'my_reservations': 'Le Mie Prenotazioni',
  'upcoming': 'Prossime',
  'past': 'Passate',
  'no_reservations': 'Nessuna prenotazione',
  'see_all': 'Vedi Tutto',
  'cancel': 'Annulla',
  'cancel_reservation': 'Annulla Prenotazione',
  'settings': 'Impostazioni',
  'language': 'Lingua',
  'select_language': 'Seleziona Lingua',
  'notifications': 'Notifiche',
  'biometric_auth': 'Autenticazione Biometrica',
  'payment_methods': 'Metodi di Pagamento',
  'help_support': 'Aiuto e Supporto',
  'logout': 'Esci',
  'logout_confirm': 'Sei sicuro di voler uscire?',
  'room_key': 'Chiave Digitale',
  'billing': 'Fatturazione',
  'rewards': 'Premi',
  'chat': 'Chat',
  'housekeeping': 'Pulizie',
  'transport': 'Trasporto',
  'activities': 'Attività',
  'hotel_info': 'Info Hotel',
  'feedback': 'Feedback',
  'rate_experience': 'Valuta la Tua Esperienza',
  'map': 'Mappa',
  'search_nearby': 'Cerca luoghi vicini...',
  'restaurants': 'Ristoranti',
  'attractions': 'Attrazioni',
  'shopping': 'Shopping',
  'nightlife': 'Vita Notturna',
  'explore': 'Esplora',
  'all': 'Tutto',
  'view_details': 'Vedi Dettagli',
  'book_now': 'Prenota Ora',
  'select_date': 'Seleziona Data',
  'select_time': 'Seleziona Ora',
  'guests': 'Ospiti',
  'confirm': 'Conferma',
  'confirmed': 'Confermato',
  'booking_confirmed': 'Prenotazione Confermata!',
  'total': 'Totale',
  'free': 'GRATIS',
  'no_notifications': 'Nessuna notifica',
  'mark_all_read': 'Segna tutto letto',
  'digital_room_key': 'Chiave Digitale',
  'tap_to_unlock': 'TOCCA PER APRIRE',
  'unlocking': 'APERTURA...',
  'door_unlocked': 'PORTA APERTA',
  'current_balance': 'Saldo Attuale',
  'charges': 'Addebiti',
  'pay_now': 'Paga Ora',
  'add_tip': 'Aggiungi Mancia',
  'payment_successful': 'Pagamento Riuscito!',
  'cleaning_services': 'Servizi di Pulizia',
  'amenities': 'Servizi',
  'schedule': 'Orario',
  'do_not_disturb': 'Non Disturbare',
  'submit_request': 'Invia Richiesta',
  'request_submitted': 'Richiesta Inviata!',
  'transportation': 'Trasporto',
  'taxi': 'Taxi',
  'private_car': 'Auto Privata',
  'airport_shuttle': 'Navetta Aeroporto',
  'valet_service': 'Servizio Parcheggio',
  'car_rental': 'Noleggio Auto',
  'request_now': 'Richiedi Ora',
  'activities_events': 'Attività ed Eventi',
  'events': 'Eventi',
  'tours': 'Tour',
  'classes': 'Corsi',
  'sports': 'Sport',
  'spots_left': 'posti disponibili',
  'loyalty_rewards': 'Energy Rewards',
  'available_points': 'Punti Disponibili',
  'tier_progress': 'Progresso Livello',
  'your_benefits': 'I Tuoi Vantaggi',
  'redeem_rewards': 'Riscatta Premi',
  'points_history': 'Storico Punti',
  'overall_rating': 'Valutazione Generale',
  'submit_feedback': 'Invia Feedback',
  'thank_you': 'Grazie!',
  'hotel_information': 'Informazioni Hotel',
  'wifi': 'WiFi',
  'contacts': 'Contatti',
  'emergency_contacts': 'Contatti di Emergenza',
  'concierge': 'Concierge',
  'online': 'Online',
  'type_message': 'Scrivi un messaggio...',
  'done': 'Fatto',
  'save': 'Salva',
  'edit': 'Modifica',
  'delete': 'Elimina',
  'close': 'Chiudi',
  'back': 'Indietro',
  'next': 'Avanti',
  'continue': 'Continua',
  'loading': 'Caricamento...',
  'error': 'Errore',
  'retry': 'Riprova',
  'success': 'Successo',
};

// Portuguese translations
const Map<String, String> _ptTranslations = {
  'app_name': 'Energy Hotel',
  'welcome': 'Bem-vindo',
  'hello': 'Olá',
  'guest': 'Hóspede',
  'welcome_to_hotel': 'Bem-vindo ao Energy Hotel',
  'quick_actions': 'Ações Rápidas',
  'featured_services': 'Serviços em Destaque',
  'promotions': 'Promoções',
  'check_in': 'Check-in',
  'check_out': 'Check-out',
  'days_remaining': 'dias restantes',
  'extend_stay': 'Estender Estadia',
  'room_number': 'Quarto',
  'spa': 'Spa',
  'dining': 'Restaurante',
  'pool': 'Piscina',
  'room_service': 'Serviço de Quarto',
  'profile': 'Perfil',
  'services': 'Serviços',
  'my_reservations': 'Minhas Reservas',
  'upcoming': 'Próximas',
  'past': 'Passadas',
  'no_reservations': 'Sem reservas ainda',
  'see_all': 'Ver Tudo',
  'cancel': 'Cancelar',
  'cancel_reservation': 'Cancelar Reserva',
  'settings': 'Configurações',
  'language': 'Idioma',
  'select_language': 'Selecionar Idioma',
  'notifications': 'Notificações',
  'logout': 'Sair',
  'room_key': 'Chave Digital',
  'billing': 'Faturamento',
  'rewards': 'Recompensas',
  'chat': 'Chat',
  'housekeeping': 'Limpeza',
  'transport': 'Transporte',
  'activities': 'Atividades',
  'hotel_info': 'Info do Hotel',
  'feedback': 'Feedback',
  'explore': 'Explorar',
  'all': 'Tudo',
  'book_now': 'Reservar Agora',
  'confirm': 'Confirmar',
  'total': 'Total',
  'free': 'GRÁTIS',
  'done': 'Pronto',
  'save': 'Salvar',
  'close': 'Fechar',
  'back': 'Voltar',
  'next': 'Próximo',
  'continue': 'Continuar',
  'loading': 'Carregando...',
  'error': 'Erro',
  'success': 'Sucesso',
};

// Chinese translations
const Map<String, String> _zhTranslations = {
  'app_name': 'Energy Hotel',
  'welcome': '欢迎',
  'hello': '你好',
  'guest': '客人',
  'welcome_to_hotel': '欢迎来到 Energy Hotel',
  'quick_actions': '快捷操作',
  'featured_services': '精选服务',
  'promotions': '优惠活动',
  'check_in': '入住',
  'check_out': '退房',
  'days_remaining': '天剩余',
  'extend_stay': '延长住宿',
  'room_number': '房间',
  'spa': '水疗',
  'dining': '餐饮',
  'pool': '泳池',
  'room_service': '客房服务',
  'profile': '个人资料',
  'services': '服务',
  'my_reservations': '我的预订',
  'upcoming': '即将到来',
  'past': '过去',
  'no_reservations': '暂无预订',
  'see_all': '查看全部',
  'cancel': '取消',
  'settings': '设置',
  'language': '语言',
  'select_language': '选择语言',
  'notifications': '通知',
  'logout': '退出',
  'room_key': '数字房卡',
  'billing': '账单',
  'rewards': '奖励',
  'chat': '聊天',
  'housekeeping': '客房清洁',
  'transport': '交通',
  'activities': '活动',
  'hotel_info': '酒店信息',
  'feedback': '反馈',
  'explore': '探索',
  'all': '全部',
  'book_now': '立即预订',
  'confirm': '确认',
  'total': '总计',
  'free': '免费',
  'done': '完成',
  'save': '保存',
  'close': '关闭',
  'back': '返回',
  'next': '下一步',
  'continue': '继续',
  'loading': '加载中...',
  'error': '错误',
  'success': '成功',
};

// Japanese translations
const Map<String, String> _jaTranslations = {
  'app_name': 'Energy Hotel',
  'welcome': 'ようこそ',
  'hello': 'こんにちは',
  'guest': 'ゲスト',
  'welcome_to_hotel': 'Energy Hotelへようこそ',
  'quick_actions': 'クイックアクション',
  'featured_services': 'おすすめサービス',
  'promotions': 'プロモーション',
  'check_in': 'チェックイン',
  'check_out': 'チェックアウト',
  'days_remaining': '日残り',
  'extend_stay': '滞在延長',
  'room_number': '部屋',
  'spa': 'スパ',
  'dining': 'ダイニング',
  'pool': 'プール',
  'room_service': 'ルームサービス',
  'profile': 'プロフィール',
  'services': 'サービス',
  'my_reservations': '予約一覧',
  'settings': '設定',
  'language': '言語',
  'select_language': '言語を選択',
  'notifications': '通知',
  'logout': 'ログアウト',
  'room_key': 'デジタルキー',
  'billing': '請求',
  'rewards': 'リワード',
  'chat': 'チャット',
  'housekeeping': 'ハウスキーピング',
  'transport': '交通',
  'activities': 'アクティビティ',
  'hotel_info': 'ホテル情報',
  'feedback': 'フィードバック',
  'explore': '探索',
  'all': 'すべて',
  'book_now': '今すぐ予約',
  'confirm': '確認',
  'total': '合計',
  'free': '無料',
  'done': '完了',
  'save': '保存',
  'close': '閉じる',
  'back': '戻る',
  'next': '次へ',
  'continue': '続ける',
  'loading': '読み込み中...',
  'error': 'エラー',
  'success': '成功',
};

// Korean translations
const Map<String, String> _koTranslations = {
  'app_name': 'Energy Hotel',
  'welcome': '환영합니다',
  'hello': '안녕하세요',
  'guest': '손님',
  'welcome_to_hotel': 'Energy Hotel에 오신 것을 환영합니다',
  'quick_actions': '빠른 작업',
  'featured_services': '추천 서비스',
  'promotions': '프로모션',
  'check_in': '체크인',
  'check_out': '체크아웃',
  'days_remaining': '일 남음',
  'extend_stay': '숙박 연장',
  'room_number': '객실',
  'spa': '스파',
  'dining': '다이닝',
  'pool': '수영장',
  'room_service': '룸서비스',
  'profile': '프로필',
  'services': '서비스',
  'my_reservations': '내 예약',
  'settings': '설정',
  'language': '언어',
  'select_language': '언어 선택',
  'notifications': '알림',
  'logout': '로그아웃',
  'room_key': '디지털 키',
  'billing': '청구',
  'rewards': '리워드',
  'chat': '채팅',
  'housekeeping': '하우스키핑',
  'transport': '교통',
  'activities': '활동',
  'hotel_info': '호텔 정보',
  'feedback': '피드백',
  'explore': '탐색',
  'all': '전체',
  'book_now': '지금 예약',
  'confirm': '확인',
  'total': '총계',
  'free': '무료',
  'done': '완료',
  'save': '저장',
  'close': '닫기',
  'back': '뒤로',
  'next': '다음',
  'continue': '계속',
  'loading': '로딩 중...',
  'error': '오류',
  'success': '성공',
};

// Arabic translations
const Map<String, String> _arTranslations = {
  'app_name': 'Energy Hotel',
  'welcome': 'مرحباً',
  'hello': 'أهلاً',
  'guest': 'ضيف',
  'welcome_to_hotel': 'مرحباً بك في Energy Hotel',
  'quick_actions': 'إجراءات سريعة',
  'featured_services': 'خدمات مميزة',
  'promotions': 'عروض',
  'check_in': 'تسجيل الدخول',
  'check_out': 'تسجيل الخروج',
  'days_remaining': 'أيام متبقية',
  'extend_stay': 'تمديد الإقامة',
  'room_number': 'غرفة',
  'spa': 'سبا',
  'dining': 'مطعم',
  'pool': 'مسبح',
  'room_service': 'خدمة الغرف',
  'profile': 'الملف الشخصي',
  'services': 'خدمات',
  'my_reservations': 'حجوزاتي',
  'settings': 'الإعدادات',
  'language': 'اللغة',
  'select_language': 'اختر اللغة',
  'notifications': 'الإشعارات',
  'logout': 'تسجيل الخروج',
  'room_key': 'مفتاح رقمي',
  'billing': 'الفواتير',
  'rewards': 'المكافآت',
  'chat': 'محادثة',
  'housekeeping': 'التنظيف',
  'transport': 'النقل',
  'activities': 'الأنشطة',
  'hotel_info': 'معلومات الفندق',
  'feedback': 'التقييم',
  'explore': 'استكشف',
  'all': 'الكل',
  'book_now': 'احجز الآن',
  'confirm': 'تأكيد',
  'total': 'المجموع',
  'free': 'مجاني',
  'done': 'تم',
  'save': 'حفظ',
  'close': 'إغلاق',
  'back': 'رجوع',
  'next': 'التالي',
  'continue': 'متابعة',
  'loading': 'جاري التحميل...',
  'error': 'خطأ',
  'success': 'نجاح',
};
