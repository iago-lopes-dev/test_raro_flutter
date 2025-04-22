import 'package:project_by_iago/src/modules/payments/data/data.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/base/constants/app_constants.dart';
import '../../../../core/base/errors/errors.dart';
import '../../domain/entity/payments_info_entity.dart';
import '../../domain/entity/payments_transactions_filter_entity.dart';

abstract class PaymentsState extends Equatable {
  final PaymentsInfoEntity paymentsInfo;
  final List<PaymentsTransactionFilterEntity> visibleTransactionFields;
  final PaymentsTabEnum selectedTabEnum;

  const PaymentsState({
    required this.paymentsInfo,
    required this.visibleTransactionFields,
    required this.selectedTabEnum,
  });

  @override
  List<Object?> get props => [
    paymentsInfo,
    visibleTransactionFields,
    selectedTabEnum,
  ];
}

class PaymentsInitialState extends PaymentsState {
  PaymentsInitialState()
      : super(
    paymentsInfo: PaymentsInfoModel.empty(),
    visibleTransactionFields: const [],
    selectedTabEnum: PaymentsTabEnum.schedule,
  );
}

class PaymentsLoadingState extends PaymentsState {
  PaymentsLoadingState()
      : super(
    paymentsInfo: PaymentsInfoModel.empty(),
    visibleTransactionFields: const [],
    selectedTabEnum: PaymentsTabEnum.schedule,
  );
}

class PaymentsSuccessState extends PaymentsState {
  const PaymentsSuccessState({
    required super.paymentsInfo,
    required super.visibleTransactionFields,
    required super.selectedTabEnum,
  });

  PaymentsSuccessState copyWith({
    PaymentsInfoEntity? paymentsInfo,
    List<PaymentsTransactionFilterEntity>? visibleTransactionFields,
    PaymentsTabEnum? selectedTabEnum,
  }) {
    return PaymentsSuccessState(
      paymentsInfo: paymentsInfo ?? this.paymentsInfo,
      visibleTransactionFields:
      visibleTransactionFields ?? this.visibleTransactionFields,
      selectedTabEnum: selectedTabEnum ?? this.selectedTabEnum,
    );
  }
}

class PaymentsErrorState extends PaymentsState {
  final InfraError? error;

  PaymentsErrorState({required this.error})
      : super(
    paymentsInfo: PaymentsInfoModel.empty(),
    visibleTransactionFields: const [],
    selectedTabEnum: PaymentsTabEnum.schedule,
  );

  String get message =>
      error?.error?.toString() ?? AppConstants.genericError001;

  @override
  List<Object?> get props => [
    error,
    paymentsInfo,
    visibleTransactionFields,
    selectedTabEnum,
  ];
}

extension PaymentsStateIndex on PaymentsState {
  bool get isScheduleSelected => selectedTabEnum == PaymentsTabEnum.schedule;

  bool get isTransactionsSelected =>
      selectedTabEnum == PaymentsTabEnum.transactions;

  int get selectedTabIndex => PaymentsTabEnum.values.indexOf(selectedTabEnum);
}

enum PaymentsTabEnum { schedule, transactions }