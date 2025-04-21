import 'package:base_project/src/core/utils/mappers/mapper.dart';

import '../../../modules/payments/data/model/payments/payments.dart';
import '../../../modules/payments/domain/entity/payments_transactions_entity.dart';

class PaymentsTransactionMapper
    implements Mapper<PaymentsTransactionsModel, PaymentsTransactionsEntity> {
  @override
  PaymentsTransactionsEntity toEntity(PaymentsTransactionsModel model) {
    return PaymentsTransactionsEntityImpl(
      key: model.key,
      actualPaymentPostDate: model.actualPaymentPostDate,
      processDate: model.processDate,
      actualPaymentAmount: model.actualPaymentAmount,
      actualPrincipalPaymentAmount: model.actualPrincipalPaymentAmount,
      actualInterestPaymentAmount: model.actualInterestPaymentAmount,
      outstandingPrincipalBalance: model.outstandingPrincipalBalance,
      outstandingLoanBalance: model.outstandingLoanBalance,
      actualFee: model.actualFee,
      paymentType: model.paymentType,
    );
  }
}

class PaymentsTransactionsEntityImpl extends PaymentsTransactionsEntity {
  const PaymentsTransactionsEntityImpl({
    required super.key,
    required super.actualPaymentPostDate,
    required super.processDate,
    required super.actualPaymentAmount,
    required super.actualPrincipalPaymentAmount,
    required super.actualInterestPaymentAmount,
    required super.outstandingPrincipalBalance,
    required super.outstandingLoanBalance,
    required super.actualFee,
    required super.paymentType,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'actualPaymentPostDate': actualPaymentPostDate.toIso8601String(),
      'processDate': processDate.toIso8601String(),
      'actualPaymentAmount': actualPaymentAmount,
      'actualPrincipalPaymentAmount': actualPrincipalPaymentAmount,
      'actualInterestPaymentAmount': actualInterestPaymentAmount,
      'outstandingPrincipalBalance': outstandingPrincipalBalance,
      'outstandingLoanBalance': outstandingLoanBalance,
      'actualFee': actualFee,
      'paymentType': paymentType,
    };
  }
}
