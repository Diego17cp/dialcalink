// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_service_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clientServiceRunningHash() =>
    r'525c308d422412a7331d9ea7d6c2ee3f9b880336';

/// See also [clientServiceRunning].
@ProviderFor(clientServiceRunning)
final clientServiceRunningProvider = AutoDisposeFutureProvider<bool>.internal(
  clientServiceRunning,
  name: r'clientServiceRunningProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clientServiceRunningHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClientServiceRunningRef = AutoDisposeFutureProviderRef<bool>;
String _$clientServiceRestartControllerHash() =>
    r'8ed64e04e7e97900504e45ab5484b6518ed27312';

/// See also [ClientServiceRestartController].
@ProviderFor(ClientServiceRestartController)
final clientServiceRestartControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      ClientServiceRestartController,
      void
    >.internal(
      ClientServiceRestartController.new,
      name: r'clientServiceRestartControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$clientServiceRestartControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ClientServiceRestartController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
