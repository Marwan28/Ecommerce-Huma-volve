import 'package:ecommerce_app_huma_volve/features/details/domain/usecases/get_product_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductUsecase getProductUsecase;
  final String productId;

  ProductDetailsCubit({required this.getProductUsecase, required this.productId})
    : super(ProductDetailsInitial());

  Future<void> getProductDetails() async {
    emit(ProductDetailsLoading());
    final result = await getProductUsecase(productId: productId);
    result.fold(
      (failure) => emit(ProductDetailsFailure(message: failure.failureMessage)),
      (product) => emit(ProductDetailsSuccess(product: product)),
    );
  }
}
