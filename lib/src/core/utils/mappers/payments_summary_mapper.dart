import 'package:project_by_iago/src/core/utils/mappers/mapper.dart';

import '../../../modules/payments/data/model/payments/payments.dart';
import '../../../modules/payments/domain/entity/payments_summary_entity.dart';

class PaymentsSummaryMapper
    implements Mapper<PaymentsSummaryModel, PaymentsSummaryEntity> {
  @override
  PaymentsSummaryEntity toEntity(PaymentsSummaryModel model) {
    return PaymentsSummaryEntityImpl(label: model.label, value: model.value);
  }
}

class PaymentsSummaryEntityImpl extends PaymentsSummaryEntity {
  const PaymentsSummaryEntityImpl({required super.label, required super.value});
}
