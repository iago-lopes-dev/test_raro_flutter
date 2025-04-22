import '../converter_helper.dart';

class ScheduleCardAdapter {
  static List<Map<String, String>> fromSchedule({
    required Map<String, dynamic> transaction,
    required List<Map<String, dynamic>> visibleFields,
  }) {
    final items = <Map<String, String>>[];

    for (final field in visibleFields) {
      final key = field["key"];
      final label = field["label"];
      final value = _getDisplayValue(transaction[key]);

      if (value != null) {
        items.add({"label": label, "value": value});
      }
    }

    return items;
  }

  static String? _getDisplayValue(dynamic value) {
    if (value == null) return null;

    if (value is String) {
      if (_isDateString(value)) {
        return ConverterHelper.stringNullableToMMDDYYYY(value);
      }
      return value;
    }

    if (value is num) {
      final doubleValue = ConverterHelper.dynamicToDouble(value);
      return ConverterHelper.currencyFormatter(doubleValue);
    }

    if (value is DateTime) {
      return ConverterHelper.stringNullableToMMDDYYYY(value.toIso8601String());
    }

    return value.toString();
  }

  static bool _isDateString(String value) {
    final isoDatePattern = RegExp(r"^\d{4}-\d{2}-\d{2}");
    return isoDatePattern.hasMatch(value);
  }
}
/// TODO(Ogai): Validar o adapter para ter data correta e também formato de cifrão correto