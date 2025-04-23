import 'package:equatable/equatable.dart';
import 'package:project_by_iago/src/core/base/enums/payments_tab_enum.dart';
import 'package:project_by_iago/src/modules/payments/data/data.dart';
import 'package:project_by_iago/src/modules/payments/domain/domain.dart';

import '../../../../core/base/constants/app_constants.dart';
import '../../../../core/base/errors/errors.dart';

abstract class PaymentsState extends Equatable {
  final PaymentsInfoModel paymentsInfo;
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
  const PaymentsLoadingState({
    required super.paymentsInfo,
    required super.visibleTransactionFields,
    required super.selectedTabEnum,
  });
  PaymentsSuccessState copyWith({
    PaymentsInfoModel? paymentsInfo,
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

class PaymentsSuccessState extends PaymentsState {
  const PaymentsSuccessState({
    required super.paymentsInfo,
    required super.visibleTransactionFields,
    required super.selectedTabEnum,
  });

  PaymentsSuccessState copyWith({
    PaymentsInfoModel? paymentsInfo,
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

extension PaymentsStateTabIndex on PaymentsState {
  bool get isScheduleSelected => selectedTabEnum == PaymentsTabEnum.schedule;

  bool get isTransactionsSelected =>
      selectedTabEnum == PaymentsTabEnum.transactions;

  int get selectedTabIndex => PaymentsTabEnum.values.indexOf(selectedTabEnum);
}
