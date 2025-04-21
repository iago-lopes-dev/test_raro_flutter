import 'package:project_by_iago/src/core/utils/mappers/mapper.dart';

import '../../../modules/payments/data/model/payments/payments.dart';
import '../../../modules/payments/domain/entity/payments_transactions_filter_entity.dart';

class PaymentsTransactionHeaderMapper
    implements
        Mapper<
          PaymentsTransactionHeadersModel,
          PaymentsTransactionFilterEntity
        > {
  @override
  PaymentsTransactionFilterEntity toEntity(
    PaymentsTransactionHeadersModel model,
  ) {
    return PaymentsTransactionFilterEntityImpl(
      key: model.key,
      label: model.label,
      isDefault: model.isDefault,
    );
  }
}

class PaymentsTransactionFilterEntityImpl
    extends PaymentsTransactionFilterEntity {
  const PaymentsTransactionFilterEntityImpl({
    required super.key,
    required super.label,
    required super.isDefault,
  });
}
