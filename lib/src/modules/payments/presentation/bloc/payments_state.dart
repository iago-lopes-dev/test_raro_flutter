import 'package:equatable/equatable.dart';

import '../../domain/entity/payments_info_entity.dart';
import '../../domain/entity/payments_transactions_filter_entity.dart';

abstract class PaymentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentsInitial extends PaymentsState {}

class PaymentsLoading extends PaymentsState {}

class PaymentsSuccess extends PaymentsState {
  final PaymentsInfoEntity paymentsInfo;
  final List<PaymentsTransactionFilterEntity> visibleTransactionFields;
  final int selectedTabIndex;

  PaymentsSuccess({
    required this.paymentsInfo,
    required this.visibleTransactionFields,
    this.selectedTabIndex = 0, // padrão
  });

  @override
  List<Object?> get props => [paymentsInfo, visibleTransactionFields, selectedTabIndex];

  PaymentsSuccess copyWith({
    PaymentsInfoEntity? paymentsInfo,
    List<PaymentsTransactionFilterEntity>? visibleTransactionFields,
    int? selectedTabIndex,
  }) {
    return PaymentsSuccess(
      paymentsInfo: paymentsInfo ?? this.paymentsInfo,
      visibleTransactionFields: visibleTransactionFields ?? this.visibleTransactionFields,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }
}

class PaymentsError extends PaymentsState {
  final String message;

  PaymentsError(this.message);

  @override
  List<Object?> get props => [message];
}

extension PaymentsStateX on PaymentsState {
  int get selectedTabIndex =>
      this is PaymentsSuccess ? (this as PaymentsSuccess).selectedTabIndex : 0;
}
