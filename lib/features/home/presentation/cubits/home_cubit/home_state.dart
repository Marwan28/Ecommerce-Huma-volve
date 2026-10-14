part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeCategoriesLoading extends HomeState {}

final class HomeCategoriesSuccess extends HomeState {
  final List<CategoryEntity> categories;
  HomeCategoriesSuccess({required this.categories});
}

final class HomeCategoriesFailure extends HomeState {
  final String errorMessage;

  HomeCategoriesFailure({required this.errorMessage});
}

final class HomeProductsLoading extends HomeState {}

final class HomeProductsSuccess extends HomeState {
  final List<ProductEntity> products;
  HomeProductsSuccess({required this.products});
}

final class HomeProductsFailure extends HomeState {
  final String errorMessage;

  HomeProductsFailure({required this.errorMessage});
}
