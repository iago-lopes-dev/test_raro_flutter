import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../../modules/payments/domain/entity/entity.dart';

class ConverterHelper {
  ConverterHelper._();

  static double dynamicToDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value + 0.0;
    } else {
      throw Exception('ConverterHelper.intToDouble: Invalid type');
    }
  }

  static String stringNullableToMMDDYYYY(String? date) {
    if (date == null || date.isEmpty) return '';
    final formattedString = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    final inputDate = DateTime.parse(formattedString.toString());
    return DateFormat('MM/dd/yyyy').format(inputDate);
  }

  static String currencyFormatter(
    double value, [
    String replacedSymbol = '--',
  ]) {
    if (value == 0.0) return replacedSymbol;
    final bool isWholeNumber = value % 1 == 0;
    final String formattedValue =
        isWholeNumber ? value.toInt().toString() : value.toStringAsFixed(2);
    return '\$$formattedValue';
  }

  static String thousandSeparatorFormatter(
    double value, [
    String replacedSymbol = '--',
  ]) {
    if (value == 0.0) return replacedSymbol;
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '',
    );
    return formatter.format(value).trim();
  }

  static Tuple2<bool, String> getFormattedTransactionValue(
    PaymentsTransactionsEntity transaction,
    String key,
  ) {
    final value = switch (key) {
      'actualPaymentPostDate' => transaction.actualPaymentPostDate,
      'processDate' => transaction.processDate,
      'actualPaymentAmount' => transaction.actualPaymentAmount,
      'actualPrincipalPaymentAmount' =>
        transaction.actualPrincipalPaymentAmount,
      'actualInterestPaymentAmount' => transaction.actualInterestPaymentAmount,
      'outstandingPrincipalBalance' => transaction.outstandingPrincipalBalance,
      'outstandingLoanBalance' => transaction.outstandingLoanBalance,
      'actualFee' => transaction.actualFee,
      'type' => transaction.paymentType,
      _ => null,
    };

    if (value == null) return Tuple2(false, '--');

    if (value is DateTime) {
      return Tuple2(
        false,
        ConverterHelper.stringNullableToMMDDYYYY(value.toIso8601String()),
      );
    }

    if (value is double) {
      return Tuple2(true, value.toString());
    }
    return Tuple2(false, value.toString());
  }
}
