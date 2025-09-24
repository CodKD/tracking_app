// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/forget_password/data/datasources/contracts/forget_password_remote_data_source.dart'
    as _i855;
import '../../features/forget_password/data/datasources/impl/forget_password_remote_data_source_impl.dart'
    as _i1014;
import '../../features/forget_password/data/repos_impl/forget_password_repo_impl.dart'
    as _i732;
import '../../features/forget_password/domain/repositories/forget_password_repo.dart'
    as _i184;
import '../../features/forget_password/domain/usecases/forget_password_use_case.dart'
    as _i773;
import '../../features/forget_password/domain/usecases/reset_password_use_case.dart'
    as _i123;
import '../../features/forget_password/domain/usecases/varify_reset_code_use_case.dart'
    as _i309;
import '../../features/forget_password/presentation/cubit/forget_password_cubit.dart'
    as _i1056;
import '../../features/login/data/data_source/login_remote_data_scource.dart'
    as _i207;
import '../../features/login/data/repos_impl/login_repo_impl.dart' as _i998;
import '../../features/login/domain/repos/login_repo.dart' as _i184;
import '../../features/login/domain/use_cases/login_use_case.dart' as _i191;
import '../../features/login/presentation/cubit/login_view_model.dart' as _i442;
import '../api_layer/api_client/api_client.dart' as _i225;
import '../api_layer/data_source_impl/login_remote_data_source_impl.dart'
    as _i915;
import '../modules/dio_module.dart' as _i948;
import '../modules/shared_preferences_module.dart' as _i744;
import '../utils/language_cubit.dart' as _i344;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    final sharedPreferencesModule = _$SharedPreferencesModule();
    gh.singleton<_i528.PrettyDioLogger>(
      () => dioModule.providePrettyDioLogger(),
    );
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.provideSharedPreferences(),
      preResolve: true,
    );
    gh.singleton<_i744.SharedPrefHelper>(
      () => _i744.SharedPrefHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i344.LocaleCubit>(
      () => _i344.LocaleCubit(sharedPrefHelper: gh<_i744.SharedPrefHelper>()),
    );
    gh.singleton<_i361.Dio>(
      () => dioModule.provideDio(
        gh<_i528.PrettyDioLogger>(),
        gh<_i744.SharedPrefHelper>(),
      ),
    );
    gh.singleton<_i225.ApiClient>(() => _i225.ApiClient.new(gh<_i361.Dio>()));
    gh.factory<_i207.LoginRemoteDataSource>(
      () => _i915.LoginRemoteDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i855.ForgetPasswordRemoteDataSource>(
      () => _i1014.ForgetPasswordRemoteDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i184.ForgetPasswordRepo>(
      () => _i732.ForgetPasswordRepoImpl(
        gh<_i855.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i184.LoginRepo>(
      () => _i998.LoginRepoImpl(gh<_i207.LoginRemoteDataSource>()),
    );
    gh.factory<_i191.LoginUseCase>(
      () => _i191.LoginUseCase(gh<_i184.LoginRepo>()),
    );
    gh.factory<_i442.LoginViewModel>(
      () => _i442.LoginViewModel(
        loginUseCase: gh<_i191.LoginUseCase>(),
        sharedPrefHelper: gh<_i744.SharedPrefHelper>(),
      ),
    );
    gh.factory<_i773.ForgetPasswordUseCase>(
      () => _i773.ForgetPasswordUseCase(gh<_i184.ForgetPasswordRepo>()),
    );
    gh.factory<_i123.ResetPasswordUseCase>(
      () => _i123.ResetPasswordUseCase(gh<_i184.ForgetPasswordRepo>()),
    );
    gh.factory<_i309.VerifyResetCodeUseCase>(
      () => _i309.VerifyResetCodeUseCase(gh<_i184.ForgetPasswordRepo>()),
    );
    gh.factory<_i1056.ForgetPasswordViewModel>(
      () => _i1056.ForgetPasswordViewModel(
        forgetPasswordUseCase: gh<_i773.ForgetPasswordUseCase>(),
        verifyResetCodeUseCase: gh<_i309.VerifyResetCodeUseCase>(),
        resetPasswordUseCase: gh<_i123.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i948.DioModule {}

class _$SharedPreferencesModule extends _i744.SharedPreferencesModule {}
