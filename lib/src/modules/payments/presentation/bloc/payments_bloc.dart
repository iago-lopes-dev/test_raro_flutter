import 'package:base_project/src/modules/payments/presentation/bloc/change_tab_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/payments_transactions_filter_entity.dart';
import '../../domain/usecase/get_payments_use_case.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final GetPaymentsUseCase useCase;

  PaymentsBloc(this.useCase) : super(PaymentsInitial()) {
    on<FetchPaymentsEvent>(_onLoadPayments);
    on<RefreshPaymentsEvent>(_onLoadPayments);
    on<UpdateVisibleTransactionFieldsEvent>(_onUpdateVisibleFields);
    on<ChangeTabEvent>(_onChangeTab);
  }

  late List<PaymentsTransactionFilterEntity> _visibleTransactionFields;

  Future<void> _onLoadPayments(
    PaymentsEvent event,
    Emitter<PaymentsState> emit,
  ) async {
    emit(PaymentsLoading());
    final result = await useCase();
    result.fold((failure) => emit(PaymentsError(failure.message)), (
      paymentsInfo,
    ) {
      _visibleTransactionFields =
          paymentsInfo.transactionFilter.where((e) => e.isDefault).toList();
      emit(
        PaymentsSuccess(
          paymentsInfo: paymentsInfo,
          visibleTransactionFields: _visibleTransactionFields,
        ),
      );
    });
  }

  Future<void> _onUpdateVisibleFields(
    UpdateVisibleTransactionFieldsEvent event,
    Emitter<PaymentsState> emit,
  ) async {
    final currentState = state;
    if (currentState is PaymentsSuccess) {
      _visibleTransactionFields = event.visibleFields;

      emit(
        PaymentsSuccess(
          paymentsInfo: currentState.paymentsInfo,
          visibleTransactionFields: _visibleTransactionFields,
        ),
      );
    }
  }

  Future<void> _onChangeTab(
    ChangeTabEvent event,
    Emitter<PaymentsState> emit,
  ) async {
    final currentState = state;
    if (currentState is PaymentsSuccess) {
      emit(currentState.copyWith(selectedTabIndex: event.tabIndex));
    }
  }
}
