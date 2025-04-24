import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_by_iago/src/core/base/base.dart';
import 'package:project_by_iago/src/core/base/enums/payments_tab_enum.dart';
import 'package:project_by_iago/src/modules/payments/data/data.dart';
import 'package:project_by_iago/src/modules/payments/domain/domain.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_bloc.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_event.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_tab_changed_event.dart';

class MockGetPaymentsUseCase extends Mock implements GetPaymentsUseCase {}

void main() {
  late PaymentsBloc bloc;
  late MockGetPaymentsUseCase mockUseCase;

  final PaymentsInfoEntity mockEntity = PaymentsInfoModel.empty();

  setUp(() {
    mockUseCase = MockGetPaymentsUseCase();
    bloc = PaymentsBloc(mockUseCase);
    when(
          () => mockUseCase(NoParams()),
    ).thenAnswer((_) async => Right(mockEntity));
  });

  group('PaymentsBloc', () {
    blocTest<PaymentsBloc, PaymentsState>(
      'deve emitir [loading, success] ao executar FetchPaymentsEvent',
      build: () {
        when(() => mockUseCase()).thenAnswer((_) async => Right(mockEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPaymentsEvent()),
      expect: () => [isA<PaymentsLoadingState>(), isA<PaymentsSuccessState>()],
    );

    blocTest<PaymentsBloc, PaymentsState>(
      'deve emitir [loading, success] ao executar RefreshPaymentsEvent',
      build: () {
        when(() => mockUseCase()).thenAnswer((_) async => Right(mockEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(RefreshPaymentsEvent()),
      expect: () => [isA<PaymentsLoadingState>(), isA<PaymentsSuccessState>()],
    );

    blocTest<PaymentsBloc, PaymentsState>(
      'deve trocar aba com PaymentsTabChangedEvent',
      build: () {
        when(() => mockUseCase()).thenAnswer((_) async => Right(mockEntity));
        return bloc;
      },
      seed:
          () => PaymentsSuccessState(
        paymentsInfo: mockEntity,
        visibleTransactionFields: [],
        selectedTabEnum: PaymentsTabEnum.schedule,
      ),
      act:
          (bloc) =>
          bloc.add(PaymentsTabChangedEvent(PaymentsTabEnum.transactions)),
      expect:
          () => [
        predicate<PaymentsState>(
              (state) =>
          state is PaymentsSuccessState &&
              state.selectedTabEnum == PaymentsTabEnum.transactions,
        ),
      ],
    );

    blocTest<PaymentsBloc, PaymentsState>(
      'deve emitir [loading, error] quando o usecase retornar falha',
      build: () {
        when(
              () => mockUseCase(NoParams()),
        ).thenAnswer((_) async => Left(GenericFailure()));
        return PaymentsBloc(mockUseCase);
      },
      act: (bloc) => bloc.add(FetchPaymentsEvent()),
      expect: () => [isA<PaymentsLoadingState>(), isA<PaymentsErrorState>()],
    );

    blocTest<PaymentsBloc, PaymentsState>(
      'mantém filtros visíveis ao trocar de aba',
      build: () => bloc,
      seed:
          () => PaymentsSuccessState(
        paymentsInfo: mockEntity,
        visibleTransactionFields: [
          PaymentsTransactionHeadersModel(
            key: 'total',
            label: 'Total',
            isDefault: true,
          ),
        ],
        selectedTabEnum: PaymentsTabEnum.schedule,
      ),
      act:
          (bloc) =>
          bloc.add(PaymentsTabChangedEvent(PaymentsTabEnum.transactions)),
      expect:
          () => [
        isA<PaymentsSuccessState>().having(
              (state) => state.visibleTransactionFields.map((e) => e.key),
          'filtros preservados',
          contains('total'),
        ),
      ],
    );

    blocTest<PaymentsBloc, PaymentsState>(
      'deve emitir um estado apropriado para lista vazia de transações e agendamentos',
      build: () {
        final emptyEntity = PaymentsInfoModel.empty();
        when(() => mockUseCase()).thenAnswer((_) async => Right(emptyEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPaymentsEvent()),
      expect:
          () => [
        isA<PaymentsLoadingState>(),
        isA<PaymentsSuccessState>().having(
              (state) =>
          state.paymentsInfo.transactions.isEmpty &&
              state.paymentsInfo.paymentsScheduled.isEmpty,
          'listas vazias',
          isTrue,
        ),
      ],
    );

    blocTest<PaymentsBloc, PaymentsState>(
      'deve atualizar visibleFields com UpdateVisibleTransactionFieldsEvent',
      build: () => bloc,
      seed:
          () => PaymentsSuccessState(
        paymentsInfo: mockEntity,
        visibleTransactionFields: [],
        selectedTabEnum: PaymentsTabEnum.schedule,
      ),
      act:
          (bloc) => bloc.add(
        UpdateVisibleTransactionFieldsEvent([
          PaymentsTransactionHeadersModel(
            key: 'actualFee',
            label: 'Late Fee',
            isDefault: false,
          ),
        ]),
      ),
      expect:
          () => [
        isA<PaymentsSuccessState>().having(
              (state) =>
              state.visibleTransactionFields.map((e) => e.key).toList(),
          'visibleFields atualizados',
          contains('actualFee'),
        ),
      ],
    );
  });
}
