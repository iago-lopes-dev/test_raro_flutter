import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_by_iago/src/core/base/enums/payments_tab_enum.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_event.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_tab_changed_event.dart';

import '../../../../core/base/errors/errors.dart';
import '../../../../core/base/interfaces/interfaces.dart';
import '../../data/model/model.dart';
import '../../domain/entity/entity.dart';
import '../../domain/usecase/get_payments_use_case.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final GetPaymentsUseCase useCase;

  PaymentsBloc(this.useCase) : super(PaymentsInitialState()) {
    on<FetchPaymentsEvent>(_onLoadPayments);
    on<RefreshPaymentsEvent>(_onLoadPayments);
    on<UpdateVisibleTransactionFieldsEvent>(_onUpdateVisibleFields);
    on<PaymentsTabChangedEvent>(_onChangeTab);
  }

  late List<PaymentsTransactionHeadersModel> _visibleTransactionFields;

  Future<void> _onLoadPayments(
    PaymentsEvent event,
    Emitter<PaymentsState> emit,
  ) async {
    emit(PaymentsLoadingState());
    await Future.delayed(Duration(seconds: 2));
    final Either<Failure, PaymentsInfoEntity> result = await useCase(
      NoParams(),
    );

    result.fold(
      (failure) => emit(
        PaymentsErrorState(
          error: InfraError(InfraCode.unexpected, error: failure),
        ),
      ),
      (paymentsInfoEntity) {
        _visibleTransactionFields =
            paymentsInfoEntity.transactionFilter
                .where((e) => e.isDefault)
                .toList()
                .map(
                  (e) => PaymentsTransactionHeadersModel(
                    key: e.key,
                    label: e.label,
                    isDefault: e.isDefault,
                  ),
                )
                .toList();

        final PaymentsTabEnum selectedTab =
            state is PaymentsSuccessState
                ? state.selectedTabEnum
                : PaymentsTabEnum.schedule;

        final PaymentsInfoModel paymentsInfo =
            paymentsInfoEntity as PaymentsInfoModel;

        /// TODO(Ogai): Conferir o estado de refresh voltando para schedule
        emit(
          PaymentsSuccessState(
            paymentsInfo: paymentsInfo,
            visibleTransactionFields: _visibleTransactionFields,
            selectedTabEnum: selectedTab,
          ),
        );
      },
    );
  }

  Future<void> _onUpdateVisibleFields(
    UpdateVisibleTransactionFieldsEvent event,
    Emitter<PaymentsState> emit,
  ) async {
    final PaymentsState currentState = state;
    if (currentState is PaymentsSuccessState) {
      _visibleTransactionFields = event.visibleFields;
      emit(
        currentState.copyWith(
          paymentsInfo: currentState.paymentsInfo,
          visibleTransactionFields: _visibleTransactionFields,
          selectedTabEnum: currentState.selectedTabEnum,
        ),
      );
    }
  }

  Future<void> _onChangeTab(
    PaymentsTabChangedEvent event,
    Emitter<PaymentsState> emit,
  ) async {
    final currentState = state;
    if (currentState is PaymentsSuccessState) {
      emit(currentState.copyWith(selectedTabEnum: event.selectedTab));
    }
  }
}
