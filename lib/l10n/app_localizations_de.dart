// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'DialcaLink';

  @override
  String get start => 'Starten';

  @override
  String get continueLbl => 'Weiter';

  @override
  String get requestPermissions => 'Berechtigungen anfordern';

  @override
  String get permissions => 'Berechtigungen';

  @override
  String get attemptAgain => 'Erneut versuchen';

  @override
  String get name => 'Name';

  @override
  String get role => 'Rolle';

  @override
  String get uniqueID => 'Eindeutige ID';

  @override
  String get unknownError => 'Unbekannter Fehler';

  @override
  String get searchUpdates => 'Nach Updates suchen';

  @override
  String get searching => 'Suche läuft...';

  @override
  String get startService => 'Dienst starten';

  @override
  String get stopService => 'Dienst stoppen';

  @override
  String get appTheme => 'Erscheinungsbild der App';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get clientUp => 'Client';

  @override
  String get clientLow => 'Client';

  @override
  String get gatewayUp => 'Gateway';

  @override
  String get gatewayLow => 'Gateway';

  @override
  String get onboardingWelcomeBadge => 'Willkommen';

  @override
  String get onboardingWelcomeTitle => 'SMS und Anrufe an einem Ort empfangen';

  @override
  String get onboardingWelcomeSubtitle =>
      'Verbinde zwei Android-Geräte, um deine gesamte Telefonaktivität zentral zu verwalten.';

  @override
  String get onboardingWelcomeHowWorksTitle => 'Wie funktioniert es?';

  @override
  String get onboardingWelcomeHowWorksText =>
      'Das Gerät mit der SIM-Karte teilt SMS und Anrufe über dein lokales WLAN. Dein Hauptgerät empfängt sie in Echtzeit.';

  @override
  String get onboardingWelcomeInfo =>
      'Deine Informationen bleiben innerhalb deines lokalen\nNetzwerks. Wir verwenden keine externen Server.';

  @override
  String get onboardingRoleTitle => 'Willkommen bei DialcaLink';

  @override
  String get onboardingRoleSubtitle1 =>
      'Wähle aus, wie du dieses Gerät verwenden möchtest.';

  @override
  String get onboardingRoleSubtitle2 =>
      'Du kannst diese Einstellung später ändern.';

  @override
  String get onboardingRoleClientCardTitle => 'Hauptgerät';

  @override
  String get onboardingRoleClientCardInfo =>
      'Empfange SMS und Anrufbenachrichtigungen von einem anderen Telefon.';

  @override
  String get onboardingRoleGatewayCardTitle => 'Gerät mit SIM-Karte';

  @override
  String get onboardingRoleGatewayRCardInfo =>
      'Teile SMS und Anrufe mit deinem Hauptgerät';

  @override
  String get onboardingPermissionsTitle => 'Erforderliche Berechtigungen';

  @override
  String get onboardingPermissionsSubtitle =>
      'Um fortzufahren, erteile die Berechtigungen, die für die ordnungsgemäße Funktion der App erforderlich sind.';

  @override
  String get onboardingPermissionsManualGrant =>
      'Gehe zu den Einstellungen, um die Berechtigung manuell zu erteilen';

  @override
  String get permissionSMSTitle => 'SMS-Nachrichten';

  @override
  String get permissionSMSDescription =>
      'Erforderlich, um eingehende SMS auf dem Gateway zu erkennen.';

  @override
  String get permissionPhoneTitle => 'Telefonstatus';

  @override
  String get permissionPhoneDescription =>
      'Erforderlich, um eingehende Anrufe auf dem Gateway zu erkennen.';

  @override
  String get permissionContactsTitle => 'Kontakte';

  @override
  String get permissionContactsDescription =>
      'Zeigt bei SMS und Anrufen Namen statt Telefonnummern an.';

  @override
  String get permissionLocationTitle => 'Standort (WLAN-Netzwerk)';

  @override
  String get permissionLocationDescription =>
      'Android benötigt diese Berechtigung, um die IP-Adresse des aktiven WLAN-Netzwerks zu erkennen.';

  @override
  String get permissionCameraTitle => 'Kamera';

  @override
  String get permissionCameraDescription =>
      'Erforderlich, um den QR-Code zur Kopplung zu scannen.';

  @override
  String get permissionNotificationsTitle => 'Benachrichtigungen';

  @override
  String get permissionNotificationsDescription =>
      'Ermöglicht Benachrichtigungen über eingehende SMS und Anrufe.';

  @override
  String get permissionPhoneHistoryTitle => 'Anrufliste';

  @override
  String get permissionPhoneHistoryDescription =>
      'Erforderlich, um eingehende Anrufe auf dem Gateway zu erkennen.';

  @override
  String get onboardingPairingTitle => 'Gerät koppeln';

  @override
  String get pairingStatusSearchingTitle => 'QR-Code wird gesucht';

  @override
  String get pairingStatusSearchingSubtitle =>
      'Richte die Kamera auf den QR-Code, um die Kopplung zu starten.';

  @override
  String get pairingStatusVerifyingTitle => 'Wird überprüft...';

  @override
  String get pairingStatusVerifyingSubtitle =>
      'Verbindung zum Gerät wird überprüft.';

  @override
  String get pairingStatusInvalidQRTitle => 'Ungültiger QR-Code';

  @override
  String get pairingStatusInvalidQRSubtitle =>
      'Dieser QR-Code gehört nicht zu einem gültigen DialcaLink-Gerät.';

  @override
  String get pairingStatusFailedTitle => 'Kopplung fehlgeschlagen';

  @override
  String get pairingStatusFailedSubtitle =>
      'Bei der Kopplung ist ein Fehler aufgetreten.';

  @override
  String get pairingSuccessTitle => 'Kopplung erfolgreich!';

  @override
  String get pairingSuccessSubtitle =>
      'Dein Gerät ist jetzt mit dem Gateway synchronisiert. Weiterleitung...';

  @override
  String get onboardingPairingPINSheetTitle => 'Mit Code koppeln';

  @override
  String get onboardingPairingPINSheetReattempt => 'Erneut suchen';

  @override
  String get onboardingPairingPINSheetSearching =>
      'Gateway wird im Netzwerk gesucht...';

  @override
  String get onboardingPairingPINSheetLabelGatewayDetected =>
      'Gateway-IP-Adresse';

  @override
  String get onboardingPairingPINSheetLabelGatewayHint =>
      '192.168.43.1 oder 192.168.1.X';

  @override
  String get onboardingPairingPINSheetLabelPIN => '6-stellige PIN';

  @override
  String get onboardingPairingPINSheetBtnPair => 'Gerät koppeln';

  @override
  String get onboardingPairingPINSheetErrorMessage =>
      'Gib die IP-Adresse und die 6-stellige PIN ein.';

  @override
  String get onboardingGatewaySetupAppbarTitle => 'Gateway einrichten';

  @override
  String get onboardingGatewaySetupTitle =>
      'Dieses Gerät als Gateway einrichten';

  @override
  String get onboardingGatewaySetupSubtitle =>
      'Konfiguriere dein Gerät als zentrale Kommunikationsstelle.';

  @override
  String get onboardingGatewaySetupGrantPermissionsError =>
      'Bitte erteile alle erforderlichen Berechtigungen.';

  @override
  String get onboardingGatewaySetupError =>
      'Fehler beim Starten des Gateway-Dienstes:';

  @override
  String get onboardingGatewayInactive =>
      'Der laufende Gateway-Dienst konnte nicht bestätigt werden.';

  @override
  String get onboardingGatewayStarting => 'Gateway-Dienst wird gestartet...';

  @override
  String get onboardingGatewayConfirming =>
      'Es wird überprüft, ob der Dienst aktiv ist...';

  @override
  String get onboardingGatewayErrorIdentity =>
      'Fehler beim Laden der Geräteidentität:';

  @override
  String get onboardingGatewayErrorNoIdentity =>
      'Geräteidentität nicht gefunden.';

  @override
  String get onboardingGatewayErrorPermissionsError =>
      'Fehler beim Überprüfen der Berechtigungen:';

  @override
  String get onboardingGatewaySetupPermissionsGranted =>
      'Berechtigungen erteilt';

  @override
  String get onboardingGatewaySetupPermissionsGrantedSubtitle =>
      'Berechtigungen für SMS, Anrufe und Netzwerkstatus erteilt.';

  @override
  String get onboardingGatewaySetupPermissionsNotGrantedSubtitle =>
      'Einige für diese Rolle erforderliche Berechtigungen fehlen noch.';

  @override
  String get onboardingGatewaySetupDeviceConfigured => 'Gerät konfiguriert';

  @override
  String get onboardingGatewaySetupDeviceConfiguredSubtitle =>
      'Grundeinstellungen sind bereit.';

  @override
  String get onboardingGatewaySetupHotspot => 'WLAN-Hotspot';

  @override
  String get onboardingGatewaySetupHotspotVerifying =>
      'Hotspot wird überprüft...';

  @override
  String get onboardingGatewaySetupHotspotResolved =>
      'Zugangspunkt aktiv unter:';

  @override
  String get onboardingGatewaySetupHotspotNotConnected =>
      'Der Hotspot ist deaktiviert. Bitte aktiviere ihn.';

  @override
  String get onboardingGatewaySetupHotspotNotPermission =>
      'Zum Erkennen des Netzwerks sind Standortberechtigungen erforderlich.';

  @override
  String get onboardingGatewaySetupHotspotNot =>
      'Der Hotspot konnte nicht erkannt werden.';

  @override
  String get onboardingGatewaySetupBtnActivate => 'Gateway aktivieren';

  @override
  String get gatewayHomeAppbarTitle => 'DialcaLink Gateway';

  @override
  String get gatewayStatusTitleDisconnected => 'Dienst gestoppt';

  @override
  String get gatewayStatusSubtitleDisconnected =>
      'Das Gateway verarbeitet keine Daten.';

  @override
  String get gatewayStatusTitleConnected => 'Gateway verbunden';

  @override
  String get gatewayStatusSubtitleConnected => 'Synchronisierung mit';

  @override
  String get gatewayStatusTitleConnecting => 'Warte auf Client...';

  @override
  String get gatewayStatusSubtitleConnecting =>
      'Das Gateway ist aktiv, aber es sind keine Clients verbunden.';

  @override
  String get gatewayShowQRSubtitle =>
      'Zeige den QR-Code auf dem anderen Gerät an, um es mit diesem Gerät zu koppeln.';

  @override
  String get gatewayStatMessagesTitle => 'Nachrichten';

  @override
  String get gatewayStatCallsTitle => 'Anrufe';

  @override
  String get gatewayStatTodayLow => 'heute';

  @override
  String get gatewayDeviceInfo => 'Geräteinformationen';

  @override
  String get gatewayDeviceInfoName => 'Gerätename';

  @override
  String get gatewayDeviceInfoIP => 'Geräte-IP-Adresse';

  @override
  String get gatewayDeviceInfoNotIP => 'Nicht verfügbar';

  @override
  String get gatewayDeviceInfoStartedFrom => 'Aktiv seit';

  @override
  String get gatewayDeviceInfoActivityTime => 'Betriebszeit';

  @override
  String get gatewayDeviceInfoNotStarted => 'Nicht gestartet';

  @override
  String get gatewayPairTitle => 'Fast bereit zum Verbinden';

  @override
  String get gatewayPairSubtitle =>
      'Öffne DialcaLink auf deinem Hauptgerät und scanne den QR-Code.';

  @override
  String get gatewayPairReadyToScan => 'Bereit zum Scannen';

  @override
  String get gatewayPairPINHint =>
      'Oder kopple das Gerät, indem du diesen Code im Client eingibst:';

  @override
  String get gatewayBtnDone => 'Fertig';

  @override
  String get gatewayBtnGenerateCode => 'Neuen Code generieren';

  @override
  String get clientSmsListEmptyTitle => 'Keine SMS verfügbar';

  @override
  String get clientSmsListEmptySubtitle =>
      'Empfangene SMS werden hier angezeigt.';

  @override
  String get clientSmsChatErrorSending =>
      'Nachricht konnte nicht gesendet werden';

  @override
  String get clientSmsChatErrorLoadingMessages =>
      'Fehler beim Laden der Nachrichten:';

  @override
  String get clientNewSmsErrorSend =>
      'Bitte gib die Telefonnummer und den Nachrichteninhalt ein';

  @override
  String get clientNewSmsAppbarTitle => 'Neue SMS';

  @override
  String get clientNewSmsLoadingContacts => 'Kontakte werden geladen...';

  @override
  String get clientNewSmsSuggestions => 'Vorschläge';

  @override
  String get clientNewSmsLabelTextarea => 'Nachricht eingeben...';

  @override
  String get clientNewSmsBtnSend => 'SMS senden';

  @override
  String get clientCallsListEmptyTitle => 'Keine Anrufe verfügbar';

  @override
  String get clientCallsListEmptySubtitle =>
      'Eingehende Anrufe werden hier angezeigt.';

  @override
  String get clientCallsItemCourse => 'Läuft';

  @override
  String get clientStatusAppbarTitle => 'Status';

  @override
  String get clientStatusDisconnectedTitle => 'Dienst getrennt';

  @override
  String get clientStatusDisconnectedSubtitle =>
      'Der Client-Dienst ist nicht aktiv.';

  @override
  String get clientStatusConnectedTitle => 'Dienst aktiv';

  @override
  String get clientStatusConnectedSubtitle =>
      'Synchronisierung mit dem Gateway.';

  @override
  String get clientStatusConnectingTitle => 'Verbindung wird hergestellt...';

  @override
  String get clientStatusConnectingSubtitle =>
      'Der Dienst sucht nach dem Gateway.';

  @override
  String get clientStatusWaitingTitle => 'Warte auf Gateway...';

  @override
  String get clientStatusWaitingSubtitle =>
      'Der Client-Dienst ist aktiv, aber nicht verbunden.';

  @override
  String get clientStatusCardTitle => 'Status des Client-Dienstes';

  @override
  String get clientStatusVerifying => 'Wird überprüft...';

  @override
  String get clientStatusError => 'Fehler beim Abrufen des Status';

  @override
  String get clientStatusInfo => 'Gateway-Informationen';

  @override
  String get clientStatusDevice => 'Gerät';

  @override
  String get clientStatusIP => 'IP-Adresse';

  @override
  String get clientStatusLastSync => 'Letzte Synchronisierung';

  @override
  String get clientStatusBtnReSync => 'Gerät erneut koppeln';

  @override
  String get clientStatusBtnForceSync => 'Verbindung erneut herstellen';

  @override
  String get clientStatusBtnForgot => 'Dieses Gateway vergessen';

  @override
  String get clientStatusEmptyTitle => 'Kein Gateway gekoppelt.';

  @override
  String get clientStatusSync => 'Gerät koppeln';

  @override
  String get clientStatusForgotDialogTitle => 'Gateway vergessen?';

  @override
  String get clientStatusForgotDialogInfo =>
      'Die Verbindung geht verloren. Du musst das Gerät erneut koppeln, um SMS und Anrufe zu empfangen.';

  @override
  String get clientStatusForgotDialogBtnCancel => 'Abbrechen';

  @override
  String get clientStatusForgotDialogBtnForgot => 'Vergessen';
}
