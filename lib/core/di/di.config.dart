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

import '../../features/auth/apply/data/data_source/apply_data_source.dart'
    as _i359;
import '../../features/auth/apply/data/repositories/apply_repo_impl.dart'
    as _i565;
import '../../features/auth/apply/domain/repositories/apply_repository.dart'
    as _i1059;
import '../../features/auth/apply/domain/usecases/apply_use_case.dart'
    as _i1055;
import '../api_layer/api_client/api_client.dart' as _i225;
import '../api_layer/data_source/auth/apply_data_source_impl.dart' as _i196;
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
    gh.factory<_i359.ApplyDataSource>(
      () => _i196.ApplyDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i1059.ApplyRepository>(
      () => _i565.ApplyRepoImpl(gh<_i359.ApplyDataSource>()),
    );
    gh.factory<_i1055.ApplyUseCase>(
      () => _i1055.ApplyUseCase(gh<_i1059.ApplyRepository>()),
    );
    return this;
  }
}

class _$DioModule extends _i983.DioModule {}
