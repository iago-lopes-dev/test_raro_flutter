import 'package:dartz/dartz.dart';

import '../../modules/payments/domain/entity/payments_schedule_entity.dart';

extension EitherExt<L, R> on Either<L, R> {
  R asRight() => (this as Right).value;
}

extension PaymentsScheduleUtils on List<PaymentsScheduleEntity> {
  PaymentsScheduleEntity getNextPayment({DateTime? date}) {
    final DateTime referenceDate = date ?? DateTime.now();
    return reduce((a, b) =>
    a.paymentDate.difference(referenceDate).abs().compareTo(
      b.paymentDate.difference(referenceDate).abs(),
    ) < 0 ? a : b);
  }
}