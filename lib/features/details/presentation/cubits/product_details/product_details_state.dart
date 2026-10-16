part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}
final class ProductDetailsLoading extends ProductDetailsState{}
final class ProductDetailsSuccess extends ProductDetailsState{
  final ProductEntity product;
  ProductDetailsSuccess({required this.product});
}
final class ProductDetailsFailure extends ProductDetailsState{
  final String message;
  ProductDetailsFailure({required this.message});
}
