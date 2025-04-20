import 'package:equatable/equatable.dart';

abstract class PaymentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPaymentsEvent extends PaymentsEvent {}

class RefreshPaymentsEvent extends PaymentsEvent {}

class UpdateVisibleTransactionFieldsEvent extends PaymentsEvent {
  final List<String> visibleFields;

  UpdateVisibleTransactionFieldsEvent(this.visibleFields);

  @override
  List<Object?> get props => [visibleFields];
}
