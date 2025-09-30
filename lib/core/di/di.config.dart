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

import '../../features/auth/apply/data/data_source/contract/apply_data_source.dart'
    as _i166;
import '../../features/auth/apply/data/repositories/apply_repo_impl.dart'
    as _i565;
import '../../features/auth/apply/domain/repositories/apply_repository.dart'
    as _i1059;
import '../../features/auth/apply/domain/usecases/apply_use_case.dart'
    as _i1055;
import '../../features/auth/apply/presentation/cubit/driver_apply_cubit.dart'
    as _i310;
import '../../features/auth/forget_password/data/datasources/contracts/forget_password_remote_data_source.dart'
    as _i370;
import '../../features/auth/forget_password/data/repos_impl/forget_password_repo_impl.dart'
    as _i206;
import '../../features/auth/forget_password/domain/repositories/forget_password_repo.dart'
    as _i924;
import '../../features/auth/forget_password/domain/usecases/forget_password_use_case.dart'
    as _i737;
import '../../features/auth/forget_password/domain/usecases/reset_password_use_case.dart'
    as _i374;
import '../../features/auth/forget_password/domain/usecases/varify_reset_code_use_case.dart'
    as _i176;
import '../../features/auth/forget_password/presentation/cubit/forget_password_cubit.dart'
    as _i231;
import '../../features/auth/login/data/data_source/contract/login_remote_data_scource.dart'
    as _i1049;
import '../../features/auth/login/data/repos_impl/login_repo_impl.dart'
    as _i1013;
import '../../features/auth/login/domain/repos/login_repo.dart' as _i983;
import '../../features/auth/login/domain/use_cases/login_use_case.dart' as _i50;
import '../../features/auth/login/presentation/cubit/login_view_model.dart'
    as _i465;
import '../../features/home/presentation/Tabs/home_tab/data/datasources/get_panding_orders_data_source_impl.dart'
    as _i898;
import '../../features/home/presentation/Tabs/home_tab/data/datasources/get_pending_orders_data_source.dart'
    as _i643;
import '../../features/home/presentation/Tabs/home_tab/data/repos_impl.dart/get_pending_repo_impl.dart'
    as _i914;
import '../../features/home/presentation/Tabs/home_tab/domain/repositories/get_pending_orders_repo.dart'
    as _i1029;
import '../../features/home/presentation/Tabs/home_tab/domain/usecases/get_pending_use_case.dart'
    as _i226;
import '../../features/home/presentation/Tabs/home_tab/presentation/cubit/home_tab_cubit.dart'
    as _i526;
import '../api_layer/api_client/api_client.dart' as _i225;
import '../api_layer/data_source_impl/auth/apply_data_source_impl.dart'
    as _i942;
import '../api_layer/data_source_impl/auth/forget_password_remote_data_source_impl.dart'
    as _i594;
import '../api_layer/data_source_impl/auth/login_remote_data_source_impl.dart'
    as _i640;
import '../api_layer/firebase/firestore_manager.dart' as _i787;
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
    gh.factory<_i787.FirebaseManager>(() => _i787.FirebaseManager());
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
    gh.factory<_i643.GetPendingOrdersDataSource>(
      () => _i898.GetPendingOrdersDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i1029.GetPendingOrdersRepo>(
      () => _i914.GetPendingOrdersRepoImpl(
        gh<_i643.GetPendingOrdersDataSource>(),
      ),
    );
    gh.factory<_i226.GetPendingOrdersUseCase>(
      () => _i226.GetPendingOrdersUseCase(gh<_i1029.GetPendingOrdersRepo>()),
    );
    gh.factory<_i370.ForgetPasswordRemoteDataSource>(
      () => _i594.ForgetPasswordRemoteDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i166.ApplyDataSource>(
      () => _i942.ApplyDataSourceImpl(
        gh<_i225.ApiClient>(),
        gh<_i744.SharedPrefHelper>(),
      ),
    );
    gh.factory<_i526.HomeTabCubit>(
      () => _i526.HomeTabCubit(gh<_i226.GetPendingOrdersUseCase>()),
    );
    gh.factory<_i924.ForgetPasswordRepo>(
      () => _i206.ForgetPasswordRepoImpl(
        gh<_i370.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i1049.LoginRemoteDataSource>(
      () => _i640.LoginRemoteDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i1059.ApplyRepository>(
      () => _i565.ApplyRepoImpl(gh<_i166.ApplyDataSource>()),
    );
    gh.factory<_i983.LoginRepo>(
      () => _i1013.LoginRepoImpl(gh<_i1049.LoginRemoteDataSource>()),
    );
    gh.factory<_i737.ForgetPasswordUseCase>(
      () => _i737.ForgetPasswordUseCase(gh<_i924.ForgetPasswordRepo>()),
    );
    gh.factory<_i374.ResetPasswordUseCase>(
      () => _i374.ResetPasswordUseCase(gh<_i924.ForgetPasswordRepo>()),
    );
    gh.factory<_i176.VerifyResetCodeUseCase>(
      () => _i176.VerifyResetCodeUseCase(gh<_i924.ForgetPasswordRepo>()),
    );
    gh.factory<_i50.LoginUseCase>(
      () => _i50.LoginUseCase(gh<_i983.LoginRepo>()),
    );
    gh.factory<_i1055.ApplyUseCase>(
      () => _i1055.ApplyUseCase(gh<_i1059.ApplyRepository>()),
    );
    gh.factory<_i231.ForgetPasswordViewModel>(
      () => _i231.ForgetPasswordViewModel(
        forgetPasswordUseCase: gh<_i737.ForgetPasswordUseCase>(),
        verifyResetCodeUseCase: gh<_i176.VerifyResetCodeUseCase>(),
        resetPasswordUseCase: gh<_i374.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i465.LoginViewModel>(
      () => _i465.LoginViewModel(
        loginUseCase: gh<_i50.LoginUseCase>(),
        sharedPrefHelper: gh<_i744.SharedPrefHelper>(),
      ),
    );
    gh.factory<_i310.DriverApplyCubit>(
      () => _i310.DriverApplyCubit(gh<_i1055.ApplyUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i948.DioModule {}

class _$SharedPreferencesModule extends _i744.SharedPreferencesModule {}
