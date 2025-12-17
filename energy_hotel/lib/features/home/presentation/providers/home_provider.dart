import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/home_mock_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/entities/service.dart';
import '../../domain/entities/promotion.dart';
import '../../domain/repositories/home_repository.dart';

final homeMockDataSourceProvider = Provider<HomeMockDataSource>((ref) {
  return HomeMockDataSourceImpl();
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(
    mockDataSource: ref.watch(homeMockDataSourceProvider),
  );
});

final servicesProvider = FutureProvider<List<Service>>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return await repository.getServices();
});

final featuredServicesProvider = FutureProvider<List<Service>>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return await repository.getFeaturedServices();
});

final promotionsProvider = FutureProvider<List<Promotion>>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return await repository.getPromotions();
});
