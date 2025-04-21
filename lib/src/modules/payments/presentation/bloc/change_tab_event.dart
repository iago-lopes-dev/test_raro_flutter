import 'package:base_project/src/modules/payments/presentation/bloc/payments_event.dart';

class ChangeTabEvent extends PaymentsEvent {
  final int tabIndex;

  ChangeTabEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}
