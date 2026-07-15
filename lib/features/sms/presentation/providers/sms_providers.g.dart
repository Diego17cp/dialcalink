// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$smsRepositoryHash() => r'18f059a4e01ebf145f4fc8cf888db61f91cb3fd2';

/// See also [smsRepository].
@ProviderFor(smsRepository)
final smsRepositoryProvider = AutoDisposeProvider<SmsRepository>.internal(
  smsRepository,
  name: r'smsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$smsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SmsRepositoryRef = AutoDisposeProviderRef<SmsRepository>;
String _$receiveSmsUseCaseHash() => r'e1cb2814a1cc134d47b9270adaaa45e9250cb6dc';

/// See also [receiveSmsUseCase].
@ProviderFor(receiveSmsUseCase)
final receiveSmsUseCaseProvider =
    AutoDisposeProvider<ReceiveSmsUseCase>.internal(
      receiveSmsUseCase,
      name: r'receiveSmsUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$receiveSmsUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReceiveSmsUseCaseRef = AutoDisposeProviderRef<ReceiveSmsUseCase>;
String _$applySyncedSmsUseCaseHash() =>
    r'bc67ef3ea9c2da9f6234d421770379fc4d4a9250';

/// See also [applySyncedSmsUseCase].
@ProviderFor(applySyncedSmsUseCase)
final applySyncedSmsUseCaseProvider =
    AutoDisposeProvider<ApplySyncedSmsUseCase>.internal(
      applySyncedSmsUseCase,
      name: r'applySyncedSmsUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$applySyncedSmsUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApplySyncedSmsUseCaseRef =
    AutoDisposeProviderRef<ApplySyncedSmsUseCase>;
String _$sendSmsNativeHash() => r'b3bd67f2b7b5f9f4078adb24206a067eb720f8aa';

/// See also [sendSmsNative].
@ProviderFor(sendSmsNative)
final sendSmsNativeProvider =
    AutoDisposeProvider<
      Future<Result<void>> Function(String to, String content)
    >.internal(
      sendSmsNative,
      name: r'sendSmsNativeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sendSmsNativeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SendSmsNativeRef =
    AutoDisposeProviderRef<
      Future<Result<void>> Function(String to, String content)
    >;
String _$sendSmsUseCaseHash() => r'afcf667834456bdd3ffe0cab7025a412e2250b43';

/// See also [sendSmsUseCase].
@ProviderFor(sendSmsUseCase)
final sendSmsUseCaseProvider = AutoDisposeProvider<SendSmsUseCase>.internal(
  sendSmsUseCase,
  name: r'sendSmsUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sendSmsUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SendSmsUseCaseRef = AutoDisposeProviderRef<SendSmsUseCase>;
String _$allSmsMessagesHash() => r'33e3b254c309e5fc556fb6b01a935cd4d1fa7687';

/// See also [allSmsMessages].
@ProviderFor(allSmsMessages)
final allSmsMessagesProvider =
    AutoDisposeStreamProvider<List<SmsMessageEntity>>.internal(
      allSmsMessages,
      name: r'allSmsMessagesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allSmsMessagesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllSmsMessagesRef =
    AutoDisposeStreamProviderRef<List<SmsMessageEntity>>;
String _$smsMessagesByPhoneNumberHash() =>
    r'57a9783c39e60aa70f484cc959c295aa07a08f04';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [smsMessagesByPhoneNumber].
@ProviderFor(smsMessagesByPhoneNumber)
const smsMessagesByPhoneNumberProvider = SmsMessagesByPhoneNumberFamily();

/// See also [smsMessagesByPhoneNumber].
class SmsMessagesByPhoneNumberFamily
    extends Family<AsyncValue<List<SmsMessageEntity>>> {
  /// See also [smsMessagesByPhoneNumber].
  const SmsMessagesByPhoneNumberFamily();

  /// See also [smsMessagesByPhoneNumber].
  SmsMessagesByPhoneNumberProvider call(String phoneNumber) {
    return SmsMessagesByPhoneNumberProvider(phoneNumber);
  }

  @override
  SmsMessagesByPhoneNumberProvider getProviderOverride(
    covariant SmsMessagesByPhoneNumberProvider provider,
  ) {
    return call(provider.phoneNumber);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'smsMessagesByPhoneNumberProvider';
}

/// See also [smsMessagesByPhoneNumber].
class SmsMessagesByPhoneNumberProvider
    extends AutoDisposeStreamProvider<List<SmsMessageEntity>> {
  /// See also [smsMessagesByPhoneNumber].
  SmsMessagesByPhoneNumberProvider(String phoneNumber)
    : this._internal(
        (ref) => smsMessagesByPhoneNumber(
          ref as SmsMessagesByPhoneNumberRef,
          phoneNumber,
        ),
        from: smsMessagesByPhoneNumberProvider,
        name: r'smsMessagesByPhoneNumberProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$smsMessagesByPhoneNumberHash,
        dependencies: SmsMessagesByPhoneNumberFamily._dependencies,
        allTransitiveDependencies:
            SmsMessagesByPhoneNumberFamily._allTransitiveDependencies,
        phoneNumber: phoneNumber,
      );

  SmsMessagesByPhoneNumberProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.phoneNumber,
  }) : super.internal();

  final String phoneNumber;

  @override
  Override overrideWith(
    Stream<List<SmsMessageEntity>> Function(
      SmsMessagesByPhoneNumberRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SmsMessagesByPhoneNumberProvider._internal(
        (ref) => create(ref as SmsMessagesByPhoneNumberRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        phoneNumber: phoneNumber,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<SmsMessageEntity>> createElement() {
    return _SmsMessagesByPhoneNumberProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SmsMessagesByPhoneNumberProvider &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, phoneNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SmsMessagesByPhoneNumberRef
    on AutoDisposeStreamProviderRef<List<SmsMessageEntity>> {
  /// The parameter `phoneNumber` of this provider.
  String get phoneNumber;
}

class _SmsMessagesByPhoneNumberProviderElement
    extends AutoDisposeStreamProviderElement<List<SmsMessageEntity>>
    with SmsMessagesByPhoneNumberRef {
  _SmsMessagesByPhoneNumberProviderElement(super.provider);

  @override
  String get phoneNumber =>
      (origin as SmsMessagesByPhoneNumberProvider).phoneNumber;
}

String _$unreadSmsCountHash() => r'0d987427040339f6d56d012004c121fd01a31f9e';

/// See also [unreadSmsCount].
@ProviderFor(unreadSmsCount)
final unreadSmsCountProvider = AutoDisposeStreamProvider<int>.internal(
  unreadSmsCount,
  name: r'unreadSmsCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadSmsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnreadSmsCountRef = AutoDisposeStreamProviderRef<int>;
String _$markSmsAsReadHash() => r'a1ea776069e427fa278d43af175d33256c128ca6';

/// See also [markSmsAsRead].
@ProviderFor(markSmsAsRead)
const markSmsAsReadProvider = MarkSmsAsReadFamily();

/// See also [markSmsAsRead].
class MarkSmsAsReadFamily extends Family<AsyncValue<Result<void>>> {
  /// See also [markSmsAsRead].
  const MarkSmsAsReadFamily();

  /// See also [markSmsAsRead].
  MarkSmsAsReadProvider call(String messageId) {
    return MarkSmsAsReadProvider(messageId);
  }

  @override
  MarkSmsAsReadProvider getProviderOverride(
    covariant MarkSmsAsReadProvider provider,
  ) {
    return call(provider.messageId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'markSmsAsReadProvider';
}

/// See also [markSmsAsRead].
class MarkSmsAsReadProvider extends AutoDisposeFutureProvider<Result<void>> {
  /// See also [markSmsAsRead].
  MarkSmsAsReadProvider(String messageId)
    : this._internal(
        (ref) => markSmsAsRead(ref as MarkSmsAsReadRef, messageId),
        from: markSmsAsReadProvider,
        name: r'markSmsAsReadProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$markSmsAsReadHash,
        dependencies: MarkSmsAsReadFamily._dependencies,
        allTransitiveDependencies:
            MarkSmsAsReadFamily._allTransitiveDependencies,
        messageId: messageId,
      );

  MarkSmsAsReadProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.messageId,
  }) : super.internal();

  final String messageId;

  @override
  Override overrideWith(
    FutureOr<Result<void>> Function(MarkSmsAsReadRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MarkSmsAsReadProvider._internal(
        (ref) => create(ref as MarkSmsAsReadRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        messageId: messageId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Result<void>> createElement() {
    return _MarkSmsAsReadProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MarkSmsAsReadProvider && other.messageId == messageId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, messageId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MarkSmsAsReadRef on AutoDisposeFutureProviderRef<Result<void>> {
  /// The parameter `messageId` of this provider.
  String get messageId;
}

class _MarkSmsAsReadProviderElement
    extends AutoDisposeFutureProviderElement<Result<void>>
    with MarkSmsAsReadRef {
  _MarkSmsAsReadProviderElement(super.provider);

  @override
  String get messageId => (origin as MarkSmsAsReadProvider).messageId;
}

String _$markConversationAsReadHash() =>
    r'a3accfb8b2b35d6a6141ea152e660890f52486cf';

/// See also [markConversationAsRead].
@ProviderFor(markConversationAsRead)
const markConversationAsReadProvider = MarkConversationAsReadFamily();

/// See also [markConversationAsRead].
class MarkConversationAsReadFamily extends Family<AsyncValue<Result<void>>> {
  /// See also [markConversationAsRead].
  const MarkConversationAsReadFamily();

  /// See also [markConversationAsRead].
  MarkConversationAsReadProvider call(String phoneNumber) {
    return MarkConversationAsReadProvider(phoneNumber);
  }

  @override
  MarkConversationAsReadProvider getProviderOverride(
    covariant MarkConversationAsReadProvider provider,
  ) {
    return call(provider.phoneNumber);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'markConversationAsReadProvider';
}

/// See also [markConversationAsRead].
class MarkConversationAsReadProvider
    extends AutoDisposeFutureProvider<Result<void>> {
  /// See also [markConversationAsRead].
  MarkConversationAsReadProvider(String phoneNumber)
    : this._internal(
        (ref) => markConversationAsRead(
          ref as MarkConversationAsReadRef,
          phoneNumber,
        ),
        from: markConversationAsReadProvider,
        name: r'markConversationAsReadProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$markConversationAsReadHash,
        dependencies: MarkConversationAsReadFamily._dependencies,
        allTransitiveDependencies:
            MarkConversationAsReadFamily._allTransitiveDependencies,
        phoneNumber: phoneNumber,
      );

  MarkConversationAsReadProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.phoneNumber,
  }) : super.internal();

  final String phoneNumber;

  @override
  Override overrideWith(
    FutureOr<Result<void>> Function(MarkConversationAsReadRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MarkConversationAsReadProvider._internal(
        (ref) => create(ref as MarkConversationAsReadRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        phoneNumber: phoneNumber,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Result<void>> createElement() {
    return _MarkConversationAsReadProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MarkConversationAsReadProvider &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, phoneNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MarkConversationAsReadRef on AutoDisposeFutureProviderRef<Result<void>> {
  /// The parameter `phoneNumber` of this provider.
  String get phoneNumber;
}

class _MarkConversationAsReadProviderElement
    extends AutoDisposeFutureProviderElement<Result<void>>
    with MarkConversationAsReadRef {
  _MarkConversationAsReadProviderElement(super.provider);

  @override
  String get phoneNumber =>
      (origin as MarkConversationAsReadProvider).phoneNumber;
}

String _$smsSentResultStreamHash() =>
    r'4016906d5a4320eb40a17b12716081f53e94ddf8';

/// See also [smsSentResultStream].
@ProviderFor(smsSentResultStream)
final smsSentResultStreamProvider =
    AutoDisposeStreamProvider<SmsSentResult>.internal(
      smsSentResultStream,
      name: r'smsSentResultStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$smsSentResultStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SmsSentResultStreamRef = AutoDisposeStreamProviderRef<SmsSentResult>;
String _$smsConversationsHash() => r'b28f7f16afbd10d4be7c14791fbab37fc7ab5f1f';

/// See also [smsConversations].
@ProviderFor(smsConversations)
final smsConversationsProvider =
    AutoDisposeStreamProvider<List<SmsMessageEntity>>.internal(
      smsConversations,
      name: r'smsConversationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$smsConversationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SmsConversationsRef =
    AutoDisposeStreamProviderRef<List<SmsMessageEntity>>;
String _$smsSentStatusesHash() => r'1ea0eb5afe5a9279604605eba4053e7c19d52fd1';

/// See also [SmsSentStatuses].
@ProviderFor(SmsSentStatuses)
final smsSentStatusesProvider =
    AutoDisposeNotifierProvider<
      SmsSentStatuses,
      Map<String, SmsSentResult>
    >.internal(
      SmsSentStatuses.new,
      name: r'smsSentStatusesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$smsSentStatusesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SmsSentStatuses = AutoDisposeNotifier<Map<String, SmsSentResult>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
