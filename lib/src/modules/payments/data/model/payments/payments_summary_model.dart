import 'package:project_by_iago/src/core/core.dart';
import 'package:project_by_iago/src/modules/payments/domain/domain.dart';

class PaymentsSummaryModel extends PaymentsSummaryEntity {
  const PaymentsSummaryModel({required super.label, required super.value});

  factory PaymentsSummaryModel.fromJson(Map<String, dynamic> map) {
    return PaymentsSummaryModel(label: map["label"] ?? "", value: ConverterHelper.dynamicToDouble(map['value'] ?? 0.0));
  }
}
