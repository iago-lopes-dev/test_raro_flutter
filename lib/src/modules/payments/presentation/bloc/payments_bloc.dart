import 'package:base_project/src/modules/payments/presentation/bloc/payments_tab_changed_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_refreshed_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/interfaces/interfaces.dart';
import '../../data/model/payments/payments.dart';
import '../../domain/entity/payments_info_entity.dart';
import '../../domain/entity/payments_transactions_filter_entity.dart';
import '../../domain/usecase/get_payments_use_case.dart';

class PaymentsBloc extends Bloc<PaymentsRefreshedEvent, PaymentsState> {
  final GetPaymentsUseCase useCase;

  PaymentsBloc(this.useCase) : super(PaymentsInitialState()) {
    on<FetchPaymentsEvent>(_onLoadPayments);
    on<RefreshPaymentsEvent>(_onLoadPayments);
    on<UpdateVisibleTransactionFieldsEvent>(_onUpdateVisibleFields);
    on<PaymentsTabChangedEvent>(_onChangeTab);
  }

  late List<PaymentsTransactionFilterEntity> _visibleTransactionFields;

  Future<void> _onLoadPayments(
    PaymentsRefreshedEvent event,
    Emitter<PaymentsState> emit,
  ) async {
    emit(
      PaymentsLoadingState(
        paymentsInfo: PaymentsInfoModel.empty(),
        visibleTransactionFields: const [],
        selectedTabEnum: PaymentsTabEnum.schedule,
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    final Either<Failure, PaymentsInfoEntity> result = await useCase();
    result.fold(
      (failure) => emit(
        PaymentsErrorState(
          message: failure.message,
          selectedTabEnum: PaymentsTabEnum.schedule,
        ),
      ),
      (paymentsInfo) {
        _visibleTransactionFields =
            paymentsInfo.transactionFilter.where((e) => e.isDefault).toList();
        emit(
          PaymentsSuccessState(
            paymentsInfo: paymentsInfo,
            visibleTransactionFields: _visibleTransactionFields,
            selectedTabEnum: PaymentsTabEnum.schedule,
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
