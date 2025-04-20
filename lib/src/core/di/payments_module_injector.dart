import 'package:base_project/src/modules/payments/data/datasource/payments_datasource_impl.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../modules/payments/data/datasource/payments_datasource.dart';
import '../../modules/payments/data/repository/payment_repository_impl.dart';
import '../../modules/payments/domain/repository/payment_repository.dart';
import '../../modules/payments/domain/usecase/get_payments_use_case.dart';

final sl = GetIt.instance;

void setupPaymentsModule() {
  sl.registerLazySingleton<PaymentsDataSource>(() => PaymentsDataSourceImpl());
  sl.registerLazySingleton<PaymentsRepository>(() => PaymentsRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetPaymentsUseCase(sl()));
  sl.registerLazySingleton(() => PaymentsBloc(sl()));
}