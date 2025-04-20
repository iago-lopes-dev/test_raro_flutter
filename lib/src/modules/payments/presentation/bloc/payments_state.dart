import 'package:equatable/equatable.dart';

import '../../domain/entity/payments_info_entity.dart';

abstract class PaymentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentsInitial extends PaymentsState {}

class PaymentsLoading extends PaymentsState {}

class PaymentsSuccess extends PaymentsState {
  final PaymentsInfoEntity paymentsInfo;
  final List<String> visibleTransactionFields;

  PaymentsSuccess({
    required this.paymentsInfo,
    required this.visibleTransactionFields,
  });

  @override
  List<Object?> get props => [paymentsInfo, visibleTransactionFields];
}

class PaymentsError extends PaymentsState {
  final String message;

  PaymentsError(this.message);

  @override
  List<Object?> get props => [message];
}
