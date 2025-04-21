import 'package:equatable/equatable.dart';

import '../../domain/entity/payments_transactions_filter_entity.dart';

abstract class PaymentsRefreshedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPaymentsEvent extends PaymentsRefreshedEvent {}

class RefreshPaymentsEvent extends PaymentsRefreshedEvent {}

class UpdateVisibleTransactionFieldsEvent extends PaymentsRefreshedEvent {
  final List<PaymentsTransactionFilterEntity> visibleFields;

  UpdateVisibleTransactionFieldsEvent(this.visibleFields);

  @override
  List<Object?> get props => [visibleFields];
}
