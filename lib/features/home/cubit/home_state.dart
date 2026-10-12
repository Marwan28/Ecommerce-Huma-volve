part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeCategoriesLoading extends HomeState {}

final class HomeCategoriesSuccess extends HomeState {
  final List<CategoryModel> categories;
  HomeCategoriesSuccess({required this.categories});
}

final class HomeCategoriesFailure extends HomeState {
  final String errorMessage;

  HomeCategoriesFailure({required this.errorMessage});
}

final class HomeProductsLoading extends HomeState {}

final class HomeProductsSuccess extends HomeState {
  final List<ProductModel> products;
  HomeProductsSuccess({required this.products});
}

final class HomeProductsFailure extends HomeState {
  final String errorMessage;

  HomeProductsFailure({required this.errorMessage});
}
