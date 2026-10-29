// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'DialcaLink';

  @override
  String get start => '始める';

  @override
  String get continueLbl => '続行';

  @override
  String get requestPermissions => '権限をリクエスト';

  @override
  String get permissions => '権限';

  @override
  String get attemptAgain => '再試行';

  @override
  String get name => '名前';

  @override
  String get role => '役割';

  @override
  String get uniqueID => '一意の ID';

  @override
  String get unknownError => '不明なエラー';

  @override
  String get searchUpdates => '更新を確認';

  @override
  String get searching => '検索中…';

  @override
  String get startService => 'サービスを開始';

  @override
  String get stopService => 'サービスを停止';

  @override
  String get appTheme => 'アプリの外観';

  @override
  String get themeSystem => 'システム設定に従う';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get clientUp => 'クライアント';

  @override
  String get clientLow => 'クライアント';

  @override
  String get gatewayUp => 'ゲートウェイ';

  @override
  String get gatewayLow => 'ゲートウェイ';

  @override
  String get onboardingWelcomeBadge => 'ようこそ';

  @override
  String get onboardingWelcomeTitle => 'SMS と通話を 1 か所で受信';

  @override
  String get onboardingWelcomeSubtitle =>
      '2 台の Android デバイスを接続して、電話のアクティビティを一元管理します。';

  @override
  String get onboardingWelcomeHowWorksTitle => '仕組み';

  @override
  String get onboardingWelcomeHowWorksText =>
      'SIM カードを搭載したデバイスが、ローカル Wi-Fi ネットワーク経由で SMS と通話情報を共有します。メインデバイスはリアルタイムで受信します。';

  @override
  String get onboardingWelcomeInfo =>
      'あなたの情報はローカルネットワーク内に保持されます。\n外部サーバーは使用しません。';

  @override
  String get onboardingRoleTitle => 'DialcaLink へようこそ';

  @override
  String get onboardingRoleSubtitle1 => 'このデバイスの使用方法を選択してください。';

  @override
  String get onboardingRoleSubtitle2 => 'この設定は後から変更できます。';

  @override
  String get onboardingRoleClientCardTitle => 'メインデバイス';

  @override
  String get onboardingRoleClientCardInfo => '別の電話から SMS と着信通知を受信します。';

  @override
  String get onboardingRoleGatewayCardTitle => 'SIM カード搭載デバイス';

  @override
  String get onboardingRoleGatewayRCardInfo => 'メインデバイスと SMS および通話情報を共有します';

  @override
  String get onboardingPermissionsTitle => '必要な権限';

  @override
  String get onboardingPermissionsSubtitle =>
      '続行するには、アプリを正常に動作させるために必要な権限を許可してください。';

  @override
  String get permissionSMSTitle => 'SMS メッセージ';

  @override
  String get permissionSMSDescription => 'ゲートウェイで受信 SMS を検出するために必要です。';

  @override
  String get permissionPhoneTitle => '電話の状態';

  @override
  String get permissionPhoneDescription => 'ゲートウェイで着信を検出するために必要です。';

  @override
  String get permissionContactsTitle => '連絡先';

  @override
  String get permissionContactsDescription => 'SMS や通話で電話番号の代わりに連絡先名を表示します。';

  @override
  String get permissionLocationTitle => '位置情報（Wi-Fi ネットワーク）';

  @override
  String get permissionLocationDescription =>
      'Android では、接続中の Wi-Fi ネットワークの IP アドレスを検出するためにこの権限が必要です。';

  @override
  String get permissionCameraTitle => 'カメラ';

  @override
  String get permissionCameraDescription => 'ペアリング用 QR コードのスキャンに必要です。';

  @override
  String get permissionNotificationsTitle => '通知';

  @override
  String get permissionNotificationsDescription => 'SMS と着信の通知を受信できるようにします。';

  @override
  String get permissionPhoneHistoryTitle => '通話履歴';

  @override
  String get permissionPhoneHistoryDescription => 'ゲートウェイで着信を検出するために必要です。';

  @override
  String get onboardingPairingTitle => 'デバイスをペアリング';

  @override
  String get pairingStatusSearchingTitle => 'QR コードを検索中';

  @override
  String get pairingStatusSearchingSubtitle => 'カメラを QR コードに向けてペアリングを開始してください。';

  @override
  String get pairingStatusVerifyingTitle => '確認中…';

  @override
  String get pairingStatusVerifyingSubtitle => 'デバイスとの接続を確認しています。';

  @override
  String get pairingStatusInvalidQRTitle => '無効な QR コード';

  @override
  String get pairingStatusInvalidQRSubtitle =>
      'この QR コードは有効な DialcaLink デバイスのものではありません。';

  @override
  String get pairingStatusFailedTitle => 'ペアリングに失敗しました';

  @override
  String get pairingStatusFailedSubtitle => 'ペアリング中にエラーが発生しました。';

  @override
  String get pairingSuccessTitle => 'ペアリング成功！';

  @override
  String get pairingSuccessSubtitle => 'デバイスがゲートウェイと同期されました。画面を移動しています…';

  @override
  String get onboardingPairingPINSheetTitle => 'コードでペアリング';

  @override
  String get onboardingPairingPINSheetReattempt => '再検索';

  @override
  String get onboardingPairingPINSheetSearching => 'ネットワーク上のゲートウェイを検索中…';

  @override
  String get onboardingPairingPINSheetLabelGatewayDetected => 'ゲートウェイの IP アドレス';

  @override
  String get onboardingPairingPINSheetLabelGatewayHint =>
      '192.168.43.1 または 192.168.1.X';

  @override
  String get onboardingPairingPINSheetLabelPIN => '6 桁の PIN';

  @override
  String get onboardingPairingPINSheetBtnPair => 'デバイスをペアリング';

  @override
  String get onboardingPairingPINSheetErrorMessage =>
      'IP アドレスと 6 桁の PIN を入力してください。';

  @override
  String get onboardingGatewaySetupAppbarTitle => 'ゲートウェイを設定';

  @override
  String get onboardingGatewaySetupTitle => 'このデバイスをゲートウェイとして設定';

  @override
  String get onboardingGatewaySetupSubtitle => 'デバイスを通信ハブとして動作するように設定します。';

  @override
  String get onboardingGatewaySetupGrantPermissionsError =>
      '必要な権限をすべて許可してください。';

  @override
  String get onboardingGatewaySetupError => 'ゲートウェイサービスの起動中にエラーが発生しました：';

  @override
  String get onboardingGatewayInactive => 'ゲートウェイサービスが実行中であることを確認できませんでした。';

  @override
  String get onboardingGatewayStarting => 'ゲートウェイサービスを起動中…';

  @override
  String get onboardingGatewayConfirming => 'サービスが動作中か確認しています…';

  @override
  String get onboardingGatewayErrorIdentity => 'デバイス ID の読み込み中にエラーが発生しました：';

  @override
  String get onboardingGatewayErrorNoIdentity => 'デバイス ID が見つかりません。';

  @override
  String get onboardingGatewayErrorPermissionsError => '権限の確認中にエラーが発生しました：';

  @override
  String get onboardingGatewaySetupPermissionsGranted => '権限が許可されました';

  @override
  String get onboardingGatewaySetupPermissionsGrantedSubtitle =>
      'SMS、通話、ネットワーク状態の権限が許可されています。';

  @override
  String get onboardingGatewaySetupPermissionsNotGrantedSubtitle =>
      'この役割に必要な権限が一部不足しています。';

  @override
  String get onboardingGatewaySetupDeviceConfigured => 'デバイスを設定しました';

  @override
  String get onboardingGatewaySetupDeviceConfiguredSubtitle => '基本設定が完了しました。';

  @override
  String get onboardingGatewaySetupHotspot => 'ホットスポット（テザリング）';

  @override
  String get onboardingGatewaySetupHotspotVerifying => 'ホットスポットを確認中…';

  @override
  String get onboardingGatewaySetupHotspotResolved => 'アクセスポイントの有効なアドレス：';

  @override
  String get onboardingGatewaySetupHotspotNotConnected =>
      'ホットスポットがオフです。有効にしてください。';

  @override
  String get onboardingGatewaySetupHotspotNotPermission =>
      'ネットワークの検出には位置情報の権限が必要です。';

  @override
  String get onboardingGatewaySetupHotspotNot => 'ホットスポットを検出できませんでした。';

  @override
  String get onboardingGatewaySetupBtnActivate => 'ゲートウェイを有効化';

  @override
  String get gatewayHomeAppbarTitle => 'DialcaLink ゲートウェイ';

  @override
  String get gatewayStatusTitleDisconnected => 'サービス停止中';

  @override
  String get gatewayStatusSubtitleDisconnected => 'ゲートウェイはデータを処理していません。';

  @override
  String get gatewayStatusTitleConnected => 'ゲートウェイ接続済み';

  @override
  String get gatewayStatusSubtitleConnected => '同期先：';

  @override
  String get gatewayStatusTitleConnecting => 'クライアントを待機中…';

  @override
  String get gatewayStatusSubtitleConnecting =>
      'ゲートウェイは動作中ですが、クライアントは接続されていません。';

  @override
  String get gatewayShowQRSubtitle =>
      'もう一方のデバイスに QR コードを表示し、このデバイスとペアリングしてください。';

  @override
  String get gatewayStatMessagesTitle => 'メッセージ';

  @override
  String get gatewayStatCallsTitle => '通話';

  @override
  String get gatewayStatTodayLow => '今日';

  @override
  String get gatewayDeviceInfo => 'デバイス情報';

  @override
  String get gatewayDeviceInfoName => 'デバイス名';

  @override
  String get gatewayDeviceInfoIP => 'デバイスの IP アドレス';

  @override
  String get gatewayDeviceInfoNotIP => '利用できません';

  @override
  String get gatewayDeviceInfoStartedFrom => '稼働開始';

  @override
  String get gatewayDeviceInfoActivityTime => '稼働時間';

  @override
  String get gatewayDeviceInfoNotStarted => '未起動';

  @override
  String get gatewayPairTitle => '接続まであと少し';

  @override
  String get gatewayPairSubtitle =>
      'メインデバイスで DialcaLink を開き、QR コードをスキャンしてください。';

  @override
  String get gatewayPairReadyToScan => 'スキャンできます';

  @override
  String get gatewayPairPINHint => 'または、クライアントで次のコードを入力してペアリングします：';

  @override
  String get gatewayBtnDone => '完了';

  @override
  String get gatewayBtnGenerateCode => '新しいコードを生成';

  @override
  String get clientSmsListEmptyTitle => 'SMS はありません';

  @override
  String get clientSmsListEmptySubtitle => '受信した SMS はここに表示されます。';

  @override
  String get clientSmsChatErrorSending => 'メッセージを送信できませんでした';

  @override
  String get clientSmsChatErrorLoadingMessages => 'メッセージの読み込みエラー：';

  @override
  String get clientNewSmsErrorSend => '電話番号とメッセージ内容を入力してください';

  @override
  String get clientNewSmsAppbarTitle => '新規 SMS';

  @override
  String get clientNewSmsLoadingContacts => '連絡先を読み込み中…';

  @override
  String get clientNewSmsSuggestions => '候補';

  @override
  String get clientNewSmsLabelTextarea => 'メッセージを入力…';

  @override
  String get clientNewSmsBtnSend => 'SMS を送信';

  @override
  String get clientCallsListEmptyTitle => '通話はありません';

  @override
  String get clientCallsListEmptySubtitle => '着信はここに表示されます。';

  @override
  String get clientCallsItemCourse => '進行中';

  @override
  String get clientStatusAppbarTitle => 'ステータス';

  @override
  String get clientStatusDisconnectedTitle => 'サービス未接続';

  @override
  String get clientStatusDisconnectedSubtitle => 'クライアントサービスは動作していません。';

  @override
  String get clientStatusConnectedTitle => 'サービス稼働中';

  @override
  String get clientStatusConnectedSubtitle => 'ゲートウェイと同期中です。';

  @override
  String get clientStatusConnectingTitle => '接続中…';

  @override
  String get clientStatusConnectingSubtitle => 'ゲートウェイを検索しています。';

  @override
  String get clientStatusWaitingTitle => 'ゲートウェイを待機中…';

  @override
  String get clientStatusWaitingSubtitle => 'クライアントサービスは動作中ですが、未接続です。';

  @override
  String get clientStatusCardTitle => 'クライアントサービスの状態';

  @override
  String get clientStatusVerifying => '確認中…';

  @override
  String get clientStatusError => '状態の取得中にエラーが発生しました';

  @override
  String get clientStatusInfo => 'ゲートウェイ情報';

  @override
  String get clientStatusDevice => 'デバイス';

  @override
  String get clientStatusIP => 'IP アドレス';

  @override
  String get clientStatusLastSync => '最終同期';

  @override
  String get clientStatusBtnReSync => 'デバイスを再ペアリング';

  @override
  String get clientStatusBtnForceSync => '再接続を強制';

  @override
  String get clientStatusBtnForgot => 'このゲートウェイを登録解除';

  @override
  String get clientStatusEmptyTitle => 'ペアリング済みのゲートウェイはありません。';

  @override
  String get clientStatusSync => 'デバイスをペアリング';

  @override
  String get clientStatusForgotDialogTitle => 'ゲートウェイを登録解除しますか？';

  @override
  String get clientStatusForgotDialogInfo =>
      '接続が解除されます。SMS と通話を受信するには、デバイスを再度ペアリングする必要があります。';

  @override
  String get clientStatusForgotDialogBtnCancel => 'キャンセル';

  @override
  String get clientStatusForgotDialogBtnForgot => '登録解除';
}
