// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppInfoModelImpl _$$AppInfoModelImplFromJson(Map<String, dynamic> json) =>
    _$AppInfoModelImpl(
      packageName: json['packageName'] as String? ?? '',
      appVersion: json['appVersion'] as String? ?? '',
      deviceId: json['deviceId'] as String? ?? '',
      deviceModel: json['deviceModel'] as String? ?? '',
      systemVersion: json['systemVersion'] as String? ?? '',
      firstLaunch: json['firstLaunch'] as bool? ?? false,
    );

Map<String, dynamic> _$$AppInfoModelImplToJson(_$AppInfoModelImpl instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'appVersion': instance.appVersion,
      'deviceId': instance.deviceId,
      'deviceModel': instance.deviceModel,
      'systemVersion': instance.systemVersion,
      'firstLaunch': instance.firstLaunch,
    };
