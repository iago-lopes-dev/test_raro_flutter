import 'package:project_by_iago/src/core/core.dart';
import 'package:project_by_iago/src/modules/payments/domain/domain.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentsRepository {
  Future<Either<Failure, PaymentsInfoEntity>> getPayments();
}
