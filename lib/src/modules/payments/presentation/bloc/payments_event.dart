import 'package:equatable/equatable.dart';
import 'package:project_by_iago/src/modules/payments/domain/domain.dart';

abstract class PaymentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPaymentsEvent extends PaymentsEvent {}

class RefreshPaymentsEvent extends PaymentsEvent {}

class UpdateVisibleTransactionFieldsEvent extends PaymentsEvent {
  final List<PaymentsTransactionFilterEntity> visibleFields;

  UpdateVisibleTransactionFieldsEvent(this.visibleFields);

  @override
  List<Object?> get props => [visibleFields];
}
