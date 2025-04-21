import 'package:project_by_iago/src/modules/payments/domain/entity/payments_info_entity.dart';
import '../../infra/mock/mock.dart';
import '../model/payments/payments.dart';
import 'payments_datasource.dart';

class PaymentsDataSourceImpl implements PaymentsDataSource {
  PaymentsDataSourceImpl();

  @override
  Future<PaymentsInfoEntity> getPaymentsInfo() async {
    return PaymentsInfoModel.fromJson(mockPaymentsJson);
  }
  ///TODO(Ogai): Conferir sem mock.
}
