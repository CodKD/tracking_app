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
import '../../features/forget_password/domain/usecases/varify_reset_code_use_case.dart'
    as _i309;
import '../api_layer/api_client/api_client.dart' as _i225;
import 'modules/dio_module.dart' as _i983;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i528.PrettyDioLogger>(
      () => dioModule.providePrettyDioLogger(),
    );
    gh.singleton<_i361.Dio>(
      () => dioModule.provideDio(gh<_i528.PrettyDioLogger>()),
    );
    gh.singleton<_i225.ApiClient>(() => _i225.ApiClient(gh<_i361.Dio>()));
    gh.factory<_i855.ForgetPasswordRemoteDataSource>(
      () => _i1014.ForgetPasswordRemoteDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i184.ForgetPasswordRepo>(
      () => _i732.ForgetPasswordRepoImpl(
        gh<_i855.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i773.ForgetPasswordUseCase>(
      () => _i773.ForgetPasswordUseCase(gh<_i184.ForgetPasswordRepo>()),
    );
    gh.factory<_i309.VarifyResetCodeUseCase>(
      () => _i309.VarifyResetCodeUseCase(gh<_i184.ForgetPasswordRepo>()),
    );
    return this;
  }
}

class _$DioModule extends _i983.DioModule {}
