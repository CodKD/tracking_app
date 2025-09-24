import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/models/request/auth/apply_request.dart';
import 'package:tracking_app/features/auth/apply/domain/entities/apply_entity.dart';
import 'package:tracking_app/features/auth/apply/domain/usecases/apply_use_case.dart';
import 'driver_apply_state.dart';

class DriverApplyCubit extends Cubit<DriverApplyState> {
  final ApplyUseCase applyUseCase;

  DriverApplyCubit(this.applyUseCase) : super(DriverApplyInitial());

  Future<void> submit(ApplyRequest request) async {
    emit(DriverApplyLoading());

    final result = await applyUseCase(request);

    if (result is ApiSuccessResult<DriverEntity>) {
      emit(DriverApplySuccess());
    } else if (result is ApiErrorResult<DriverEntity>) {
      emit(DriverApplyError(result.errorMessage));
    } else {
      emit(DriverApplyError("Unexpected error"));
    }
  }
}
