import 'package:project_by_iago/src/core/base/enums/payments_tab_enum.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_event.dart';

class PaymentsTabChangedEvent extends PaymentsEvent {
  final PaymentsTabEnum selectedTab;

  PaymentsTabChangedEvent(this.selectedTab);

  @override
  List<Object?> get props => [selectedTab];
}
