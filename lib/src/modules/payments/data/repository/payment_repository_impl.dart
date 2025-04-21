import 'package:project_by_iago/src/core/core.dart';
import 'package:project_by_iago/src/modules/payments/data/data.dart';
import 'package:project_by_iago/src/modules/payments/domain/domain.dart';
import 'package:dartz/dartz.dart';

class PaymentsRepositoryImpl implements PaymentsRepository {
  final PaymentsDataSource _datasource;

  const PaymentsRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, PaymentsInfoEntity>> getPayments() async {
    try {
      return Right(await _datasource.getPaymentsInfo());
    } catch (e) {
      return Left(GenericFailure(error: e));
    }
  }
}
