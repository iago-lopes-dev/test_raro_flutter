import '../../../modules/payments/data/model/payments/payments.dart';
import '../../../modules/payments/domain/entity/payments_transactions_entity.dart';

class PaymentsTransactionMapper {
  PaymentsTransactionsModel fromEntity(PaymentsTransactionsEntity entity) {
    return PaymentsTransactionsModel(
      key: entity.key,
      actualPaymentPostDate: entity.actualPaymentPostDate,
      processDate: entity.processDate,
      actualPaymentAmount: entity.actualPaymentAmount,
      actualPrincipalPaymentAmount: entity.actualPrincipalPaymentAmount,
      actualInterestPaymentAmount: entity.actualInterestPaymentAmount,
      outstandingPrincipalBalance: entity.outstandingPrincipalBalance,
      outstandingLoanBalance: entity.outstandingLoanBalance,
      actualFee: entity.actualFee,
      paymentType: entity.paymentType,
    );
  }

  List<PaymentsTransactionsModel> fromEntityList(
    List<PaymentsTransactionsEntity> list,
  ) {
    return list.map(fromEntity).toList();
  }
}
