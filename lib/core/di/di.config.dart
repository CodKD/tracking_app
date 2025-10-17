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
import '../../features/order_details/data/data_sources/start_order_data_sources_repo.dart'
    as _i910;
import '../../features/order_details/data/data_sources/start_order_data_sources_repo_impl.dart'
    as _i296;
import '../../features/order_details/data/repo/start_order_repo_impl.dart'
    as _i1032;
import '../../features/order_details/domain/repo/start_order_repo.dart'
    as _i750;
import '../../features/order_details/domain/use_cases/start_order_usecase.dart'
    as _i1044;
import '../../features/order_details/presentation/view_model/start_order_cubit.dart'
    as _i330;
import '../../features/orders/data/data_sources/my_orders_online_data_source.dart'
    as _i131;
import '../../features/orders/data/data_sources/my_orders_online_data_source_impl.dart'
    as _i291;
import '../../features/orders/data/repositories/my_orders_repo_impl.dart'
    as _i917;
import '../../features/orders/domain/repositories/my_orders_repo.dart' as _i456;
import '../../features/orders/domain/use_cases/my_orders_use_case.dart'
    as _i1055;
import '../../features/orders/presentation/manager/my_orders_view_model.dart'
    as _i29;
import '../../features/profile/data/data_source/change_password_remote_data_source.dart'
    as _i970;
import '../../features/profile/data/data_source/get_all_vehicles_data_source.dart'
    as _i954;
import '../../features/profile/data/data_source/get_logged_driver_data_source.dart'
    as _i1052;
import '../../features/profile/data/data_source/update_driver_profile_data_source.dart'
    as _i62;
import '../../features/profile/data/data_source/update_vehical_info_data_source.dart'
    as _i1057;
import '../../features/profile/data/repositories/change_password_repo_impl.dart'
    as _i691;
import '../../features/profile/data/repositories/get_all_vehicles_repo_impl.dart'
    as _i207;
import '../../features/profile/data/repositories/get_logged_driver_data_repo_impl.dart'
    as _i430;
import '../../features/profile/data/repositories/update_profile_repo_impl.dart'
    as _i249;
import '../../features/profile/data/repositories/update_vehical_repo_impl.dart'
    as _i803;
import '../../features/profile/domain/repositories/change_password_repo.dart'
    as _i200;
import '../../features/profile/domain/repositories/get_all_vehicles_repo.dart'
    as _i274;
import '../../features/profile/domain/repositories/get_logged_driver_data_repo.dart'
    as _i201;
import '../../features/profile/domain/repositories/update_profile_repo.dart'
    as _i234;
import '../../features/profile/domain/repositories/update_vehical_repo.dart'
    as _i837;
import '../../features/profile/domain/usecases/change_password_use_case.dart'
    as _i590;
import '../../features/profile/domain/usecases/get_all_vehicles_use_case.dart'
    as _i473;
import '../../features/profile/domain/usecases/get_logged_driver_data_use_case.dart'
    as _i228;
import '../../features/profile/domain/usecases/update_driver_photo_use_case.dart'
    as _i345;
import '../../features/profile/domain/usecases/update_driver_profile_use_case.dart'
    as _i662;
import '../../features/profile/domain/usecases/update_vehical_use_case.dart'
    as _i86;
import '../../features/profile/presentation/view_model/cubit.dart' as _i1017;
import '../../features/profile/presentation/view_model/reset/reset_cubit.dart'
    as _i698;
import '../api_layer/api_client/api_client.dart' as _i225;
import '../api_layer/data_source_impl/auth/apply_data_source_impl.dart'
    as _i942;
import '../api_layer/data_source_impl/auth/forget_password_remote_data_source_impl.dart'
    as _i594;
import '../api_layer/data_source_impl/auth/login_remote_data_source_impl.dart'
    as _i640;
import '../api_layer/data_source_impl/profile/change_password_remote_data_source_impl.dart'
    as _i881;
import '../api_layer/data_source_impl/profile/get_all_vehicles_data_source_impl.dart'
    as _i558;
import '../api_layer/data_source_impl/profile/get_logged_driver_data_source_impl.dart'
    as _i81;
import '../api_layer/data_source_impl/profile/update_driver_profile_data_source_impl.dart'
    as _i933;
