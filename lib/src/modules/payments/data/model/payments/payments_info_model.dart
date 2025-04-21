import 'package:project_by_iago/src/modules/payments/data/data.dart';
import 'package:project_by_iago/src/modules/payments/domain/domain.dart';

class PaymentsInfoModel extends PaymentsInfoEntity {
  PaymentsInfoModel.fromJson(Map<String, dynamic> json)
    : super(
        paymentsScheduled:
            json['paymentsScheduled'] != null
                ? json['paymentsScheduled']
                    .map<PaymentsScheduleEntity>((json) => PaymentsScheduledModel.fromJson(json))
                    .toList()
                : [],
        transactionFilter:
            json['transactionFilters'] != null
                ? json['transactionFilters']
                    .map<PaymentsTransactionFilterEntity>((json) => PaymentsTransactionHeadersModel.fromJson(json))
                    .toList()
                : [],
        transactions:
            json['transactions'] != null
                ? json['transactions']
                    .map<PaymentsTransactionsEntity>((json) => PaymentsTransactionsModel.fromJson(json))
                    .toList()
                : [],
        summary:
            json['summary'] != null
                ? json['summary'].map<PaymentsSummaryEntity>((json) => PaymentsSummaryModel.fromJson(json)).toList()
                : [],
      );
  PaymentsInfoModel.empty() : this.fromJson({});
}
