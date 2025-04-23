import '../../../modules/payments/data/model/payments/payments.dart';
import '../../../modules/payments/infra/mock/payments_json.dart';

class JsonHelper {
  static List<PaymentsSummaryModel> getMockSummariesFromJson() {
    final List<Map<String, dynamic>> summaries =
        mockPaymentsJson["summary"] as List<Map<String, dynamic>>;
    return summaries
        .map((item) => PaymentsSummaryModel.fromJson(item))
        .toList();
  }

  static List<PaymentsScheduledModel> getMockScheduledFromJson() {
    final List<Map<String, dynamic>> scheduled =
        mockPaymentsJson["paymentsScheduled"] as List<Map<String, dynamic>>;
    return scheduled
        .map((item) => PaymentsScheduledModel.fromJson(item))
        .toList();
  }

  static List<PaymentsTransactionsModel> getMockTransactionsFromJson() {
    final transactions =
        mockPaymentsJson["transactions"] as List<Map<String, dynamic>>;
    return transactions
        .map((item) => PaymentsTransactionsModel.fromJson(item))
        .toList();
  }

  static List<PaymentsTransactionHeadersModel>
  getMockTransactionFiltersFromJson() {
    final List<Map<String, dynamic>> transactionsFilters =
        mockPaymentsJson["transactionFilters"] as List<Map<String, dynamic>>;
    return transactionsFilters
        .map((item) => PaymentsTransactionHeadersModel.fromJson(item))
        .toList();
  }
}
