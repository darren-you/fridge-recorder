// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isLoggedHash() => r'869c5fa06db84ec1d6713b74223c9fcb585c3489';

/// See also [isLogged].
@ProviderFor(isLogged)
final isLoggedProvider = Provider<bool>.internal(
  isLogged,
  name: r'isLoggedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isLoggedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsLoggedRef = ProviderRef<bool>;
String _$appUserHash() => r'aeebc6d4427b4e28c144226cf56b3ba4eafef170';

/// See also [AppUser].
@ProviderFor(AppUser)
final appUserProvider = NotifierProvider<AppUser, AppUserModel?>.internal(
  AppUser.new,
  name: r'appUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppUser = Notifier<AppUserModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
