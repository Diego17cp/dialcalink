// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DialcaLink';

  @override
  String get start => 'Get started';

  @override
  String get continueLbl => 'Continue';

  @override
  String get requestPermissions => 'Request permissions';

  @override
  String get permissions => 'Permissions';

  @override
  String get attemptAgain => 'Try again';

  @override
  String get name => 'Name';

  @override
  String get role => 'Role';

  @override
  String get uniqueID => 'Unique ID';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get searchUpdates => 'Check for updates';

  @override
  String get searching => 'Searching...';

  @override
  String get startService => 'Start service';

  @override
  String get stopService => 'Stop service';

  @override
  String get appTheme => 'App appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get clientUp => 'Client';

  @override
  String get clientLow => 'client';

  @override
  String get gatewayUp => 'Gateway';

  @override
  String get gatewayLow => 'gateway';

  @override
  String get onboardingWelcomeBadge => 'Welcome';

  @override
  String get onboardingWelcomeTitle =>
      'Get your SMS messages and calls in one place';

  @override
  String get onboardingWelcomeSubtitle =>
      'Connect two Android devices to centralize all your phone activity.';

  @override
  String get onboardingWelcomeHowWorksTitle => 'How does it work?';

  @override
  String get onboardingWelcomeHowWorksText =>
      'The device with the SIM card shares SMS messages and calls over your local Wi-Fi network. Your primary device receives them in real time.';

  @override
  String get onboardingWelcomeInfo =>
      'Your information stays within your local\nnetwork. We do not use external servers.';

  @override
  String get onboardingRoleTitle => 'Welcome to DialcaLink';

  @override
  String get onboardingRoleSubtitle1 => 'Choose how you\'ll use this device.';

  @override
  String get onboardingRoleSubtitle2 => 'You can change this setting later.';

  @override
  String get onboardingRoleClientCardTitle => 'Primary device';

  @override
  String get onboardingRoleClientCardInfo =>
      'Receive SMS messages and call notifications from another phone.';

  @override
  String get onboardingRoleGatewayCardTitle => 'Device with SIM card';

  @override
  String get onboardingRoleGatewayRCardInfo =>
      'Share SMS messages and calls with your primary device';

  @override
  String get onboardingPermissionsTitle => 'Required permissions';

  @override
  String get onboardingPermissionsSubtitle =>
      'To continue, please grant the permissions required for the app to work properly.';

  @override
  String get onboardingPermissionsManualGrant =>
      'Go to Settings to grant permission manually';

  @override
  String get permissionSMSTitle => 'SMS messages';

  @override
  String get permissionSMSDescription =>
      'Required to detect incoming SMS messages on the Gateway.';

  @override
  String get permissionPhoneTitle => 'Phone status';

  @override
  String get permissionPhoneDescription =>
      'Required to detect incoming calls on the Gateway.';

  @override
  String get permissionContactsTitle => 'Contacts';

  @override
  String get permissionContactsDescription =>
      'Displays contact names instead of phone numbers in SMS messages and calls.';

  @override
  String get permissionLocationTitle => 'Location (Wi-Fi network)';

  @override
  String get permissionLocationDescription =>
      'Android requires this permission to detect the active Wi-Fi network\'s IP address.';

  @override
  String get permissionCameraTitle => 'Camera';

  @override
  String get permissionCameraDescription =>
      'Required to scan the pairing QR code.';

  @override
  String get permissionNotificationsTitle => 'Notifications';

  @override
  String get permissionNotificationsDescription =>
      'Allows alerts for incoming SMS messages and calls.';

  @override
  String get permissionPhoneHistoryTitle => 'Call history';

  @override
  String get permissionPhoneHistoryDescription =>
      'Required to detect incoming calls on the Gateway.';

  @override
  String get onboardingPairingTitle => 'Pair device';

  @override
  String get pairingStatusSearchingTitle => 'Looking for QR code';

  @override
  String get pairingStatusSearchingSubtitle =>
      'Point the camera at the QR code to start pairing.';

  @override
  String get pairingStatusVerifyingTitle => 'Verifying...';

  @override
  String get pairingStatusVerifyingSubtitle =>
      'Checking the connection to the device.';

  @override
  String get pairingStatusInvalidQRTitle => 'Invalid QR code';

  @override
  String get pairingStatusInvalidQRSubtitle =>
      'This QR code is not from a valid DialcaLink device.';

  @override
  String get pairingStatusFailedTitle => 'Pairing failed';

  @override
  String get pairingStatusFailedSubtitle => 'An error occurred while pairing.';

  @override
  String get pairingSuccessTitle => 'Pairing successful!';

  @override
  String get pairingSuccessSubtitle =>
      'Your device is now synced with the Gateway. Redirecting...';

  @override
  String get onboardingPairingPINSheetTitle => 'Pair with a code';

  @override
  String get onboardingPairingPINSheetReattempt => 'Search again';

  @override
  String get onboardingPairingPINSheetSearching =>
      'Searching for a Gateway on the network...';

  @override
  String get onboardingPairingPINSheetLabelGatewayDetected =>
      'Gateway detected';

  @override
  String get onboardingPairingPINSheetLabelGatewayIP => 'Gateway IP address';

  @override
  String get onboardingPairingPINSheetLabelGatewayHint =>
      '192.168.43.1 or 192.168.1.X';

  @override
  String get onboardingPairingPINSheetLabelPIN => '6-digit PIN';

  @override
  String get onboardingPairingPINSheetBtnPair => 'Pair device';

  @override
  String get onboardingPairingPINSheetErrorMessage =>
      'Enter the IP address and 6-digit PIN.';

  @override
  String get onboardingGatewaySetupAppbarTitle => 'Set up Gateway';

  @override
  String get onboardingGatewaySetupTitle => 'Set up this device as a Gateway';

  @override
  String get onboardingGatewaySetupSubtitle =>
      'Configure your device to act as a communication hub.';

  @override
  String get onboardingGatewaySetupGrantPermissionsError =>
      'Please grant all required permissions.';

  @override
  String get onboardingGatewaySetupError =>
      'Error starting the Gateway service:';

  @override
  String get onboardingGatewayInactive =>
      'Could not confirm that the Gateway service is running.';

  @override
  String get onboardingGatewayStarting => 'Starting Gateway service...';

  @override
  String get onboardingGatewayConfirming =>
      'Checking that the service is running...';

  @override
  String get onboardingGatewayErrorIdentity => 'Error loading identity:';

  @override
  String get onboardingGatewayErrorNoIdentity => 'Device identity not found.';

  @override
  String get onboardingGatewayErrorPermissionsError =>
      'Error checking permissions:';

  @override
  String get onboardingGatewaySetupPermissionsGranted => 'Permissions granted';

  @override
  String get onboardingGatewaySetupPermissionsGrantedSubtitle =>
      'SMS, calls, and network status permissions granted.';

  @override
  String get onboardingGatewaySetupPermissionsNotGrantedSubtitle =>
      'Some permissions required for this role are still missing.';

  @override
  String get onboardingGatewaySetupDeviceConfigured => 'Device configured';

  @override
  String get onboardingGatewaySetupDeviceConfiguredSubtitle =>
      'Basic settings are ready.';

  @override
  String get onboardingGatewaySetupHotspot => 'Hotspot';

  @override
  String get onboardingGatewaySetupHotspotVerifying => 'Checking hotspot...';

  @override
  String get onboardingGatewaySetupHotspotResolved => 'Access point active at:';

  @override
  String get onboardingGatewaySetupHotspotNotConnected =>
      'Hotspot is off. Please turn it on.';

  @override
  String get onboardingGatewaySetupHotspotNotPermission =>
      'Location permissions are required to detect the network.';

  @override
  String get onboardingGatewaySetupHotspotNot =>
      'Could not detect the hotspot.';

  @override
  String get onboardingGatewaySetupBtnActivate => 'Activate Gateway';

  @override
  String get gatewayHomeAppbarTitle => 'DialcaLink Gateway';

  @override
  String get gatewayStatusTitleDisconnected => 'Service stopped';

  @override
  String get gatewayStatusSubtitleDisconnected =>
      'The Gateway is not processing data.';

  @override
  String get gatewayStatusTitleConnected => 'Gateway connected';

  @override
  String get gatewayStatusSubtitleConnected => 'Syncing with';

  @override
  String get gatewayStatusTitleConnecting => 'Waiting for client...';

  @override
  String get gatewayStatusSubtitleConnecting =>
      'The Gateway is active, but no clients are connected.';

  @override
  String get gatewayShowQRSubtitle =>
      'Show the QR code on the other device to pair it with this one.';

  @override
  String get gatewayStatMessagesTitle => 'Messages';

  @override
  String get gatewayStatCallsTitle => 'Calls';

  @override
  String get gatewayStatTodayLow => 'today';

  @override
  String get gatewayDeviceInfo => 'Device information';

  @override
  String get gatewayDeviceInfoName => 'Device name';

  @override
  String get gatewayDeviceInfoIP => 'Device IP address';

  @override
  String get gatewayDeviceInfoNotIP => 'Unavailable';

  @override
  String get gatewayDeviceInfoStartedFrom => 'Active since';

  @override
  String get gatewayDeviceInfoActivityTime => 'Uptime';

  @override
  String get gatewayDeviceInfoNotStarted => 'Not started';

  @override
  String get gatewayPairTitle => 'Almost ready to connect';

  @override
  String get gatewayPairSubtitle =>
      'Open DialcaLink on your primary device and scan the QR code.';

  @override
  String get gatewayPairReadyToScan => 'Ready to scan';

  @override
  String get gatewayPairPINHint =>
      'Or pair by entering this code on the client:';

  @override
  String get gatewayBtnDone => 'Done';

  @override
  String get gatewayBtnGenerateCode => 'Generate new code';

  @override
  String get clientSmsListEmptyTitle => 'No SMS messages available';

  @override
  String get clientSmsListEmptySubtitle => 'New SMS messages will appear here.';

  @override
  String get clientSmsChatErrorSending => 'Couldn\'t send the message';

  @override
  String get clientSmsChatErrorLoadingMessages => 'Error loading messages:';

  @override
  String get clientNewSmsErrorSend =>
      'Please enter a phone number and message content';

  @override
  String get clientNewSmsAppbarTitle => 'New SMS';

  @override
  String get clientNewSmsLoadingContacts => 'Loading contacts...';

  @override
  String get clientNewSmsSuggestions => 'Suggestions';

  @override
  String get clientNewSmsLabelTextarea => 'Type your message...';

  @override
  String get clientNewSmsBtnSend => 'Send SMS';

  @override
  String get clientCallsListEmptyTitle => 'No calls available';

  @override
  String get clientCallsListEmptySubtitle => 'Incoming calls will appear here.';

  @override
  String get clientCallsItemCourse => 'In progress';

  @override
  String get clientStatusAppbarTitle => 'Status';

  @override
  String get clientStatusDisconnectedTitle => 'Service disconnected';

  @override
  String get clientStatusDisconnectedSubtitle =>
      'The client service is not running.';

  @override
  String get clientStatusConnectedTitle => 'Service active';

  @override
  String get clientStatusConnectedSubtitle => 'Syncing with the Gateway.';

  @override
  String get clientStatusConnectingTitle => 'Connecting...';

  @override
  String get clientStatusConnectingSubtitle =>
      'The service is searching for the Gateway.';

  @override
  String get clientStatusWaitingTitle => 'Waiting for Gateway...';

  @override
  String get clientStatusWaitingSubtitle =>
      'The client service is running but disconnected.';

  @override
  String get clientStatusCardTitle => 'Client service status';

  @override
  String get clientStatusVerifying => 'Verifying...';

  @override
  String get clientStatusError => 'Error retrieving status';

  @override
  String get clientStatusInfo => 'Gateway information';

  @override
  String get clientStatusDevice => 'Device';

  @override
  String get clientStatusIP => 'IP address';

  @override
  String get clientStatusLastSync => 'Last sync';

  @override
  String get clientStatusBtnReSync => 'Pair device again';

  @override
  String get clientStatusBtnForceSync => 'Force reconnection';

  @override
  String get clientStatusBtnForgot => 'Forget this Gateway';

  @override
  String get clientStatusEmptyTitle => 'No Gateway paired.';

  @override
  String get clientStatusSync => 'Pair device';

  @override
  String get clientStatusForgotDialogTitle => 'Forget Gateway?';

  @override
  String get clientStatusForgotDialogInfo =>
      'The connection will be lost, and you\'ll need to pair again to receive SMS messages and calls.';

  @override
  String get clientStatusForgotDialogBtnCancel => 'Cancel';

  @override
  String get clientStatusForgotDialogBtnForgot => 'Forget';
}