import '../api_layer/data_source_impl/profile/update_vehical_info_data_source_impl.dart'
    as _i1046;
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
    gh.factory<_i970.ChangePasswordRemoteDataSource>(
      () => _i881.ChangePasswordRemoteDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i1057.UpdateVehicalInfoDataSource>(
      () => _i1046.UpdateVehicalInfoDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i62.UpdateDriverProfileDataSource>(
      () => _i933.UpdateDriverProfileDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i166.ApplyDataSource>(
      () => _i942.ApplyDataSourceImpl(
        gh<_i225.ApiClient>(),
        gh<_i744.SharedPrefHelper>(),
      ),
    );
    gh.factory<_i1052.GetLoggedDriverDataSource>(
      () => _i81.GetLoggedDriverDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i526.HomeTabCubit>(
      () => _i526.HomeTabCubit(gh<_i226.GetPendingOrdersUseCase>()),
    );
    gh.factory<_i924.ForgetPasswordRepo>(
      () => _i206.ForgetPasswordRepoImpl(
        gh<_i370.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i910.OrderDetailsDataSourcesRepo>(
      () => _i296.StartOrderDataSourcesRepoImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i131.MyOrdersOnlineDataSource>(
      () => _i291.MyOrdersOnlineDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i234.UpdateProfileRepo>(
      () =>
          _i249.UpdateProfileRepoImpl(gh<_i62.UpdateDriverProfileDataSource>()),
    );
    gh.factory<_i1049.LoginRemoteDataSource>(
      () => _i640.LoginRemoteDataSourceImpl(gh<_i225.ApiClient>()),
    );
    gh.factory<_i1059.ApplyRepository>(
      () => _i565.ApplyRepoImpl(gh<_i166.ApplyDataSource>()),
    );
    gh.factory<_i954.GetAllVehiclesDataSource>(
      () =>
          _i558.GetAllVehiclesDataSourceImpl(apiClient: gh<_i225.ApiClient>()),
    );
    gh.factory<_i983.LoginRepo>(
      () => _i1013.LoginRepoImpl(gh<_i1049.LoginRemoteDataSource>()),
    );
    gh.factory<_i274.GetAllVehiclesRepo>(
      () => _i207.GetAllVehiclesRepoImpl(
        getAllVehiclesDataSource: gh<_i954.GetAllVehiclesDataSource>(),
      ),
    );
    gh.factory<_i837.UpdateVehicalRepo>(
      () =>
          _i803.UpdateVehicalRepoImpl(gh<_i1057.UpdateVehicalInfoDataSource>()),
    );
    gh.factory<_i201.GetLoggedDriverDataRepo>(
      () => _i430.GetLoggedDriverDataRepoImpl(
        gh<_i1052.GetLoggedDriverDataSource>(),
      ),
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
    gh.factory<_i456.MyOrdersRepo>(
      () => _i917.MyOrdersRepoImpl(gh<_i131.MyOrdersOnlineDataSource>()),
    );
    gh.factory<_i1055.MyOrdersUseCase>(
      () => _i1055.MyOrdersUseCase(gh<_i456.MyOrdersRepo>()),
    );
    gh.factory<_i50.LoginUseCase>(
      () => _i50.LoginUseCase(gh<_i983.LoginRepo>()),
    );
    gh.factory<_i29.MyOrdersViewModel>(
      () => _i29.MyOrdersViewModel(gh<_i1055.MyOrdersUseCase>()),
    );
    gh.factory<_i86.UpdateVehicalUseCase>(
      () => _i86.UpdateVehicalUseCase(gh<_i837.UpdateVehicalRepo>()),
    );
    gh.factory<_i200.ChangPasswordRepo>(
      () => _i691.ChangPasswordRepoImpl(
        gh<_i970.ChangePasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i228.GetLoggedDriverDataUseCase>(
      () =>
          _i228.GetLoggedDriverDataUseCase(gh<_i201.GetLoggedDriverDataRepo>()),
    );
    gh.factory<_i750.OrderDetailsRepo>(
      () => _i1032.StarOrderRepoImpl(gh<_i910.OrderDetailsDataSourcesRepo>()),
    );
    gh.factory<_i1055.ApplyUseCase>(
      () => _i1055.ApplyUseCase(gh<_i1059.ApplyRepository>()),
    );
    gh.factory<_i345.UpdateDriverPhotoUseCase>(
      () => _i345.UpdateDriverPhotoUseCase(gh<_i234.UpdateProfileRepo>()),
    );
    gh.factory<_i662.UpdateDriverProfileUseCase>(
      () => _i662.UpdateDriverProfileUseCase(gh<_i234.UpdateProfileRepo>()),
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
    gh.factory<_i590.ChangePasswordUseCase>(
      () => _i590.ChangePasswordUseCase(gh<_i200.ChangPasswordRepo>()),
    );
    gh.factory<_i473.GetAllVehiclesUseCase>(
      () => _i473.GetAllVehiclesUseCase(
        getAllVehiclesRepo: gh<_i274.GetAllVehiclesRepo>(),
      ),
    );
    gh.factory<_i1044.StartOrderUseCase>(
      () => _i1044.StartOrderUseCase(gh<_i750.OrderDetailsRepo>()),
    );
    gh.factory<_i330.StartOrderCubit>(
      () => _i330.StartOrderCubit(gh<_i1044.StartOrderUseCase>()),
    );
    gh.factory<_i698.ResetPasswordCubit>(
      () => _i698.ResetPasswordCubit(gh<_i590.ChangePasswordUseCase>()),
    );
    gh.factory<_i310.DriverApplyCubit>(
      () => _i310.DriverApplyCubit(gh<_i1055.ApplyUseCase>()),
    );
    gh.factory<_i1017.ProfileCubit>(
      () => _i1017.ProfileCubit(
        gh<_i228.GetLoggedDriverDataUseCase>(),
        gh<_i86.UpdateVehicalUseCase>(),
        gh<_i345.UpdateDriverPhotoUseCase>(),
        gh<_i662.UpdateDriverProfileUseCase>(),
        gh<_i473.GetAllVehiclesUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i948.DioModule {}

class _$SharedPreferencesModule extends _i744.SharedPreferencesModule {}
