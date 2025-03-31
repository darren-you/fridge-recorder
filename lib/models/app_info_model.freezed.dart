// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppInfoModel _$AppInfoModelFromJson(Map<String, dynamic> json) {
  return _AppInfoModel.fromJson(json);
}

/// @nodoc
mixin _$AppInfoModel {
  String get packageName => throw _privateConstructorUsedError; // 包名
  String get appVersion => throw _privateConstructorUsedError; // App版本号
  String get deviceId => throw _privateConstructorUsedError; // 设备唯一标识
  String get deviceModel =>
      throw _privateConstructorUsedError; // 设备平台: Android、iOS...
  String get systemVersion => throw _privateConstructorUsedError; // 系统版本
  bool get firstLaunch => throw _privateConstructorUsedError;

  /// Serializes this AppInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppInfoModelCopyWith<AppInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppInfoModelCopyWith<$Res> {
  factory $AppInfoModelCopyWith(
          AppInfoModel value, $Res Function(AppInfoModel) then) =
      _$AppInfoModelCopyWithImpl<$Res, AppInfoModel>;
  @useResult
  $Res call(
      {String packageName,
      String appVersion,
      String deviceId,
      String deviceModel,
      String systemVersion,
      bool firstLaunch});
}

/// @nodoc
class _$AppInfoModelCopyWithImpl<$Res, $Val extends AppInfoModel>
    implements $AppInfoModelCopyWith<$Res> {
  _$AppInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? appVersion = null,
    Object? deviceId = null,
    Object? deviceModel = null,
    Object? systemVersion = null,
    Object? firstLaunch = null,
  }) {
    return _then(_value.copyWith(
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceModel: null == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String,
      systemVersion: null == systemVersion
          ? _value.systemVersion
          : systemVersion // ignore: cast_nullable_to_non_nullable
              as String,
      firstLaunch: null == firstLaunch
          ? _value.firstLaunch
          : firstLaunch // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppInfoModelImplCopyWith<$Res>
    implements $AppInfoModelCopyWith<$Res> {
  factory _$$AppInfoModelImplCopyWith(
          _$AppInfoModelImpl value, $Res Function(_$AppInfoModelImpl) then) =
      __$$AppInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String packageName,
      String appVersion,
      String deviceId,
      String deviceModel,
      String systemVersion,
      bool firstLaunch});
}

/// @nodoc
class __$$AppInfoModelImplCopyWithImpl<$Res>
    extends _$AppInfoModelCopyWithImpl<$Res, _$AppInfoModelImpl>
    implements _$$AppInfoModelImplCopyWith<$Res> {
  __$$AppInfoModelImplCopyWithImpl(
      _$AppInfoModelImpl _value, $Res Function(_$AppInfoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? appVersion = null,
    Object? deviceId = null,
    Object? deviceModel = null,
    Object? systemVersion = null,
    Object? firstLaunch = null,
  }) {
    return _then(_$AppInfoModelImpl(
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceModel: null == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String,
      systemVersion: null == systemVersion
          ? _value.systemVersion
          : systemVersion // ignore: cast_nullable_to_non_nullable
              as String,
      firstLaunch: null == firstLaunch
          ? _value.firstLaunch
          : firstLaunch // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppInfoModelImpl implements _AppInfoModel {
  const _$AppInfoModelImpl(
      {this.packageName = '',
      this.appVersion = '',
      this.deviceId = '',
      this.deviceModel = '',
      this.systemVersion = '',
      this.firstLaunch = false});

  factory _$AppInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppInfoModelImplFromJson(json);

  @override
  @JsonKey()
  final String packageName;
// 包名
  @override
  @JsonKey()
  final String appVersion;
// App版本号
  @override
  @JsonKey()
  final String deviceId;
// 设备唯一标识
  @override
  @JsonKey()
  final String deviceModel;
// 设备平台: Android、iOS...
  @override
  @JsonKey()
  final String systemVersion;
// 系统版本
  @override
  @JsonKey()
  final bool firstLaunch;

  @override
  String toString() {
    return 'AppInfoModel(packageName: $packageName, appVersion: $appVersion, deviceId: $deviceId, deviceModel: $deviceModel, systemVersion: $systemVersion, firstLaunch: $firstLaunch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppInfoModelImpl &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceModel, deviceModel) ||
                other.deviceModel == deviceModel) &&
            (identical(other.systemVersion, systemVersion) ||
                other.systemVersion == systemVersion) &&
            (identical(other.firstLaunch, firstLaunch) ||
                other.firstLaunch == firstLaunch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, packageName, appVersion,
      deviceId, deviceModel, systemVersion, firstLaunch);

  /// Create a copy of AppInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppInfoModelImplCopyWith<_$AppInfoModelImpl> get copyWith =>
      __$$AppInfoModelImplCopyWithImpl<_$AppInfoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppInfoModelImplToJson(
      this,
    );
  }
}

abstract class _AppInfoModel implements AppInfoModel {
  const factory _AppInfoModel(
      {final String packageName,
      final String appVersion,
      final String deviceId,
      final String deviceModel,
      final String systemVersion,
      final bool firstLaunch}) = _$AppInfoModelImpl;

  factory _AppInfoModel.fromJson(Map<String, dynamic> json) =
      _$AppInfoModelImpl.fromJson;

  @override
  String get packageName; // 包名
  @override
  String get appVersion; // App版本号
  @override
  String get deviceId; // 设备唯一标识
  @override
  String get deviceModel; // 设备平台: Android、iOS...
  @override
  String get systemVersion; // 系统版本
  @override
  bool get firstLaunch;

  /// Create a copy of AppInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppInfoModelImplCopyWith<_$AppInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
