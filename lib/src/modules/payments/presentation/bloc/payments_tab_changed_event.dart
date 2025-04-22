import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_event.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';

class PaymentsTabChangedEvent extends PaymentsEvent {
  final PaymentsTabEnum selectedTab;

  PaymentsTabChangedEvent(this.selectedTab);

  @override
  List<Object?> get props => [selectedTab];
}
