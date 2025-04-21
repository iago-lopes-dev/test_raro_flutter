import 'package:project_by_iago/src/core/core.dart';
import 'package:project_by_iago/src/modules/payments/data/data.dart';
import 'package:project_by_iago/src/modules/payments/domain/domain.dart';
import 'package:project_by_iago/src/modules/payments/infra/mock/mock.dart';

class PaymentsDatasourceImpl implements PaymentsDataSource {
  PaymentsDatasourceImpl();

  @override
  Future<PaymentsInfoEntity> getPaymentsInfo() async {
    try {
      final response = await Future.delayed(Duration(milliseconds: 1500)).then((_) {
        // INFO: use mockEmptyJson or mockPaymentsJson
        return mockPaymentsJson; /* mockEmptyJson */
      });
      return PaymentsInfoModel.fromJson(response);
    } catch (e) {
      throw InfraError(InfraCode.unexpected, error: e);
    }
  }
  ///TODO(Ogai): Conferir sem mock.
}
