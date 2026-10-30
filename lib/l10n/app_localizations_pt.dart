// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'DialcaLink';

  @override
  String get start => 'Começar';

  @override
  String get continueLbl => 'Continuar';

  @override
  String get requestPermissions => 'Solicitar permissões';

  @override
  String get permissions => 'Permissões';

  @override
  String get attemptAgain => 'Tentar novamente';

  @override
  String get name => 'Nome';

  @override
  String get role => 'Função';

  @override
  String get uniqueID => 'ID único';

  @override
  String get unknownError => 'Erro desconhecido';

  @override
  String get searchUpdates => 'Procurar atualizações';

  @override
  String get searching => 'Procurando...';

  @override
  String get startService => 'Iniciar serviço';

  @override
  String get stopService => 'Parar serviço';

  @override
  String get appTheme => 'Aparência do aplicativo';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get clientUp => 'Cliente';

  @override
  String get clientLow => 'cliente';

  @override
  String get gatewayUp => 'Gateway';

  @override
  String get gatewayLow => 'gateway';

  @override
  String get onboardingWelcomeBadge => 'Boas-vindas';

  @override
  String get onboardingWelcomeTitle => 'Receba SMS e chamadas em um só lugar';

  @override
  String get onboardingWelcomeSubtitle =>
      'Conecte dois dispositivos Android para centralizar toda a sua atividade telefônica.';

  @override
  String get onboardingWelcomeHowWorksTitle => 'Como funciona?';

  @override
  String get onboardingWelcomeHowWorksText =>
      'O dispositivo com o cartão SIM compartilha SMS e chamadas pela sua rede Wi-Fi local. Seu dispositivo principal os recebe em tempo real.';

  @override
  String get onboardingWelcomeInfo =>
      'Suas informações permanecem dentro da sua rede\nlocal. Não utilizamos servidores externos.';

  @override
  String get onboardingRoleTitle => 'Boas-vindas ao DialcaLink';

  @override
  String get onboardingRoleSubtitle1 =>
      'Selecione como você usará este dispositivo.';

  @override
  String get onboardingRoleSubtitle2 =>
      'Você poderá alterar esta configuração mais tarde.';

  @override
  String get onboardingRoleClientCardTitle => 'Dispositivo principal';

  @override
  String get onboardingRoleClientCardInfo =>
      'Receba SMS e notificações de chamadas de outro telefone.';

  @override
  String get onboardingRoleGatewayCardTitle => 'Dispositivo com SIM';

  @override
  String get onboardingRoleGatewayRCardInfo =>
      'Compartilhe SMS e chamadas com seu dispositivo principal';

  @override
  String get onboardingPermissionsTitle => 'Permissões necessárias';

  @override
  String get onboardingPermissionsSubtitle =>
      'Para continuar, conceda as permissões necessárias para o funcionamento correto do aplicativo.';

  @override
  String get onboardingPermissionsManualGrant =>
      'Ir às Configurações para conceder a permissão manualmente';

  @override
  String get permissionSMSTitle => 'Mensagens SMS';

  @override
  String get permissionSMSDescription =>
      'Necessário para detectar SMS recebidos no Gateway.';

  @override
  String get permissionPhoneTitle => 'Status do telefone';

  @override
  String get permissionPhoneDescription =>
      'Necessário para detectar chamadas recebidas no Gateway.';

  @override
  String get permissionContactsTitle => 'Contatos';

  @override
  String get permissionContactsDescription =>
      'Permite mostrar nomes em vez de números nas mensagens SMS e chamadas.';

  @override
  String get permissionLocationTitle => 'Localização (rede Wi-Fi)';

  @override
  String get permissionLocationDescription =>
      'O Android exige esta permissão para detectar o endereço IP da rede Wi-Fi ativa.';

  @override
  String get permissionCameraTitle => 'Câmera';

  @override
  String get permissionCameraDescription =>
      'Necessário para ler o código QR de emparelhamento.';

  @override
  String get permissionNotificationsTitle => 'Notificações';

  @override
  String get permissionNotificationsDescription =>
      'Permite receber alertas de SMS e chamadas recebidas.';

  @override
  String get permissionPhoneHistoryTitle => 'Histórico de chamadas';

  @override
  String get permissionPhoneHistoryDescription =>
      'Necessário para detectar chamadas recebidas no Gateway.';

  @override
  String get onboardingPairingTitle => 'Vincular dispositivo';

  @override
  String get pairingStatusSearchingTitle => 'Procurando código QR';

  @override
  String get pairingStatusSearchingSubtitle =>
      'Aponte a câmera para o código QR para iniciar o emparelhamento.';

  @override
  String get pairingStatusVerifyingTitle => 'Verificando...';

  @override
  String get pairingStatusVerifyingSubtitle =>
      'Verificando a conexão com o dispositivo.';

  @override
  String get pairingStatusInvalidQRTitle => 'Código QR inválido';

  @override
  String get pairingStatusInvalidQRSubtitle =>
      'Este código QR não pertence a um dispositivo DialcaLink válido.';

  @override
  String get pairingStatusFailedTitle => 'Falha no emparelhamento';

  @override
  String get pairingStatusFailedSubtitle =>
      'Ocorreu um erro durante o emparelhamento.';

  @override
  String get pairingSuccessTitle => 'Emparelhamento concluído!';

  @override
  String get pairingSuccessSubtitle =>
      'Seu dispositivo agora está sincronizado com o Gateway. Redirecionando...';

  @override
  String get onboardingPairingPINSheetTitle => 'Vincular com código';

  @override
  String get onboardingPairingPINSheetReattempt => 'Tentar buscar novamente';

  @override
  String get onboardingPairingPINSheetSearching =>
      'Procurando um Gateway na rede...';

  @override
  String get onboardingPairingPINSheetLabelGatewayDetected =>
      'Gateway detectado';

  @override
  String get onboardingPairingPINSheetLabelGatewayIP => 'IP do Gateway';

  @override
  String get onboardingPairingPINSheetLabelGatewayHint =>
      '192.168.43.1 ou 192.168.1.X';

  @override
  String get onboardingPairingPINSheetLabelPIN => 'PIN de 6 dígitos';

  @override
  String get onboardingPairingPINSheetBtnPair => 'Vincular dispositivo';

  @override
  String get onboardingPairingPINSheetErrorMessage =>
      'Insira o IP e o PIN de 6 dígitos.';

  @override
  String get onboardingGatewaySetupAppbarTitle => 'Configurar Gateway';

  @override
  String get onboardingGatewaySetupTitle =>
      'Preparar o dispositivo como Gateway';

  @override
  String get onboardingGatewaySetupSubtitle =>
      'Configure seu dispositivo para funcionar como um ponto central de comunicação.';

  @override
  String get onboardingGatewaySetupGrantPermissionsError =>
      'Conceda todas as permissões necessárias.';

  @override
  String get onboardingGatewaySetupError =>
      'Erro ao iniciar o serviço Gateway:';

  @override
  String get onboardingGatewayInactive =>
      'Não foi possível confirmar que o serviço Gateway está em execução.';

  @override
  String get onboardingGatewayStarting => 'Iniciando o serviço Gateway...';

  @override
  String get onboardingGatewayConfirming =>
      'Verificando se o serviço está ativo...';

  @override
  String get onboardingGatewayErrorIdentity => 'Erro ao carregar a identidade:';

  @override
  String get onboardingGatewayErrorNoIdentity =>
      'A identidade do dispositivo não foi encontrada.';

  @override
  String get onboardingGatewayErrorPermissionsError =>
      'Erro ao verificar as permissões:';

  @override
  String get onboardingGatewaySetupPermissionsGranted =>
      'Permissões concedidas';

  @override
  String get onboardingGatewaySetupPermissionsGrantedSubtitle =>
      'Permissões de SMS, chamadas e status da rede concedidas.';

  @override
  String get onboardingGatewaySetupPermissionsNotGrantedSubtitle =>
      'Ainda faltam permissões exigidas por esta função.';

  @override
  String get onboardingGatewaySetupDeviceConfigured =>
      'Dispositivo configurado';

  @override
  String get onboardingGatewaySetupDeviceConfiguredSubtitle =>
      'Configurações básicas prontas.';

  @override
  String get onboardingGatewaySetupHotspot => 'Roteador Wi-Fi (hotspot)';

  @override
  String get onboardingGatewaySetupHotspotVerifying =>
      'Verificando o hotspot...';

  @override
  String get onboardingGatewaySetupHotspotResolved =>
      'Ponto de acesso ativo em:';

  @override
  String get onboardingGatewaySetupHotspotNotConnected =>
      'O hotspot está desativado. Ative-o.';

  @override
  String get onboardingGatewaySetupHotspotNotPermission =>
      'São necessárias permissões de localização para detectar a rede.';

  @override
  String get onboardingGatewaySetupHotspotNot =>
      'Não foi possível detectar o hotspot.';

  @override
  String get onboardingGatewaySetupBtnActivate => 'Ativar Gateway';

  @override
  String get gatewayHomeAppbarTitle => 'DialcaLink Gateway';

  @override
  String get gatewayStatusTitleDisconnected => 'Serviço parado';

  @override
  String get gatewayStatusSubtitleDisconnected =>
      'O Gateway não está processando dados.';

  @override
  String get gatewayStatusTitleConnected => 'Gateway conectado';

  @override
  String get gatewayStatusSubtitleConnected => 'Sincronizando com';

  @override
  String get gatewayStatusTitleConnecting => 'Aguardando cliente...';

  @override
  String get gatewayStatusSubtitleConnecting =>
      'O Gateway está ativo, mas não há clientes conectados.';

  @override
  String get gatewayShowQRSubtitle =>
      'Exiba o código QR no outro dispositivo para vinculá-lo a este.';

  @override
  String get gatewayStatMessagesTitle => 'Mensagens';

  @override
  String get gatewayStatCallsTitle => 'Chamadas';

  @override
  String get gatewayStatTodayLow => 'hoje';

  @override
  String get gatewayDeviceInfo => 'Informações do dispositivo';

  @override
  String get gatewayDeviceInfoName => 'Nome do dispositivo';

  @override
  String get gatewayDeviceInfoIP => 'IP do dispositivo';

  @override
  String get gatewayDeviceInfoNotIP => 'Indisponível';

  @override
  String get gatewayDeviceInfoStartedFrom => 'Ativo desde';

  @override
  String get gatewayDeviceInfoActivityTime => 'Tempo de atividade';

  @override
  String get gatewayDeviceInfoNotStarted => 'Não iniciado';

  @override
  String get gatewayPairTitle => 'Quase pronto para conectar';

  @override
  String get gatewayPairSubtitle =>
      'Abra o DialcaLink no dispositivo principal e leia o código QR.';

  @override
  String get gatewayPairReadyToScan => 'Pronto para ler';

  @override
  String get gatewayPairPINHint =>
      'Ou vincule inserindo este código no cliente:';

  @override
  String get gatewayBtnDone => 'Concluído';

  @override
  String get gatewayBtnGenerateCode => 'Gerar novo código';

  @override
  String get clientSmsListEmptyTitle => 'Nenhuma mensagem SMS disponível';

  @override
  String get clientSmsListEmptySubtitle =>
      'As mensagens SMS recebidas aparecerão aqui.';

  @override
  String get clientSmsChatErrorSending => 'Não foi possível enviar a mensagem';

  @override
  String get clientSmsChatErrorLoadingMessages => 'Erro ao carregar mensagens:';

  @override
  String get clientNewSmsErrorSend =>
      'Informe o número de telefone e o conteúdo da mensagem';

  @override
  String get clientNewSmsAppbarTitle => 'Novo SMS';

  @override
  String get clientNewSmsLoadingContacts => 'Carregando contatos...';

  @override
  String get clientNewSmsSuggestions => 'Sugestões';

  @override
  String get clientNewSmsLabelTextarea => 'Digite sua mensagem...';

  @override
  String get clientNewSmsBtnSend => 'Enviar SMS';

  @override
  String get clientCallsListEmptyTitle => 'Nenhuma chamada disponível';

  @override
  String get clientCallsListEmptySubtitle =>
      'As chamadas recebidas aparecerão aqui.';

  @override
  String get clientCallsItemCourse => 'Em andamento';

  @override
  String get clientStatusAppbarTitle => 'Status';

  @override
  String get clientStatusDisconnectedTitle => 'Serviço desconectado';

  @override
  String get clientStatusDisconnectedSubtitle =>
      'O serviço do cliente não está ativo.';

  @override
  String get clientStatusConnectedTitle => 'Serviço ativo';

  @override
  String get clientStatusConnectedSubtitle => 'Sincronizando com o Gateway.';

  @override
  String get clientStatusConnectingTitle => 'Estabelecendo conexão...';

  @override
  String get clientStatusConnectingSubtitle =>
      'O serviço está procurando o Gateway.';

  @override
  String get clientStatusWaitingTitle => 'Aguardando Gateway...';

  @override
  String get clientStatusWaitingSubtitle =>
      'O serviço do cliente está ativo, mas desconectado.';

  @override
  String get clientStatusCardTitle => 'Status do serviço do cliente';

  @override
  String get clientStatusVerifying => 'Verificando...';

  @override
  String get clientStatusError => 'Erro ao obter o status';

  @override
  String get clientStatusInfo => 'Informações do Gateway';

  @override
  String get clientStatusDevice => 'Dispositivo';

  @override
  String get clientStatusIP => 'Endereço IP';

  @override
  String get clientStatusLastSync => 'Última sincronização';

  @override
  String get clientStatusBtnReSync => 'Vincular dispositivo novamente';

  @override
  String get clientStatusBtnForceSync => 'Forçar reconexão';

  @override
  String get clientStatusBtnForgot => 'Esquecer este Gateway';

  @override
  String get clientStatusEmptyTitle => 'Nenhum Gateway vinculado.';

  @override
  String get clientStatusSync => 'Vincular dispositivo';

  @override
  String get clientStatusForgotDialogTitle => 'Esquecer o Gateway?';

  @override
  String get clientStatusForgotDialogInfo =>
      'A conexão será perdida e você precisará vincular o dispositivo novamente para receber SMS e chamadas.';

  @override
  String get clientStatusForgotDialogBtnCancel => 'Cancelar';

  @override
  String get clientStatusForgotDialogBtnForgot => 'Esquecer';
}
