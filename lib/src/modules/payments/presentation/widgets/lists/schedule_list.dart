import 'package:base_project/src/modules/payments/presentation/widgets/cards/custom_schedule_card.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/payments_schedule_entity.dart';

class ScheduleList extends StatelessWidget {
  final List<PaymentsScheduleEntity> data;
  final ValueNotifier<int> selectedTabIndex;
  final bool isLoading;

  const ScheduleList({
    required this.data,
    required this.selectedTabIndex,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    late PaymentsScheduleEntity nextPaymentItem;
    if (data.isNotEmpty || !isLoading) {
      nextPaymentItem = data.reduce(
        (a, b) =>
            a.paymentDate
                        .difference(currentDate)
                        .abs()
                        .compareTo(
                          b.paymentDate.difference(currentDate).abs(),
                        ) <
                    0
                ? a
                : b,
      );
    }
    ;

    if (isLoading) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: data.isNotEmpty ? data.length : 4,
        itemBuilder: (_, index) => const CustomScheduleCard(isLoading: true),
      );
    }

    if (data.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
        child: Text(
          "Once your loan is booked your payment schedule will appear here. This process may take 1-2 business days.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF868C98BF),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: data.length,
      itemBuilder: (_, index) {
        final item = data[index];
        final isNextPayment = item == nextPaymentItem;

        return CustomScheduleCard(
          schedule: item,
          isLoading: isLoading,
          isNextPayment: isNextPayment,
        );
      },
    );
  }
}
