// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$permissionsServiceHash() =>
    r'eed21bce69713524947aa7afaf6bb5eb85a6b1e2';

/// See also [permissionsService].
@ProviderFor(permissionsService)
final permissionsServiceProvider =
    AutoDisposeProvider<PermissionsService>.internal(
      permissionsService,
      name: r'permissionsServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$permissionsServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PermissionsServiceRef = AutoDisposeProviderRef<PermissionsService>;
String _$allPermissionsGrantedHash() =>
    r'6facbb7d6b72996488ff7ed151da3346922bcaf7';

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

/// See also [allPermissionsGranted].
@ProviderFor(allPermissionsGranted)
const allPermissionsGrantedProvider = AllPermissionsGrantedFamily();

/// See also [allPermissionsGranted].
class AllPermissionsGrantedFamily extends Family<AsyncValue<bool>> {
  /// See also [allPermissionsGranted].
  const AllPermissionsGrantedFamily();

  /// See also [allPermissionsGranted].
  AllPermissionsGrantedProvider call(AppRole role) {
    return AllPermissionsGrantedProvider(role);
  }

  @override
  AllPermissionsGrantedProvider getProviderOverride(
    covariant AllPermissionsGrantedProvider provider,
  ) {
    return call(provider.role);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'allPermissionsGrantedProvider';
}

/// See also [allPermissionsGranted].
class AllPermissionsGrantedProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [allPermissionsGranted].
  AllPermissionsGrantedProvider(AppRole role)
    : this._internal(
        (ref) => allPermissionsGranted(ref as AllPermissionsGrantedRef, role),
        from: allPermissionsGrantedProvider,
        name: r'allPermissionsGrantedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$allPermissionsGrantedHash,
        dependencies: AllPermissionsGrantedFamily._dependencies,
        allTransitiveDependencies:
            AllPermissionsGrantedFamily._allTransitiveDependencies,
        role: role,
      );

  AllPermissionsGrantedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.role,
  }) : super.internal();

  final AppRole role;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AllPermissionsGrantedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AllPermissionsGrantedProvider._internal(
        (ref) => create(ref as AllPermissionsGrantedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        role: role,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AllPermissionsGrantedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllPermissionsGrantedProvider && other.role == role;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, role.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AllPermissionsGrantedRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `role` of this provider.
  AppRole get role;
}

class _AllPermissionsGrantedProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with AllPermissionsGrantedRef {
  _AllPermissionsGrantedProviderElement(super.provider);

  @override
  AppRole get role => (origin as AllPermissionsGrantedProvider).role;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
