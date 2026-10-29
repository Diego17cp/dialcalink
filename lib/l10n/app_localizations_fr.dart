// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'DialcaLink';

  @override
  String get start => 'Commencer';

  @override
  String get continueLbl => 'Continuer';

  @override
  String get requestPermissions => 'Demander les autorisations';

  @override
  String get permissions => 'Autorisations';

  @override
  String get attemptAgain => 'Réessayer';

  @override
  String get name => 'Nom';

  @override
  String get role => 'Rôle';

  @override
  String get uniqueID => 'ID unique';

  @override
  String get unknownError => 'Erreur inconnue';

  @override
  String get searchUpdates => 'Rechercher des mises à jour';

  @override
  String get searching => 'Recherche en cours...';

  @override
  String get startService => 'Démarrer le service';

  @override
  String get stopService => 'Arrêter le service';

  @override
  String get appTheme => 'Apparence de l’application';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get clientUp => 'Client';

  @override
  String get clientLow => 'client';

  @override
  String get gatewayUp => 'Gateway';

  @override
  String get gatewayLow => 'gateway';

  @override
  String get onboardingWelcomeBadge => 'Bienvenue';

  @override
  String get onboardingWelcomeTitle =>
      'Recevez vos SMS et appels au même endroit';

  @override
  String get onboardingWelcomeSubtitle =>
      'Connectez deux appareils Android pour centraliser toute votre activité téléphonique.';

  @override
  String get onboardingWelcomeHowWorksTitle => 'Comment ça marche ?';

  @override
  String get onboardingWelcomeHowWorksText =>
      'L’appareil équipé d’une carte SIM partage les SMS et les appels via votre réseau Wi-Fi local. Votre appareil principal les reçoit en temps réel.';

  @override
  String get onboardingWelcomeInfo =>
      'Vos informations restent sur votre réseau local. Nous n’utilisons aucun serveur externe.';

  @override
  String get onboardingRoleTitle => 'Bienvenue sur DialcaLink';

  @override
  String get onboardingRoleSubtitle1 =>
      'Choisissez comment vous utiliserez cet appareil.';

  @override
  String get onboardingRoleSubtitle2 =>
      'Vous pourrez modifier ce paramètre plus tard.';

  @override
  String get onboardingRoleClientCardTitle => 'Appareil principal';

  @override
  String get onboardingRoleClientCardInfo =>
      'Recevez les SMS et les notifications d’appel d’un autre téléphone.';

  @override
  String get onboardingRoleGatewayCardTitle => 'Appareil avec carte SIM';

  @override
  String get onboardingRoleGatewayRCardInfo =>
      'Partagez les SMS et les appels avec votre appareil principal';

  @override
  String get onboardingPermissionsTitle => 'Autorisations nécessaires';

  @override
  String get onboardingPermissionsSubtitle =>
      'Pour continuer, veuillez accorder les autorisations nécessaires au bon fonctionnement de l’application.';

  @override
  String get permissionSMSTitle => 'Messages SMS';

  @override
  String get permissionSMSDescription =>
      'Nécessaire pour détecter les SMS entrants sur le Gateway.';

  @override
  String get permissionPhoneTitle => 'État du téléphone';

  @override
  String get permissionPhoneDescription =>
      'Nécessaire pour détecter les appels entrants sur le Gateway.';

  @override
  String get permissionContactsTitle => 'Contacts';

  @override
  String get permissionContactsDescription =>
      'Permet d’afficher les noms plutôt que les numéros pour les SMS et les appels.';

  @override
  String get permissionLocationTitle => 'Localisation (réseau Wi-Fi)';

  @override
  String get permissionLocationDescription =>
      'Android exige cette autorisation pour détecter l’adresse IP du réseau Wi-Fi actif.';

  @override
  String get permissionCameraTitle => 'Appareil photo';

  @override
  String get permissionCameraDescription =>
      'Nécessaire pour scanner le code QR d’association.';

  @override
  String get permissionNotificationsTitle => 'Notifications';

  @override
  String get permissionNotificationsDescription =>
      'Permet de recevoir des alertes pour les SMS et appels entrants.';

  @override
  String get permissionPhoneHistoryTitle => 'Historique des appels';

  @override
  String get permissionPhoneHistoryDescription =>
      'Nécessaire pour détecter les appels entrants sur le Gateway.';

  @override
  String get onboardingPairingTitle => 'Associer l’appareil';

  @override
  String get pairingStatusSearchingTitle => 'Recherche du code QR';

  @override
  String get pairingStatusSearchingSubtitle =>
      'Pointez l’appareil photo vers le code QR pour commencer l’association.';

  @override
  String get pairingStatusVerifyingTitle => 'Vérification...';

  @override
  String get pairingStatusVerifyingSubtitle =>
      'Vérification de la connexion avec l’appareil.';

  @override
  String get pairingStatusInvalidQRTitle => 'Code QR invalide';

  @override
  String get pairingStatusInvalidQRSubtitle =>
      'Ce code QR ne provient pas d’un appareil DialcaLink valide.';

  @override
  String get pairingStatusFailedTitle => 'Échec de l’association';

  @override
  String get pairingStatusFailedSubtitle =>
      'Une erreur s’est produite pendant l’association.';

  @override
  String get pairingSuccessTitle => 'Association réussie !';

  @override
  String get pairingSuccessSubtitle =>
      'Votre appareil est maintenant synchronisé avec le Gateway. Redirection...';

  @override
  String get onboardingPairingPINSheetTitle => 'Associer avec un code';

  @override
  String get onboardingPairingPINSheetReattempt => 'Relancer la recherche';

  @override
  String get onboardingPairingPINSheetSearching =>
      'Recherche d’un Gateway sur le réseau...';

  @override
  String get onboardingPairingPINSheetLabelGatewayDetected =>
      'Adresse IP du Gateway';

  @override
  String get onboardingPairingPINSheetLabelGatewayHint =>
      '192.168.43.1 ou 192.168.1.X';

  @override
  String get onboardingPairingPINSheetLabelPIN => 'Code PIN à 6 chiffres';

  @override
  String get onboardingPairingPINSheetBtnPair => 'Associer l’appareil';

  @override
  String get onboardingPairingPINSheetErrorMessage =>
      'Saisissez l’adresse IP et le code PIN à 6 chiffres.';

  @override
  String get onboardingGatewaySetupAppbarTitle => 'Configurer le Gateway';

  @override
  String get onboardingGatewaySetupTitle =>
      'Configurer cet appareil comme Gateway';

  @override
  String get onboardingGatewaySetupSubtitle =>
      'Configurez votre appareil pour qu’il serve de point central de communication.';

  @override
  String get onboardingGatewaySetupGrantPermissionsError =>
      'Veuillez accorder toutes les autorisations requises.';

  @override
  String get onboardingGatewaySetupError =>
      'Erreur lors du démarrage du service Gateway :';

  @override
  String get onboardingGatewayInactive =>
      'Impossible de confirmer que le service Gateway est en cours d’exécution.';

  @override
  String get onboardingGatewayStarting => 'Démarrage du service Gateway...';

  @override
  String get onboardingGatewayConfirming =>
      'Vérification de l’activité du service...';

  @override
  String get onboardingGatewayErrorIdentity =>
      'Erreur lors du chargement de l’identité :';

  @override
  String get onboardingGatewayErrorNoIdentity =>
      'Identité de l’appareil introuvable.';

  @override
  String get onboardingGatewayErrorPermissionsError =>
      'Erreur lors de la vérification des autorisations :';

  @override
  String get onboardingGatewaySetupPermissionsGranted =>
      'Autorisations accordées';

  @override
  String get onboardingGatewaySetupPermissionsGrantedSubtitle =>
      'Autorisations SMS, appels et état du réseau accordées.';

  @override
  String get onboardingGatewaySetupPermissionsNotGrantedSubtitle =>
      'Certaines autorisations requises pour ce rôle manquent encore.';

  @override
  String get onboardingGatewaySetupDeviceConfigured => 'Appareil configuré';

  @override
  String get onboardingGatewaySetupDeviceConfiguredSubtitle =>
      'Les paramètres de base sont prêts.';

  @override
  String get onboardingGatewaySetupHotspot => 'Point d’accès Wi-Fi';

  @override
  String get onboardingGatewaySetupHotspotVerifying =>
      'Vérification du point d’accès...';

  @override
  String get onboardingGatewaySetupHotspotResolved => 'Point d’accès actif à :';

  @override
  String get onboardingGatewaySetupHotspotNotConnected =>
      'Le point d’accès est désactivé. Veuillez l’activer.';

  @override
  String get onboardingGatewaySetupHotspotNotPermission =>
      'Les autorisations de localisation sont nécessaires pour détecter le réseau.';

  @override
  String get onboardingGatewaySetupHotspotNot =>
      'Impossible de détecter le point d’accès.';

  @override
  String get onboardingGatewaySetupBtnActivate => 'Activer le Gateway';

  @override
  String get gatewayHomeAppbarTitle => 'DialcaLink Gateway';

  @override
  String get gatewayStatusTitleDisconnected => 'Service arrêté';

  @override
  String get gatewayStatusSubtitleDisconnected =>
      'Le Gateway ne traite aucune donnée.';

  @override
  String get gatewayStatusTitleConnected => 'Gateway connecté';

  @override
  String get gatewayStatusSubtitleConnected => 'Synchronisation avec';

  @override
  String get gatewayStatusTitleConnecting => 'En attente du client...';

  @override
  String get gatewayStatusSubtitleConnecting =>
      'Le Gateway est actif, mais aucun client n’est connecté.';

  @override
  String get gatewayShowQRSubtitle =>
      'Affichez le code QR sur l’autre appareil pour l’associer à celui-ci.';

  @override
  String get gatewayStatMessagesTitle => 'Messages';

  @override
  String get gatewayStatCallsTitle => 'Appels';

  @override
  String get gatewayStatTodayLow => 'aujourd’hui';

  @override
  String get gatewayDeviceInfo => 'Informations sur l’appareil';

  @override
  String get gatewayDeviceInfoName => 'Nom de l’appareil';

  @override
  String get gatewayDeviceInfoIP => 'Adresse IP de l’appareil';

  @override
  String get gatewayDeviceInfoNotIP => 'Indisponible';

  @override
  String get gatewayDeviceInfoStartedFrom => 'Actif depuis';

  @override
  String get gatewayDeviceInfoActivityTime => 'Durée de fonctionnement';

  @override
  String get gatewayDeviceInfoNotStarted => 'Non démarré';

  @override
  String get gatewayPairTitle => 'Prêt à se connecter bientôt';

  @override
  String get gatewayPairSubtitle =>
      'Ouvrez DialcaLink sur votre appareil principal et scannez le code QR.';

  @override
  String get gatewayPairReadyToScan => 'Prêt à scanner';

  @override
  String get gatewayPairPINHint =>
      'Ou associez l’appareil en saisissant ce code dans le client :';

  @override
  String get gatewayBtnDone => 'Terminé';

  @override
  String get gatewayBtnGenerateCode => 'Générer un nouveau code';

  @override
  String get clientSmsListEmptyTitle => 'Aucun SMS disponible';

  @override
  String get clientSmsListEmptySubtitle => 'Les SMS reçus apparaîtront ici.';

  @override
  String get clientSmsChatErrorSending => 'Impossible d’envoyer le message';

  @override
  String get clientSmsChatErrorLoadingMessages =>
      'Erreur lors du chargement des messages :';

  @override
  String get clientNewSmsErrorSend =>
      'Veuillez saisir le numéro de téléphone et le contenu du message';

  @override
  String get clientNewSmsAppbarTitle => 'Nouveau SMS';

  @override
  String get clientNewSmsLoadingContacts => 'Chargement des contacts...';

  @override
  String get clientNewSmsSuggestions => 'Suggestions';

  @override
  String get clientNewSmsLabelTextarea => 'Écrivez votre message...';

  @override
  String get clientNewSmsBtnSend => 'Envoyer un SMS';

  @override
  String get clientCallsListEmptyTitle => 'Aucun appel disponible';

  @override
  String get clientCallsListEmptySubtitle =>
      'Les appels reçus apparaîtront ici.';

  @override
  String get clientCallsItemCourse => 'En cours';

  @override
  String get clientStatusAppbarTitle => 'État';

  @override
  String get clientStatusDisconnectedTitle => 'Service déconnecté';

  @override
  String get clientStatusDisconnectedSubtitle =>
      'Le service client n’est pas actif.';

  @override
  String get clientStatusConnectedTitle => 'Service actif';

  @override
  String get clientStatusConnectedSubtitle =>
      'Synchronisation avec le Gateway.';

  @override
  String get clientStatusConnectingTitle => 'Connexion en cours...';

  @override
  String get clientStatusConnectingSubtitle =>
      'Le service recherche le Gateway.';

  @override
  String get clientStatusWaitingTitle => 'En attente du Gateway...';

  @override
  String get clientStatusWaitingSubtitle =>
      'Le service client est actif, mais déconnecté.';

  @override
  String get clientStatusCardTitle => 'État du service client';

  @override
  String get clientStatusVerifying => 'Vérification...';

  @override
  String get clientStatusError => 'Erreur lors de la récupération de l’état';

  @override
  String get clientStatusInfo => 'Informations sur le Gateway';

  @override
  String get clientStatusDevice => 'Appareil';

  @override
  String get clientStatusIP => 'Adresse IP';

  @override
  String get clientStatusLastSync => 'Dernière synchronisation';

  @override
  String get clientStatusBtnReSync => 'Associer à nouveau l’appareil';

  @override
  String get clientStatusBtnForceSync => 'Forcer la reconnexion';

  @override
  String get clientStatusBtnForgot => 'Oublier ce Gateway';

  @override
  String get clientStatusEmptyTitle => 'Aucun Gateway associé.';

  @override
  String get clientStatusSync => 'Associer l’appareil';

  @override
  String get clientStatusForgotDialogTitle => 'Oublier le Gateway ?';

  @override
  String get clientStatusForgotDialogInfo =>
      'La connexion sera perdue et vous devrez associer à nouveau l’appareil pour recevoir des SMS et des appels.';

  @override
  String get clientStatusForgotDialogBtnCancel => 'Annuler';

  @override
  String get clientStatusForgotDialogBtnForgot => 'Oublier';
}
