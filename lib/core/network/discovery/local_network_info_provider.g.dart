// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_network_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localNetworkInfoServiceHash() =>
    r'a866ba88bf11c55f18807f18546e894b99ef6c9b';

/// See also [localNetworkInfoService].
@ProviderFor(localNetworkInfoService)
final localNetworkInfoServiceProvider =
    AutoDisposeProvider<LocalNetworkInfoService>.internal(
      localNetworkInfoService,
      name: r'localNetworkInfoServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$localNetworkInfoServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocalNetworkInfoServiceRef =
    AutoDisposeProviderRef<LocalNetworkInfoService>;
String _$gatewayIpHash() => r'0033e7f0b900b52fc39e3a12f3b5a5c23aed71cc';

/// See also [gatewayIp].
@ProviderFor(gatewayIp)
final gatewayIpProvider = AutoDisposeFutureProvider<NetworkInfoResult>.internal(
  gatewayIp,
  name: r'gatewayIpProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gatewayIpHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GatewayIpRef = AutoDisposeFutureProviderRef<NetworkInfoResult>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
