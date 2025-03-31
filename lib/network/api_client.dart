import 'package:dio/dio.dart';
import 'package:flutternow/base/base.dart';
import 'package:flutternow/models/app_user_model.dart';
import 'package:flutternow/models/app_version_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  /// 游客登录
  @GET('/api/auth/visitor_login')
  Future<BaseResponse<AppUserModel>> loginByGuest();

  /// 账号登录
  @POST('/api/auth/pwd_login')
  Future<BaseResponse<AppUserModel>> loginByAccount({
    @Field() required String username,
    @Field() required String password,
  });

  /// 获取短信验证码
  @POST('/api/user/code')
  Future<BaseResponse<String>> getSMSCode({
    @Field() required String phone,
  });

  /// 手机号+验证码登录
  @POST('/api/user/login/code')
  Future<BaseResponse<AppUserModel>> loginByPhone({
    @Field() required String phone,
    @Field() required String code,
  });

  /// 第三方平台登录
  @POST('/api/user/login/tl')
  Future<BaseResponse<AppUserModel>> loginByPlatform({
    @Field('login_type') required int type,
    @Field('open_id') required String openId,
    required String avatar,
  });

  /// 手机号一键登录
  @POST('/api/user/login/phone')
  Future<BaseResponse<AppUserModel>> loginByPhoneVerify({
    @Field() required String token,
    @Field() required String gyuid,
  });

  /// 注销账号
  @DELETE('/api/user/del')
  Future<BaseResponse<String>> deleteAccount();

  /// 获取当前登录用户信息
  @GET('/api/user/profile')
  Future<BaseResponse<AppUserModel>> getCurrentUser();

  /// 获取app版本，检查有没有更新
  @GET('/api/common/version')
  Future<BaseResponse<AppVersionModel>> getAppVersion();

  /// 获取app配置
  @GET('/api/common/config')
  Future<BaseResponse<String>> getAppConfig();
}
