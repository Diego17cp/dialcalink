import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('pt'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'DialcaLink'**
  String get appTitle;

  /// No description provided for @start.
  ///
  /// In es, this message translates to:
  /// **'Comenzar'**
  String get start;

  /// No description provided for @continueLbl.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get continueLbl;

  /// No description provided for @requestPermissions.
  ///
  /// In es, this message translates to:
  /// **'Solicitar permisos'**
  String get requestPermissions;

  /// No description provided for @permissions.
  ///
  /// In es, this message translates to:
  /// **'Permisos'**
  String get permissions;

  /// No description provided for @attemptAgain.
  ///
  /// In es, this message translates to:
  /// **'Intente nuevamente'**
  String get attemptAgain;

  /// No description provided for @name.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get name;

  /// No description provided for @role.
  ///
  /// In es, this message translates to:
  /// **'Rol'**
  String get role;

  /// No description provided for @uniqueID.
  ///
  /// In es, this message translates to:
  /// **'ID Único'**
  String get uniqueID;

  /// No description provided for @unknownError.
  ///
  /// In es, this message translates to:
  /// **'Error desconocido'**
  String get unknownError;

  /// No description provided for @searchUpdates.
  ///
  /// In es, this message translates to:
  /// **'Buscar actualizaciones'**
  String get searchUpdates;

  /// No description provided for @searching.
  ///
  /// In es, this message translates to:
  /// **'Buscando...'**
  String get searching;

  /// No description provided for @startService.
  ///
  /// In es, this message translates to:
  /// **'Iniciar Servicio'**
  String get startService;

  /// No description provided for @stopService.
  ///
  /// In es, this message translates to:
  /// **'Detener Servicio'**
  String get stopService;

  /// No description provided for @appTheme.
  ///
  /// In es, this message translates to:
  /// **'Aspecto de la aplicación'**
  String get appTheme;

  /// No description provided for @themeSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get themeDark;

  /// No description provided for @clientUp.
  ///
  /// In es, this message translates to:
  /// **'Cliente'**
  String get clientUp;

  /// No description provided for @clientLow.
  ///
  /// In es, this message translates to:
  /// **'cliente'**
  String get clientLow;

  /// No description provided for @gatewayUp.
  ///
  /// In es, this message translates to:
  /// **'Gateway'**
  String get gatewayUp;

  /// No description provided for @gatewayLow.
  ///
  /// In es, this message translates to:
  /// **'gateway'**
  String get gatewayLow;

  /// No description provided for @onboardingWelcomeBadge.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido'**
  String get onboardingWelcomeBadge;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In es, this message translates to:
  /// **'Recibe tus SMS y llamadas en un solo lugar'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Conecta dos dispositivos Android para centralizar toda tu actividad telefónica.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingWelcomeHowWorksTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Cómo funciona?'**
  String get onboardingWelcomeHowWorksTitle;

  /// No description provided for @onboardingWelcomeHowWorksText.
  ///
  /// In es, this message translates to:
  /// **'El dispositivo con SIM comparte SMS y llamadas mediante tu red Wi-Fi local. Tu dispositivo principal recibe en tiempo real.'**
  String get onboardingWelcomeHowWorksText;

  /// No description provided for @onboardingWelcomeInfo.
  ///
  /// In es, this message translates to:
  /// **'Tu información permanece dentro de tu red\nlocal. No utilizamos servidores externos.'**
  String get onboardingWelcomeInfo;

  /// No description provided for @onboardingRoleTitle.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido a DialcaLink'**
  String get onboardingRoleTitle;

  /// No description provided for @onboardingRoleSubtitle1.
  ///
  /// In es, this message translates to:
  /// **'Selecciona cómo utilizarás este dispositivo.'**
  String get onboardingRoleSubtitle1;

  /// No description provided for @onboardingRoleSubtitle2.
  ///
  /// In es, this message translates to:
  /// **'Podrás cambiar esta configuración más adelante.'**
  String get onboardingRoleSubtitle2;

  /// No description provided for @onboardingRoleClientCardTitle.
  ///
  /// In es, this message translates to:
  /// **'Dispositivo Principal'**
  String get onboardingRoleClientCardTitle;

  /// No description provided for @onboardingRoleClientCardInfo.
  ///
  /// In es, this message translates to:
  /// **'Recibe SMS y notificaciones de llamadas desde otro teléfono.'**
  String get onboardingRoleClientCardInfo;

  /// No description provided for @onboardingRoleGatewayCardTitle.
  ///
  /// In es, this message translates to:
  /// **'Dispositivo con SIM'**
  String get onboardingRoleGatewayCardTitle;

  /// No description provided for @onboardingRoleGatewayRCardInfo.
  ///
  /// In es, this message translates to:
  /// **'Comparte SMS y llamadas con tu dispositivo principal'**
  String get onboardingRoleGatewayRCardInfo;

  /// No description provided for @onboardingPermissionsTitle.
  ///
  /// In es, this message translates to:
  /// **'Permisos necesarios'**
  String get onboardingPermissionsTitle;

  /// No description provided for @onboardingPermissionsSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Para continuar, necesitamos que otorgues los permisos necesarios para el correcto funcionamiento de la aplicación.'**
  String get onboardingPermissionsSubtitle;

  /// No description provided for @onboardingPermissionsManualGrant.
  ///
  /// In es, this message translates to:
  /// **'Ir a Ajustes para permitir manualmente'**
  String get onboardingPermissionsManualGrant;

  /// No description provided for @permissionSMSTitle.
  ///
  /// In es, this message translates to:
  /// **'Mensajes SMS'**
  String get permissionSMSTitle;

  /// No description provided for @permissionSMSDescription.
  ///
  /// In es, this message translates to:
  /// **'Necesario para detectar SMS entrantes en el Gateway.'**
  String get permissionSMSDescription;

  /// No description provided for @permissionPhoneTitle.
  ///
  /// In es, this message translates to:
  /// **'Estado del teléfono'**
  String get permissionPhoneTitle;

  /// No description provided for @permissionPhoneDescription.
  ///
  /// In es, this message translates to:
  /// **'Necesario para detectar llamadas entrantes en el Gateway.'**
  String get permissionPhoneDescription;

  /// No description provided for @permissionContactsTitle.
  ///
  /// In es, this message translates to:
  /// **'Contactos'**
  String get permissionContactsTitle;

  /// No description provided for @permissionContactsDescription.
  ///
  /// In es, this message translates to:
  /// **'Permite mostrar nombres en vez de números en SMS y llamadas.'**
  String get permissionContactsDescription;

  /// No description provided for @permissionLocationTitle.
  ///
  /// In es, this message translates to:
  /// **'Ubicación (red Wi-Fi)'**
  String get permissionLocationTitle;

  /// No description provided for @permissionLocationDescription.
  ///
  /// In es, this message translates to:
  /// **'Android requiere este permiso para detectar la IP de la red Wi-Fi activa.'**
  String get permissionLocationDescription;

  /// No description provided for @permissionCameraTitle.
  ///
  /// In es, this message translates to:
  /// **'Cámara'**
  String get permissionCameraTitle;

  /// No description provided for @permissionCameraDescription.
  ///
  /// In es, this message translates to:
  /// **'Necesario para escanear el código QR de vinculación.'**
  String get permissionCameraDescription;

  /// No description provided for @permissionNotificationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get permissionNotificationsTitle;

  /// No description provided for @permissionNotificationsDescription.
  ///
  /// In es, this message translates to:
  /// **'Permite recibir alertas de SMS y llamadas entrantes.'**
  String get permissionNotificationsDescription;

  /// No description provided for @permissionPhoneHistoryTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial de llamadas'**
  String get permissionPhoneHistoryTitle;

  /// No description provided for @permissionPhoneHistoryDescription.
  ///
  /// In es, this message translates to:
  /// **'Necesario para detectar llamadas entrantes en el Gateway.'**
  String get permissionPhoneHistoryDescription;

  /// No description provided for @onboardingPairingTitle.
  ///
  /// In es, this message translates to:
  /// **'Vincular dispositivo'**
  String get onboardingPairingTitle;

  /// No description provided for @pairingStatusSearchingTitle.
  ///
  /// In es, this message translates to:
  /// **'Buscando código QR'**
  String get pairingStatusSearchingTitle;

  /// No description provided for @pairingStatusSearchingSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Apunta al código QR para iniciar el emparejamiento.'**
  String get pairingStatusSearchingSubtitle;

  /// No description provided for @pairingStatusVerifyingTitle.
  ///
  /// In es, this message translates to:
  /// **'Verificando...'**
  String get pairingStatusVerifyingTitle;

  /// No description provided for @pairingStatusVerifyingSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Validando conexión con el dispositivo.'**
  String get pairingStatusVerifyingSubtitle;

  /// No description provided for @pairingStatusInvalidQRTitle.
  ///
  /// In es, this message translates to:
  /// **'Código QR inválido'**
  String get pairingStatusInvalidQRTitle;

  /// No description provided for @pairingStatusInvalidQRSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Este QR no es de un DialcaLink válido.'**
  String get pairingStatusInvalidQRSubtitle;

  /// No description provided for @pairingStatusFailedTitle.
  ///
  /// In es, this message translates to:
  /// **'Error de emparejamiento'**
  String get pairingStatusFailedTitle;

  /// No description provided for @pairingStatusFailedSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Ocurrió un error durante el emparejamiento.'**
  String get pairingStatusFailedSubtitle;

  /// No description provided for @pairingSuccessTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Emparejamiento exitoso!'**
  String get pairingSuccessTitle;

  /// No description provided for @pairingSuccessSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Tu dispositivo ahora está sincronizado con el Gateway. Redirigiendo...'**
  String get pairingSuccessSubtitle;

  /// No description provided for @onboardingPairingPINSheetTitle.
  ///
  /// In es, this message translates to:
  /// **'Vincular con código'**
  String get onboardingPairingPINSheetTitle;

  /// No description provided for @onboardingPairingPINSheetReattempt.
  ///
  /// In es, this message translates to:
  /// **'Reintentar búsqueda'**
  String get onboardingPairingPINSheetReattempt;

  /// No description provided for @onboardingPairingPINSheetSearching.
  ///
  /// In es, this message translates to:
  /// **'Buscando Gateway en la red...'**
  String get onboardingPairingPINSheetSearching;

  /// No description provided for @onboardingPairingPINSheetLabelGatewayDetected.
  ///
  /// In es, this message translates to:
  /// **'Gateway detectado'**
  String get onboardingPairingPINSheetLabelGatewayDetected;

  /// No description provided for @onboardingPairingPINSheetLabelGatewayIP.
  ///
  /// In es, this message translates to:
  /// **'IP del Gateway'**
  String get onboardingPairingPINSheetLabelGatewayIP;

  /// No description provided for @onboardingPairingPINSheetLabelGatewayHint.
  ///
  /// In es, this message translates to:
  /// **'192.168.43.1 o 192.168.1.X'**
  String get onboardingPairingPINSheetLabelGatewayHint;

  /// No description provided for @onboardingPairingPINSheetLabelPIN.
  ///
  /// In es, this message translates to:
  /// **'PIN de 6 dígitos'**
  String get onboardingPairingPINSheetLabelPIN;

  /// No description provided for @onboardingPairingPINSheetBtnPair.
  ///
  /// In es, this message translates to:
  /// **'Vincular Dispositivo'**
  String get onboardingPairingPINSheetBtnPair;

  /// No description provided for @onboardingPairingPINSheetErrorMessage.
  ///
  /// In es, this message translates to:
  /// **'Ingresa la IP y el PIN de 6 dígitos.'**
  String get onboardingPairingPINSheetErrorMessage;

  /// No description provided for @onboardingGatewaySetupAppbarTitle.
  ///
  /// In es, this message translates to:
  /// **'Configurar Gateway'**
  String get onboardingGatewaySetupAppbarTitle;

  /// No description provided for @onboardingGatewaySetupTitle.
  ///
  /// In es, this message translates to:
  /// **'Preparar el dispositivo como Gateway'**
  String get onboardingGatewaySetupTitle;

  /// No description provided for @onboardingGatewaySetupSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Configure su dispositivo para actuar como un punto de enlace de comunicación.'**
  String get onboardingGatewaySetupSubtitle;

  /// No description provided for @onboardingGatewaySetupGrantPermissionsError.
  ///
  /// In es, this message translates to:
  /// **'Por favor, conceda todos los permisos requeridos.'**
  String get onboardingGatewaySetupGrantPermissionsError;

  /// No description provided for @onboardingGatewaySetupError.
  ///
  /// In es, this message translates to:
  /// **'Error al iniciar el servicio de Gateway:'**
  String get onboardingGatewaySetupError;

  /// No description provided for @onboardingGatewayInactive.
  ///
  /// In es, this message translates to:
  /// **'No se pudo confirmar que el servicio de Gateway esté en ejecución.'**
  String get onboardingGatewayInactive;

  /// No description provided for @onboardingGatewayStarting.
  ///
  /// In es, this message translates to:
  /// **'Iniciando servicio Gateway...'**
  String get onboardingGatewayStarting;

  /// No description provided for @onboardingGatewayConfirming.
  ///
  /// In es, this message translates to:
  /// **'Verificando que el servicio esté activo...'**
  String get onboardingGatewayConfirming;

  /// No description provided for @onboardingGatewayErrorIdentity.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar identidad:'**
  String get onboardingGatewayErrorIdentity;

  /// No description provided for @onboardingGatewayErrorNoIdentity.
  ///
  /// In es, this message translates to:
  /// **'No se encontró identidad del dispositivo.'**
  String get onboardingGatewayErrorNoIdentity;

  /// No description provided for @onboardingGatewayErrorPermissionsError.
  ///
  /// In es, this message translates to:
  /// **'Error al verificar permisos:'**
  String get onboardingGatewayErrorPermissionsError;

  /// No description provided for @onboardingGatewaySetupPermissionsGranted.
  ///
  /// In es, this message translates to:
  /// **'Permisos concedidos'**
  String get onboardingGatewaySetupPermissionsGranted;

  /// No description provided for @onboardingGatewaySetupPermissionsGrantedSubtitle.
  ///
  /// In es, this message translates to:
  /// **'SMS, Llamadas y Estado de Red aprobados.'**
  String get onboardingGatewaySetupPermissionsGrantedSubtitle;

  /// No description provided for @onboardingGatewaySetupPermissionsNotGrantedSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Faltan autorizar permisos requeridos por el rol.'**
  String get onboardingGatewaySetupPermissionsNotGrantedSubtitle;

  /// No description provided for @onboardingGatewaySetupDeviceConfigured.
  ///
  /// In es, this message translates to:
  /// **'Dispositivo configurado'**
  String get onboardingGatewaySetupDeviceConfigured;

  /// No description provided for @onboardingGatewaySetupDeviceConfiguredSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Configuraciones base listas.'**
  String get onboardingGatewaySetupDeviceConfiguredSubtitle;

  /// No description provided for @onboardingGatewaySetupHotspot.
  ///
  /// In es, this message translates to:
  /// **'Hotspot (Punto de Acceso)'**
  String get onboardingGatewaySetupHotspot;

  /// No description provided for @onboardingGatewaySetupHotspotVerifying.
  ///
  /// In es, this message translates to:
  /// **'Verificando Hotspot...'**
  String get onboardingGatewaySetupHotspotVerifying;

  /// No description provided for @onboardingGatewaySetupHotspotResolved.
  ///
  /// In es, this message translates to:
  /// **'Punto de acceso activo en:'**
  String get onboardingGatewaySetupHotspotResolved;

  /// No description provided for @onboardingGatewaySetupHotspotNotConnected.
  ///
  /// In es, this message translates to:
  /// **'Hotspot desactivado. Por favor, actívelo.'**
  String get onboardingGatewaySetupHotspotNotConnected;

  /// No description provided for @onboardingGatewaySetupHotspotNotPermission.
  ///
  /// In es, this message translates to:
  /// **'Faltan permisos de ubicación para detectar la red.'**
  String get onboardingGatewaySetupHotspotNotPermission;

  /// No description provided for @onboardingGatewaySetupHotspotNot.
  ///
  /// In es, this message translates to:
  /// **'No se pudo detectar el Hotspot.'**
  String get onboardingGatewaySetupHotspotNot;

  /// No description provided for @onboardingGatewaySetupBtnActivate.
  ///
  /// In es, this message translates to:
  /// **'Activar Gateway'**
  String get onboardingGatewaySetupBtnActivate;

  /// No description provided for @gatewayHomeAppbarTitle.
  ///
  /// In es, this message translates to:
  /// **'DialcaLink Gateway'**
  String get gatewayHomeAppbarTitle;

  /// No description provided for @gatewayStatusTitleDisconnected.
  ///
  /// In es, this message translates to:
  /// **'Servicio apagado'**
  String get gatewayStatusTitleDisconnected;

  /// No description provided for @gatewayStatusSubtitleDisconnected.
  ///
  /// In es, this message translates to:
  /// **'El gateway no está procesando datos.'**
  String get gatewayStatusSubtitleDisconnected;

  /// No description provided for @gatewayStatusTitleConnected.
  ///
  /// In es, this message translates to:
  /// **'Gateway Conectado'**
  String get gatewayStatusTitleConnected;

  /// No description provided for @gatewayStatusSubtitleConnected.
  ///
  /// In es, this message translates to:
  /// **'Sincronizando con'**
  String get gatewayStatusSubtitleConnected;

  /// No description provided for @gatewayStatusTitleConnecting.
  ///
  /// In es, this message translates to:
  /// **'Esperando Cliente...'**
  String get gatewayStatusTitleConnecting;

  /// No description provided for @gatewayStatusSubtitleConnecting.
  ///
  /// In es, this message translates to:
  /// **'El gateway está activo pero no hay clientes conectados.'**
  String get gatewayStatusSubtitleConnecting;

  /// No description provided for @gatewayShowQRSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Muestra el código QR en el otro dispositivo para vincularlo con este.'**
  String get gatewayShowQRSubtitle;

  /// No description provided for @gatewayStatMessagesTitle.
  ///
  /// In es, this message translates to:
  /// **'Mensajes'**
  String get gatewayStatMessagesTitle;

  /// No description provided for @gatewayStatCallsTitle.
  ///
  /// In es, this message translates to:
  /// **'Llamadas'**
  String get gatewayStatCallsTitle;

  /// No description provided for @gatewayStatTodayLow.
  ///
  /// In es, this message translates to:
  /// **'hoy'**
  String get gatewayStatTodayLow;

  /// No description provided for @gatewayDeviceInfo.
  ///
  /// In es, this message translates to:
  /// **'Información del Dispositivo'**
  String get gatewayDeviceInfo;

  /// No description provided for @gatewayDeviceInfoName.
  ///
  /// In es, this message translates to:
  /// **'Nombre del Dispositivo'**
  String get gatewayDeviceInfoName;

  /// No description provided for @gatewayDeviceInfoIP.
  ///
  /// In es, this message translates to:
  /// **'IP del Dispositivo'**
  String get gatewayDeviceInfoIP;

  /// No description provided for @gatewayDeviceInfoNotIP.
  ///
  /// In es, this message translates to:
  /// **'No disponible'**
  String get gatewayDeviceInfoNotIP;

  /// No description provided for @gatewayDeviceInfoStartedFrom.
  ///
  /// In es, this message translates to:
  /// **'Activo desde'**
  String get gatewayDeviceInfoStartedFrom;

  /// No description provided for @gatewayDeviceInfoActivityTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo de actividad'**
  String get gatewayDeviceInfoActivityTime;

  /// No description provided for @gatewayDeviceInfoNotStarted.
  ///
  /// In es, this message translates to:
  /// **'No Iniciado'**
  String get gatewayDeviceInfoNotStarted;

  /// No description provided for @gatewayPairTitle.
  ///
  /// In es, this message translates to:
  /// **'Casi listo para conectar'**
  String get gatewayPairTitle;

  /// No description provided for @gatewayPairSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Abre DialcaLink en tu dispositivo principal y escanea el código QR.'**
  String get gatewayPairSubtitle;

  /// No description provided for @gatewayPairReadyToScan.
  ///
  /// In es, this message translates to:
  /// **'Listo para escanear'**
  String get gatewayPairReadyToScan;

  /// No description provided for @gatewayPairPINHint.
  ///
  /// In es, this message translates to:
  /// **'O vincula ingresando este código en el cliente:'**
  String get gatewayPairPINHint;

  /// No description provided for @gatewayBtnDone.
  ///
  /// In es, this message translates to:
  /// **'Hecho'**
  String get gatewayBtnDone;

  /// No description provided for @gatewayBtnGenerateCode.
  ///
  /// In es, this message translates to:
  /// **'Generar nuevo código'**
  String get gatewayBtnGenerateCode;

  /// No description provided for @clientSmsListEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'No hay SMS disponibles'**
  String get clientSmsListEmptyTitle;

  /// No description provided for @clientSmsListEmptySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Cuando recibas un SMS, aparecerá aquí.'**
  String get clientSmsListEmptySubtitle;

  /// No description provided for @clientSmsChatErrorSending.
  ///
  /// In es, this message translates to:
  /// **'No se pudo enviar el mensaje'**
  String get clientSmsChatErrorSending;

  /// No description provided for @clientSmsChatErrorLoadingMessages.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar mensajes:'**
  String get clientSmsChatErrorLoadingMessages;

  /// No description provided for @clientNewSmsErrorSend.
  ///
  /// In es, this message translates to:
  /// **'Por favor, indica el número de teléfono y el contenido del mensaje'**
  String get clientNewSmsErrorSend;

  /// No description provided for @clientNewSmsAppbarTitle.
  ///
  /// In es, this message translates to:
  /// **'Nuevo SMS'**
  String get clientNewSmsAppbarTitle;

  /// No description provided for @clientNewSmsLoadingContacts.
  ///
  /// In es, this message translates to:
  /// **'Cargando contactos...'**
  String get clientNewSmsLoadingContacts;

  /// No description provided for @clientNewSmsSuggestions.
  ///
  /// In es, this message translates to:
  /// **'Sugerencias'**
  String get clientNewSmsSuggestions;

  /// No description provided for @clientNewSmsLabelTextarea.
  ///
  /// In es, this message translates to:
  /// **'Escribe tu mensaje...'**
  String get clientNewSmsLabelTextarea;

  /// No description provided for @clientNewSmsBtnSend.
  ///
  /// In es, this message translates to:
  /// **'Enviar SMS'**
  String get clientNewSmsBtnSend;

  /// No description provided for @clientCallsListEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'No hay llamadas disponibles'**
  String get clientCallsListEmptyTitle;

  /// No description provided for @clientCallsListEmptySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Cuando recibas una llamada, aparecerá aquí.'**
  String get clientCallsListEmptySubtitle;

  /// No description provided for @clientCallsItemCourse.
  ///
  /// In es, this message translates to:
  /// **'En curso'**
  String get clientCallsItemCourse;

  /// No description provided for @clientStatusAppbarTitle.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get clientStatusAppbarTitle;

  /// No description provided for @clientStatusDisconnectedTitle.
  ///
  /// In es, this message translates to:
  /// **'Servicio Desconectado'**
  String get clientStatusDisconnectedTitle;

  /// No description provided for @clientStatusDisconnectedSubtitle.
  ///
  /// In es, this message translates to:
  /// **'El servicio de cliente no se encuentra activo.'**
  String get clientStatusDisconnectedSubtitle;

  /// No description provided for @clientStatusConnectedTitle.
  ///
  /// In es, this message translates to:
  /// **'Servicio Activo'**
  String get clientStatusConnectedTitle;

  /// No description provided for @clientStatusConnectedSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Sincronizando con el Gateway.'**
  String get clientStatusConnectedSubtitle;

  /// No description provided for @clientStatusConnectingTitle.
  ///
  /// In es, this message translates to:
  /// **'Estableciendo Conexión...'**
  String get clientStatusConnectingTitle;

  /// No description provided for @clientStatusConnectingSubtitle.
  ///
  /// In es, this message translates to:
  /// **'El servicio está buscando el Gateway.'**
  String get clientStatusConnectingSubtitle;

  /// No description provided for @clientStatusWaitingTitle.
  ///
  /// In es, this message translates to:
  /// **'Esperando Gateway...'**
  String get clientStatusWaitingTitle;

  /// No description provided for @clientStatusWaitingSubtitle.
  ///
  /// In es, this message translates to:
  /// **'El servicio de cliente está activo pero desconectado.'**
  String get clientStatusWaitingSubtitle;

  /// No description provided for @clientStatusCardTitle.
  ///
  /// In es, this message translates to:
  /// **'Estado del Servicio  del Cliente'**
  String get clientStatusCardTitle;

  /// No description provided for @clientStatusVerifying.
  ///
  /// In es, this message translates to:
  /// **'Verificando...'**
  String get clientStatusVerifying;

  /// No description provided for @clientStatusError.
  ///
  /// In es, this message translates to:
  /// **'Error al obtener estado'**
  String get clientStatusError;

  /// No description provided for @clientStatusInfo.
  ///
  /// In es, this message translates to:
  /// **'Información del Gateway'**
  String get clientStatusInfo;

  /// No description provided for @clientStatusDevice.
  ///
  /// In es, this message translates to:
  /// **'Dispositivo'**
  String get clientStatusDevice;

  /// No description provided for @clientStatusIP.
  ///
  /// In es, this message translates to:
  /// **'Dirección IP'**
  String get clientStatusIP;

  /// No description provided for @clientStatusLastSync.
  ///
  /// In es, this message translates to:
  /// **'Última sincronización'**
  String get clientStatusLastSync;

  /// No description provided for @clientStatusBtnReSync.
  ///
  /// In es, this message translates to:
  /// **'Re-vincular Dispositivo'**
  String get clientStatusBtnReSync;

  /// No description provided for @clientStatusBtnForceSync.
  ///
  /// In es, this message translates to:
  /// **'Forzar reconexión'**
  String get clientStatusBtnForceSync;

  /// No description provided for @clientStatusBtnForgot.
  ///
  /// In es, this message translates to:
  /// **'Olvidar este Gateway'**
  String get clientStatusBtnForgot;

  /// No description provided for @clientStatusEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'No hay ningún Gateway vinculado.'**
  String get clientStatusEmptyTitle;

  /// No description provided for @clientStatusSync.
  ///
  /// In es, this message translates to:
  /// **'Vincular Dispositivo'**
  String get clientStatusSync;

  /// No description provided for @clientStatusForgotDialogTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidar Gateway?'**
  String get clientStatusForgotDialogTitle;

  /// No description provided for @clientStatusForgotDialogInfo.
  ///
  /// In es, this message translates to:
  /// **'Se perderá la conexión y tendrás que vincularlo nuevamente para recibir SMS y llamadas.'**
  String get clientStatusForgotDialogInfo;

  /// No description provided for @clientStatusForgotDialogBtnCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get clientStatusForgotDialogBtnCancel;

  /// No description provided for @clientStatusForgotDialogBtnForgot.
  ///
  /// In es, this message translates to:
  /// **'Olvidar'**
  String get clientStatusForgotDialogBtnForgot;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'pt',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
