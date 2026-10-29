// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'DialcaLink';

  @override
  String get start => 'Comenzar';

  @override
  String get continueLbl => 'Continuar';

  @override
  String get requestPermissions => 'Solicitar permisos';

  @override
  String get permissions => 'Permisos';

  @override
  String get attemptAgain => 'Intente nuevamente';

  @override
  String get name => 'Nombre';

  @override
  String get role => 'Rol';

  @override
  String get uniqueID => 'ID Único';

  @override
  String get unknownError => 'Error desconocido';

  @override
  String get searchUpdates => 'Buscar actualizaciones';

  @override
  String get searching => 'Buscando...';

  @override
  String get startService => 'Iniciar Servicio';

  @override
  String get stopService => 'Detener Servicio';

  @override
  String get appTheme => 'Aspecto de la aplicación';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get clientUp => 'Cliente';

  @override
  String get clientLow => 'cliente';

  @override
  String get gatewayUp => 'Gateway';

  @override
  String get gatewayLow => 'gateway';

  @override
  String get onboardingWelcomeBadge => 'Bienvenido';

  @override
  String get onboardingWelcomeTitle =>
      'Recibe tus SMS y llamadas en un solo lugar';

  @override
  String get onboardingWelcomeSubtitle =>
      'Conecta dos dispositivos Android para centralizar toda tu actividad telefónica.';

  @override
  String get onboardingWelcomeHowWorksTitle => '¿Cómo funciona?';

  @override
  String get onboardingWelcomeHowWorksText =>
      'El dispositivo con SIM comparte SMS y llamadas mediante tu red Wi-Fi local. Tu dispositivo principal recibe en tiempo real.';

  @override
  String get onboardingWelcomeInfo =>
      'Tu información permanece dentro de tu red\nlocal. No utilizamos servidores externos.';

  @override
  String get onboardingRoleTitle => 'Bienvenido a DialcaLink';

  @override
  String get onboardingRoleSubtitle1 =>
      'Selecciona cómo utilizarás este dispositivo.';

  @override
  String get onboardingRoleSubtitle2 =>
      'Podrás cambiar esta configuración más adelante.';

  @override
  String get onboardingRoleClientCardTitle => 'Dispositivo Principal';

  @override
  String get onboardingRoleClientCardInfo =>
      'Recibe SMS y notificaciones de llamadas desde otro teléfono.';

  @override
  String get onboardingRoleGatewayCardTitle => 'Dispositivo con SIM';

  @override
  String get onboardingRoleGatewayRCardInfo =>
      'Comparte SMS y llamadas con tu dispositivo principal';

  @override
  String get onboardingPermissionsTitle => 'Permisos necesarios';

  @override
  String get onboardingPermissionsSubtitle =>
      'Para continuar, necesitamos que otorgues los permisos necesarios para el correcto funcionamiento de la aplicación.';

  @override
  String get onboardingPermissionsManualGrant =>
      'Ir a Ajustes para permitir manualmente';

  @override
  String get permissionSMSTitle => 'Mensajes SMS';

  @override
  String get permissionSMSDescription =>
      'Necesario para detectar SMS entrantes en el Gateway.';

  @override
  String get permissionPhoneTitle => 'Estado del teléfono';

  @override
  String get permissionPhoneDescription =>
      'Necesario para detectar llamadas entrantes en el Gateway.';

  @override
  String get permissionContactsTitle => 'Contactos';

  @override
  String get permissionContactsDescription =>
      'Permite mostrar nombres en vez de números en SMS y llamadas.';

  @override
  String get permissionLocationTitle => 'Ubicación (red Wi-Fi)';

  @override
  String get permissionLocationDescription =>
      'Android requiere este permiso para detectar la IP de la red Wi-Fi activa.';

  @override
  String get permissionCameraTitle => 'Cámara';

  @override
  String get permissionCameraDescription =>
      'Necesario para escanear el código QR de vinculación.';

  @override
  String get permissionNotificationsTitle => 'Notificaciones';

  @override
  String get permissionNotificationsDescription =>
      'Permite recibir alertas de SMS y llamadas entrantes.';

  @override
  String get permissionPhoneHistoryTitle => 'Historial de llamadas';

  @override
  String get permissionPhoneHistoryDescription =>
      'Necesario para detectar llamadas entrantes en el Gateway.';

  @override
  String get onboardingPairingTitle => 'Vincular dispositivo';

  @override
  String get pairingStatusSearchingTitle => 'Buscando código QR';

  @override
  String get pairingStatusSearchingSubtitle =>
      'Apunta al código QR para iniciar el emparejamiento.';

  @override
  String get pairingStatusVerifyingTitle => 'Verificando...';

  @override
  String get pairingStatusVerifyingSubtitle =>
      'Validando conexión con el dispositivo.';

  @override
  String get pairingStatusInvalidQRTitle => 'Código QR inválido';

  @override
  String get pairingStatusInvalidQRSubtitle =>
      'Este QR no es de un DialcaLink válido.';

  @override
  String get pairingStatusFailedTitle => 'Error de emparejamiento';

  @override
  String get pairingStatusFailedSubtitle =>
      'Ocurrió un error durante el emparejamiento.';

  @override
  String get pairingSuccessTitle => '¡Emparejamiento exitoso!';

  @override
  String get pairingSuccessSubtitle =>
      'Tu dispositivo ahora está sincronizado con el Gateway. Redirigiendo...';

  @override
  String get onboardingPairingPINSheetTitle => 'Vincular con código';

  @override
  String get onboardingPairingPINSheetReattempt => 'Reintentar búsqueda';

  @override
  String get onboardingPairingPINSheetSearching =>
      'Buscando Gateway en la red...';

  @override
  String get onboardingPairingPINSheetLabelGatewayDetected => 'IP del Gateway';

  @override
  String get onboardingPairingPINSheetLabelGatewayHint =>
      '192.168.43.1 o 192.168.1.X';

  @override
  String get onboardingPairingPINSheetLabelPIN => 'PIN de 6 dígitos';

  @override
  String get onboardingPairingPINSheetBtnPair => 'Vincular Dispositivo';

  @override
  String get onboardingPairingPINSheetErrorMessage =>
      'Ingresa la IP y el PIN de 6 dígitos.';

  @override
  String get onboardingGatewaySetupAppbarTitle => 'Configurar Gateway';

  @override
  String get onboardingGatewaySetupTitle =>
      'Preparar el dispositivo como Gateway';

  @override
  String get onboardingGatewaySetupSubtitle =>
      'Configure su dispositivo para actuar como un punto de enlace de comunicación.';

  @override
  String get onboardingGatewaySetupGrantPermissionsError =>
      'Por favor, conceda todos los permisos requeridos.';

  @override
  String get onboardingGatewaySetupError =>
      'Error al iniciar el servicio de Gateway:';

  @override
  String get onboardingGatewayInactive =>
      'No se pudo confirmar que el servicio de Gateway esté en ejecución.';

  @override
  String get onboardingGatewayStarting => 'Iniciando servicio Gateway...';

  @override
  String get onboardingGatewayConfirming =>
      'Verificando que el servicio esté activo...';

  @override
  String get onboardingGatewayErrorIdentity => 'Error al cargar identidad:';

  @override
  String get onboardingGatewayErrorNoIdentity =>
      'No se encontró identidad del dispositivo.';

  @override
  String get onboardingGatewayErrorPermissionsError =>
      'Error al verificar permisos:';

  @override
  String get onboardingGatewaySetupPermissionsGranted => 'Permisos concedidos';

  @override
  String get onboardingGatewaySetupPermissionsGrantedSubtitle =>
      'SMS, Llamadas y Estado de Red aprobados.';

  @override
  String get onboardingGatewaySetupPermissionsNotGrantedSubtitle =>
      'Faltan autorizar permisos requeridos por el rol.';

  @override
  String get onboardingGatewaySetupDeviceConfigured =>
      'Dispositivo configurado';

  @override
  String get onboardingGatewaySetupDeviceConfiguredSubtitle =>
      'Configuraciones base listas.';

  @override
  String get onboardingGatewaySetupHotspot => 'Hotspot (Punto de Acceso)';

  @override
  String get onboardingGatewaySetupHotspotVerifying => 'Verificando Hotspot...';

  @override
  String get onboardingGatewaySetupHotspotResolved =>
      'Punto de acceso activo en:';

  @override
  String get onboardingGatewaySetupHotspotNotConnected =>
      'Hotspot desactivado. Por favor, actívelo.';

  @override
  String get onboardingGatewaySetupHotspotNotPermission =>
      'Faltan permisos de ubicación para detectar la red.';

  @override
  String get onboardingGatewaySetupHotspotNot =>
      'No se pudo detectar el Hotspot.';

  @override
  String get onboardingGatewaySetupBtnActivate => 'Activar Gateway';

  @override
  String get gatewayHomeAppbarTitle => 'DialcaLink Gateway';

  @override
  String get gatewayStatusTitleDisconnected => 'Servicio apagado';

  @override
  String get gatewayStatusSubtitleDisconnected =>
      'El gateway no está procesando datos.';

  @override
  String get gatewayStatusTitleConnected => 'Gateway Conectado';

  @override
  String get gatewayStatusSubtitleConnected => 'Sincronizando con';

  @override
  String get gatewayStatusTitleConnecting => 'Esperando Cliente...';

  @override
  String get gatewayStatusSubtitleConnecting =>
      'El gateway está activo pero no hay clientes conectados.';

  @override
  String get gatewayShowQRSubtitle =>
      'Muestra el código QR en el otro dispositivo para vincularlo con este.';

  @override
  String get gatewayStatMessagesTitle => 'Mensajes';

  @override
  String get gatewayStatCallsTitle => 'Llamadas';

  @override
  String get gatewayStatTodayLow => 'hoy';

  @override
  String get gatewayDeviceInfo => 'Información del Dispositivo';

  @override
  String get gatewayDeviceInfoName => 'Nombre del Dispositivo';

  @override
  String get gatewayDeviceInfoIP => 'IP del Dispositivo';

  @override
  String get gatewayDeviceInfoNotIP => 'No disponible';

  @override
  String get gatewayDeviceInfoStartedFrom => 'Activo desde';

  @override
  String get gatewayDeviceInfoActivityTime => 'Tiempo de actividad';

  @override
  String get gatewayDeviceInfoNotStarted => 'No Iniciado';

  @override
  String get gatewayPairTitle => 'Casi listo para conectar';

  @override
  String get gatewayPairSubtitle =>
      'Abre DialcaLink en tu dispositivo principal y escanea el código QR.';

  @override
  String get gatewayPairReadyToScan => 'Listo para escanear';

  @override
  String get gatewayPairPINHint =>
      'O vincula ingresando este código en el cliente:';

  @override
  String get gatewayBtnDone => 'Hecho';

  @override
  String get gatewayBtnGenerateCode => 'Generar nuevo código';

  @override
  String get clientSmsListEmptyTitle => 'No hay SMS disponibles';

  @override
  String get clientSmsListEmptySubtitle =>
      'Cuando recibas un SMS, aparecerá aquí.';

  @override
  String get clientSmsChatErrorSending => 'No se pudo enviar el mensaje';

  @override
  String get clientSmsChatErrorLoadingMessages => 'Error al cargar mensajes:';

  @override
  String get clientNewSmsErrorSend =>
      'Por favor, indica el número de teléfono y el contenido del mensaje';

  @override
  String get clientNewSmsAppbarTitle => 'Nuevo SMS';

  @override
  String get clientNewSmsLoadingContacts => 'Cargando contactos...';

  @override
  String get clientNewSmsSuggestions => 'Sugerencias';

  @override
  String get clientNewSmsLabelTextarea => 'Escribe tu mensaje...';

  @override
  String get clientNewSmsBtnSend => 'Enviar SMS';

  @override
  String get clientCallsListEmptyTitle => 'No hay llamadas disponibles';

  @override
  String get clientCallsListEmptySubtitle =>
      'Cuando recibas una llamada, aparecerá aquí.';

  @override
  String get clientCallsItemCourse => 'En curso';

  @override
  String get clientStatusAppbarTitle => 'Estado';

  @override
  String get clientStatusDisconnectedTitle => 'Servicio Desconectado';

  @override
  String get clientStatusDisconnectedSubtitle =>
      'El servicio de cliente no se encuentra activo.';

  @override
  String get clientStatusConnectedTitle => 'Servicio Activo';

  @override
  String get clientStatusConnectedSubtitle => 'Sincronizando con el Gateway.';

  @override
  String get clientStatusConnectingTitle => 'Estableciendo Conexión...';

  @override
  String get clientStatusConnectingSubtitle =>
      'El servicio está buscando el Gateway.';

  @override
  String get clientStatusWaitingTitle => 'Esperando Gateway...';

  @override
  String get clientStatusWaitingSubtitle =>
      'El servicio de cliente está activo pero desconectado.';

  @override
  String get clientStatusCardTitle => 'Estado del Servicio  del Cliente';

  @override
  String get clientStatusVerifying => 'Verificando...';

  @override
  String get clientStatusError => 'Error al obtener estado';

  @override
  String get clientStatusInfo => 'Información del Gateway';

  @override
  String get clientStatusDevice => 'Dispositivo';

  @override
  String get clientStatusIP => 'Dirección IP';

  @override
  String get clientStatusLastSync => 'Última sincronización';

  @override
  String get clientStatusBtnReSync => 'Re-vincular Dispositivo';

  @override
  String get clientStatusBtnForceSync => 'Forzar reconexión';

  @override
  String get clientStatusBtnForgot => 'Olvidar este Gateway';

  @override
  String get clientStatusEmptyTitle => 'No hay ningún Gateway vinculado.';

  @override
  String get clientStatusSync => 'Vincular Dispositivo';

  @override
  String get clientStatusForgotDialogTitle => '¿Olvidar Gateway?';

  @override
  String get clientStatusForgotDialogInfo =>
      'Se perderá la conexión y tendrás que vincularlo nuevamente para recibir SMS y llamadas.';

  @override
  String get clientStatusForgotDialogBtnCancel => 'Cancelar';

  @override
  String get clientStatusForgotDialogBtnForgot => 'Olvidar';
}
