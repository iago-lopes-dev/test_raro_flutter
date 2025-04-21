import 'package:project_by_iago/src/modules/payments/domain/domain.dart';

abstract class PaymentsDataSource {
  Future<PaymentsInfoEntity> getPaymentsInfo();
}
