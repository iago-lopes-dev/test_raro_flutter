import '../../modules/payments/data/model/payments/payments.dart';
import '../../modules/payments/domain/entity/payments_summary_entity.dart';
import '../../modules/payments/infra/mock/payments_json.dart';

class JsonHelper {
  static List<PaymentsSummaryEntity> getMockSummariesFromJson() {
    final summaryList =
        mockPaymentsJson['summary'] as List<Map<String, dynamic>>;
    return summaryList.map((item) {
      return PaymentsSummaryModel.fromJson(item);
    }).toList();
  }
}
