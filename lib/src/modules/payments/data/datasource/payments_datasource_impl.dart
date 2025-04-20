import 'package:base_project/src/modules/payments/domain/entity/payments_info_entity.dart';
import '../../infra/mock/mock.dart';
import '../model/payments/payments.dart';
import 'payments_datasource.dart';

class PaymentsDataSourceImpl implements PaymentsDataSource {
  PaymentsDataSourceImpl();

  @override
  Future<PaymentsInfoEntity> getPaymentsInfo() async {
    // if (useMock) {
    return PaymentsInfoModel.fromJson(mockPaymentsJson);
    // } else {
    //   return [];
    // Aqui vai a lógica real — pode ser chamada de API, local ou mock.
    ///TODO(Ogai): Implementar lógica real
    // throw UnimplementedError('Ainda não implementado');
    // Aqui você pode mapear os dados do mock para a entidade PaymentsInfoEntity
    // }
  }
}
