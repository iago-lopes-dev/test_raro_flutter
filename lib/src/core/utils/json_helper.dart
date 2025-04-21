import 'package:base_project/src/core/utils/mappers/payments_schedule_mapper.dart';
import 'package:base_project/src/core/utils/mappers/payments_summary_mapper.dart';
import 'package:base_project/src/core/utils/mappers/payments_transaction_header_mapper.dart';
import 'package:base_project/src/core/utils/mappers/payments_transaction_mapper.dart';

import '../../modules/payments/data/model/payments/payments.dart';
import '../../modules/payments/domain/entity/payments_schedule_entity.dart';
import '../../modules/payments/domain/entity/payments_summary_entity.dart';
import '../../modules/payments/domain/entity/payments_transactions_entity.dart';
import '../../modules/payments/domain/entity/payments_transactions_filter_entity.dart';
import '../../modules/payments/infra/mock/payments_json.dart';

class JsonHelper {
  static List<PaymentsSummaryEntity> getMockSummariesFromJson() {
    final List<Map<String, dynamic>> summaries =
        mockPaymentsJson["summary"] as List<Map<String, dynamic>>;
    return summaries
        .map((item) => PaymentsSummaryModel.fromJson(item))
        .map((summaryModel) => PaymentsSummaryMapper().toEntity(summaryModel))
        .toList();
  }

  static List<PaymentsScheduleEntity> getMockScheduledFromJson() {
    final List<Map<String, dynamic>> scheduled =
        mockPaymentsJson["paymentsScheduled"] as List<Map<String, dynamic>>;
    return scheduled
        .map((item) => PaymentsScheduledModel.fromJson(item))
        .map(
          (scheduledModel) => PaymentsScheduleMapper().toEntity(scheduledModel),
        )
        .toList();
  }

  static List<PaymentsTransactionsEntity> getMockTransactionsFromJson() {
    final transactions =
        mockPaymentsJson["transactions"] as List<Map<String, dynamic>>;
    return transactions
        .map((item) => PaymentsTransactionsModel.fromJson(item))
        .map(
          (transactionModel) =>
              PaymentsTransactionMapper().toEntity(transactionModel),
        )
        .toList();
  }

  static List<PaymentsTransactionFilterEntity>
  getMockTransactionFiltersFromJson() {
    final List<Map<String, dynamic>> transactionsFilters =
        mockPaymentsJson["transactionFilters"] as List<Map<String, dynamic>>;
    return transactionsFilters
        .map((item) => PaymentsTransactionHeadersModel.fromJson(item))
        .map(
          (transactionModel) =>
              PaymentsTransactionHeaderMapper().toEntity(transactionModel),
        )
        .toList();
  }
}
