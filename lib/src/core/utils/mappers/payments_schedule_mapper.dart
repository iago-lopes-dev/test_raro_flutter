import 'package:project_by_iago/src/core/utils/mappers/mapper.dart';

import '../../../modules/payments/data/model/payments/payments.dart';
import '../../../modules/payments/domain/entity/entity.dart';

class PaymentsScheduleMapper
    implements Mapper<PaymentsScheduledModel, PaymentsScheduleEntity> {
  @override
  PaymentsScheduleEntity toEntity(PaymentsScheduledModel model) {
    return PaymentsScheduleEntityImpl(
      paymentDate: model.paymentDate,
      paymentDateFormatted: model.paymentDateFormatted,
      principal: model.principal,
      interest: model.interest,
      total: model.total,
      outstandingBalance: model.outstandingBalance,
      pastDue: model.pastDue,
      status: model.status,
      paymentType: model.paymentType,
    );
  }
}

class PaymentsScheduleEntityImpl extends PaymentsScheduleEntity {
  const PaymentsScheduleEntityImpl({
    required super.paymentDate,
    required super.paymentDateFormatted,
    required super.principal,
    required super.interest,
    required super.total,
    required super.outstandingBalance,
    required super.pastDue,
    required super.status,
    required super.paymentType,
  });
}
