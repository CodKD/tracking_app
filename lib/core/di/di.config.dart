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

import '../../features/login/data/data_source/login_remote_data_scource.dart'
    as _i207;
import '../../features/login/data/repos_impl/login_repo_impl.dart' as _i998;
import '../../features/login/domain/repos/login_repo.dart' as _i184;
import '../../features/login/domain/use_cases/login_use_case.dart' as _i191;
import '../../features/login/presentation/cubit/login_view_model.dart' as _i442;
import '../api_layer/api_client/api_client.dart' as _i225;
import '../api_layer/data_source_impl/login_remote_data_source_impl.dart'
    as _i915;
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
    gh.factory<_i207.LoginRemoteDataSource>(
      () => _i915.LoginRemoteDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i184.LoginRepo>(
      () => _i998.LoginRepoImpl(gh<_i207.LoginRemoteDataSource>()),
    );
    gh.factory<_i191.LoginUseCase>(
      () => _i191.LoginUseCase(gh<_i184.LoginRepo>()),
    );
    gh.factory<_i442.LoginViewModel>(
      () => _i442.LoginViewModel(loginUseCase: gh<_i191.LoginUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i983.DioModule {}
