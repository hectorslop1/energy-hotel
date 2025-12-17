// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Energy Hotel';

  @override
  String get welcome => 'Bienvenido';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get loginButton => 'Iniciar Sesión';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get home => 'Inicio';

  @override
  String get explore => 'Explorar';

  @override
  String get map => 'Mapa';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Configuración';

  @override
  String get language => 'Idioma';

  @override
  String get biometrics => 'Autenticación Biométrica';

  @override
  String get enableBiometrics => 'Habilitar Face ID / Huella';

  @override
  String get wallet => 'Cartera';

  @override
  String get addCard => 'Agregar Tarjeta';

  @override
  String get paymentMethods => 'Métodos de Pago';

  @override
  String get defaultCard => 'Predeterminada';

  @override
  String get pay => 'Pagar';

  @override
  String get book => 'Reservar Ahora';

  @override
  String get bookingConfirmed => 'Reserva Confirmada';

  @override
  String get paymentSuccess => 'Pago Exitoso';

  @override
  String get activities => 'Actividades';

  @override
  String get restaurants => 'Restaurantes';

  @override
  String get amenities => 'Amenidades';

  @override
  String get nearbyPlaces => 'Lugares Cercanos';

  @override
  String get featured => 'Destacados';

  @override
  String get recommended => 'Recomendado para Ti';

  @override
  String get seeAll => 'Ver Todo';

  @override
  String get search => 'Buscar';

  @override
  String get filters => 'Filtros';

  @override
  String get price => 'Precio';

  @override
  String get description => 'Descripción';

  @override
  String get details => 'Detalles';

  @override
  String get loading => 'Cargando...';

  @override
  String get error => 'Algo salió mal';

  @override
  String get retry => 'Reintentar';

  @override
  String get noResults => 'No se encontraron resultados';

  @override
  String greeting(String name) {
    return 'Hola, $name';
  }

  @override
  String get cardNumber => 'Número de Tarjeta';

  @override
  String get expiryDate => 'Fecha de Vencimiento';

  @override
  String get cvv => 'CVV';

  @override
  String get cardholderName => 'Nombre del Titular';

  @override
  String get saveCard => 'Guardar Tarjeta';

  @override
  String get selectCard => 'Seleccionar Método de Pago';

  @override
  String get confirmPayment => 'Confirmar Pago';

  @override
  String get total => 'Total';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get done => 'Listo';

  @override
  String get back => 'Atrás';

  @override
  String get next => 'Siguiente';

  @override
  String get skip => 'Omitir';

  @override
  String get invalidEmail => 'Por favor ingresa un correo válido';

  @override
  String get invalidPassword =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get loginFailed => 'Error al iniciar sesión. Intenta de nuevo.';

  @override
  String get biometricPrompt => 'Autentícate para continuar';

  @override
  String get biometricFailed => 'Autenticación fallida';
}
