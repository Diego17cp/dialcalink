// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'DialcaLink';

  @override
  String get start => '开始';

  @override
  String get continueLbl => '继续';

  @override
  String get requestPermissions => '请求权限';

  @override
  String get permissions => '权限';

  @override
  String get attemptAgain => '重试';

  @override
  String get name => '名称';

  @override
  String get role => '角色';

  @override
  String get uniqueID => '唯一 ID';

  @override
  String get unknownError => '未知错误';

  @override
  String get searchUpdates => '检查更新';

  @override
  String get searching => '正在搜索…';

  @override
  String get startService => '启动服务';

  @override
  String get stopService => '停止服务';

  @override
  String get appTheme => '应用外观';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get clientUp => '客户端';

  @override
  String get clientLow => '客户端';

  @override
  String get gatewayUp => '网关';

  @override
  String get gatewayLow => '网关';

  @override
  String get unknown => '未知';

  @override
  String get onboardingWelcomeBadge => '欢迎';

  @override
  String get onboardingWelcomeTitle => '在同一处接收短信和来电';

  @override
  String get onboardingWelcomeSubtitle => '连接两台 Android 设备，集中管理所有电话活动。';

  @override
  String get onboardingWelcomeHowWorksTitle => '工作原理';

  @override
  String get onboardingWelcomeHowWorksText =>
      '装有 SIM 卡的设备通过本地 Wi-Fi 网络共享短信和通话信息，主设备可实时接收。';

  @override
  String get onboardingWelcomeInfo => '你的信息仅保留在本地网络中。\n我们不会使用外部服务器。';

  @override
  String get onboardingRoleTitle => '欢迎使用 DialcaLink';

  @override
  String get onboardingRoleSubtitle1 => '选择此设备的使用方式。';

  @override
  String get onboardingRoleSubtitle2 => '你可以稍后更改此设置。';

  @override
  String get onboardingRoleClientCardTitle => '主设备';

  @override
  String get onboardingRoleClientCardInfo => '接收来自另一部手机的短信和来电通知。';

  @override
  String get onboardingRoleGatewayCardTitle => 'SIM 卡设备';

  @override
  String get onboardingRoleGatewayRCardInfo => '与主设备共享短信和通话信息';

  @override
  String get onboardingPermissionsTitle => '所需权限';

  @override
  String get onboardingPermissionsSubtitle => '要继续使用，请授予应用正常运行所需的权限。';

  @override
  String get onboardingPermissionsManualGrant => '前往设置以手动授予权限';

  @override
  String get permissionSMSTitle => '短信';

  @override
  String get permissionSMSDescription => '用于检测网关设备收到的短信。';

  @override
  String get permissionPhoneTitle => '电话状态';

  @override
  String get permissionPhoneDescription => '用于检测网关设备收到的来电。';

  @override
  String get permissionContactsTitle => '联系人';

  @override
  String get permissionContactsDescription => '在短信和通话记录中显示联系人姓名，而不是电话号码。';

  @override
  String get permissionLocationTitle => '位置信息（Wi-Fi 网络）';

  @override
  String get permissionLocationDescription =>
      'Android 需要此权限才能检测当前 Wi-Fi 网络的 IP 地址。';

  @override
  String get permissionCameraTitle => '相机';

  @override
  String get permissionCameraDescription => '用于扫描配对二维码。';

  @override
  String get permissionNotificationsTitle => '通知';

  @override
  String get permissionNotificationsDescription => '允许接收短信和来电提醒。';

  @override
  String get permissionPhoneHistoryTitle => '通话记录';

  @override
  String get permissionPhoneHistoryDescription => '用于检测网关设备收到的来电。';

  @override
  String get onboardingPairingTitle => '配对设备';

  @override
  String get pairingStatusSearchingTitle => '正在查找二维码';

  @override
  String get pairingStatusSearchingSubtitle => '将摄像头对准二维码以开始配对。';

  @override
  String get pairingStatusVerifyingTitle => '正在验证…';

  @override
  String get pairingStatusVerifyingSubtitle => '正在验证与设备的连接。';

  @override
  String get pairingStatusInvalidQRTitle => '二维码无效';

  @override
  String get pairingStatusInvalidQRSubtitle => '此二维码不属于有效的 DialcaLink 设备。';

  @override
  String get pairingStatusFailedTitle => '配对失败';

  @override
  String get pairingStatusFailedSubtitle => '配对过程中发生错误。';

  @override
  String get pairingSuccessTitle => '配对成功！';

  @override
  String get pairingSuccessSubtitle => '你的设备现已与网关同步。正在跳转…';

  @override
  String get onboardingPairingPINSheetTitle => '使用代码配对';

  @override
  String get onboardingPairingPINSheetReattempt => '重新搜索';

  @override
  String get onboardingPairingPINSheetSearching => '正在网络中搜索网关…';

  @override
  String get onboardingPairingPINSheetLabelGatewayDetected => '已检测到 Gateway';

  @override
  String get onboardingPairingPINSheetLabelGatewayIP => '网关 IP 地址';

  @override
  String get onboardingPairingPINSheetLabelGatewayHint =>
      '192.168.43.1 或 192.168.1.X';

  @override
  String get onboardingPairingPINSheetLabelPIN => '6 位 PIN 码';

  @override
  String get onboardingPairingPINSheetBtnPair => '配对设备';

  @override
  String get onboardingPairingPINSheetErrorMessage => '请输入 IP 地址和 6 位 PIN 码。';

  @override
  String get onboardingGatewaySetupAppbarTitle => '设置网关';

  @override
  String get onboardingGatewaySetupTitle => '将此设备设置为网关';

  @override
  String get onboardingGatewaySetupSubtitle => '将设备配置为通信中枢。';

  @override
  String get onboardingGatewaySetupGrantPermissionsError => '请授予所有必需的权限。';

  @override
  String get onboardingGatewaySetupError => '启动网关服务时出错：';

  @override
  String get onboardingGatewayInactive => '无法确认网关服务正在运行。';

  @override
  String get onboardingGatewayStarting => '正在启动网关服务…';

  @override
  String get onboardingGatewayConfirming => '正在确认服务是否已启动…';

  @override
  String get onboardingGatewayErrorIdentity => '加载设备身份信息时出错：';

  @override
  String get onboardingGatewayErrorNoIdentity => '未找到设备身份信息。';

  @override
  String get onboardingGatewayErrorPermissionsError => '检查权限时出错：';

  @override
  String get onboardingGatewaySetupPermissionsGranted => '已授予权限';

  @override
  String get onboardingGatewaySetupPermissionsGrantedSubtitle =>
      '已授予短信、通话和网络状态权限。';

  @override
  String get onboardingGatewaySetupPermissionsNotGrantedSubtitle =>
      '尚未授予此角色所需的部分权限。';

  @override
  String get onboardingGatewaySetupDeviceConfigured => '设备已配置';

  @override
  String get onboardingGatewaySetupDeviceConfiguredSubtitle => '基本设置已就绪。';

  @override
  String get onboardingGatewaySetupHotspot => '热点（个人热点）';

  @override
  String get onboardingGatewaySetupHotspotVerifying => '正在检查热点…';

  @override
  String get onboardingGatewaySetupHotspotResolved => '接入点已在以下地址启用：';

  @override
  String get onboardingGatewaySetupHotspotNotConnected => '热点已关闭，请将其开启。';

  @override
  String get onboardingGatewaySetupHotspotNotPermission => '需要位置权限才能检测网络。';

  @override
  String get onboardingGatewaySetupHotspotNot => '无法检测到热点。';

  @override
  String get onboardingGatewaySetupBtnActivate => '启用网关';

  @override
  String get gatewayHomeAppbarTitle => 'DialcaLink 网关';

  @override
  String get gatewayStatusTitleDisconnected => '服务已停止';

  @override
  String get gatewayStatusSubtitleDisconnected => '网关未处理任何数据。';

  @override
  String get gatewayStatusTitleConnected => '网关已连接';

  @override
  String get gatewayStatusSubtitleConnected => '正在与以下设备同步：';

  @override
  String get gatewayStatusTitleConnecting => '正在等待客户端…';

  @override
  String get gatewayStatusSubtitleConnecting => '网关已启动，但尚无客户端连接。';

  @override
  String get gatewayShowQRSubtitle => '在另一台设备上显示二维码，以便将其与此设备配对。';

  @override
  String get gatewayStatMessagesTitle => '消息';

  @override
  String get gatewayStatCallsTitle => '通话';

  @override
  String get gatewayStatTodayLow => '今天';

  @override
  String get gatewayDeviceInfo => '设备信息';

  @override
  String get gatewayDeviceInfoName => '设备名称';

  @override
  String get gatewayDeviceInfoIP => '设备 IP 地址';

  @override
  String get gatewayDeviceInfoNotIP => '不可用';

  @override
  String get gatewayDeviceInfoStartedFrom => '运行开始时间';

  @override
  String get gatewayDeviceInfoActivityTime => '运行时长';

  @override
  String get gatewayDeviceInfoNotStarted => '尚未启动';

  @override
  String get gatewayPairTitle => '即将连接完成';

  @override
  String get gatewayPairSubtitle => '在主设备上打开 DialcaLink 并扫描二维码。';

  @override
  String get gatewayPairReadyToScan => '可以扫描';

  @override
  String get gatewayPairPINHint => '也可以在客户端输入此代码进行配对：';

  @override
  String get gatewayBtnDone => '完成';

  @override
  String get gatewayBtnGenerateCode => '生成新代码';

  @override
  String get clientSmsListEmptyTitle => '暂无短信';

  @override
  String get clientSmsListEmptySubtitle => '收到短信后，它们会显示在这里。';

  @override
  String get clientSmsChatErrorSending => '无法发送消息';

  @override
  String get clientSmsChatErrorLoadingMessages => '加载消息时出错：';

  @override
  String get clientNewSmsErrorSend => '请输入电话号码和消息内容';

  @override
  String get clientNewSmsAppbarTitle => '新建短信';

  @override
  String get clientNewSmsLoadingContacts => '正在加载联系人…';

  @override
  String get clientNewSmsSuggestions => '建议';

  @override
  String get clientNewSmsLabelTextarea => '输入消息…';

  @override
  String get clientNewSmsBtnSend => '发送短信';

  @override
  String get clientCallsListEmptyTitle => '暂无通话记录';

  @override
  String get clientCallsListEmptySubtitle => '收到来电后，它们会显示在这里。';

  @override
  String get clientCallsItemCourse => '进行中';

  @override
  String get clientStatusAppbarTitle => '状态';

  @override
  String get clientStatusDisconnectedTitle => '服务未连接';

  @override
  String get clientStatusDisconnectedSubtitle => '客户端服务未运行。';

  @override
  String get clientStatusConnectedTitle => '服务已启动';

  @override
  String get clientStatusConnectedSubtitle => '正在与网关同步。';

  @override
  String get clientStatusConnectingTitle => '正在建立连接…';

  @override
  String get clientStatusConnectingSubtitle => '服务正在搜索网关。';

  @override
  String get clientStatusWaitingTitle => '正在等待网关…';

  @override
  String get clientStatusWaitingSubtitle => '客户端服务正在运行，但尚未连接。';

  @override
  String get clientStatusCardTitle => '客户端服务状态';

  @override
  String get clientStatusVerifying => '正在验证…';

  @override
  String get clientStatusError => '获取状态时出错';

  @override
  String get clientStatusInfo => '网关信息';

  @override
  String get clientStatusDevice => '设备';

  @override
  String get clientStatusIP => 'IP 地址';

  @override
  String get clientStatusLastSync => '上次同步';

  @override
  String get clientStatusBtnReSync => '重新配对设备';

  @override
  String get clientStatusBtnForceSync => '强制重新连接';

  @override
  String get clientStatusBtnForgot => '忘记此网关';

  @override
  String get clientStatusEmptyTitle => '尚未配对任何网关。';

  @override
  String get clientStatusSync => '配对设备';

  @override
  String get clientStatusForgotDialogTitle => '忘记此网关？';

  @override
  String get clientStatusForgotDialogInfo => '连接将断开。你需要重新配对设备才能接收短信和通话信息。';

  @override
  String get clientStatusForgotDialogBtnCancel => '取消';

  @override
  String get clientStatusForgotDialogBtnForgot => '忘记';

  @override
  String get clientStatusGatewayStatusTitle => 'Gateway 服务状态';

  @override
  String get clientStatusGatewayReady => '已连接';

  @override
  String get clientStatusGatewayConnecting => '正在连接...';

  @override
  String get clientStatusGatewayReconnecting => '正在重新连接...';

  @override
  String get clientStatusGatewayRejected => '配对已丢失';

  @override
  String get clientStatusGatewayDisconnected => '已断开连接';

  @override
  String get clientStatusGatewayConnected => '正在验证身份...';

  @override
  String get clientStatusGatewayError => '连接错误';
}
