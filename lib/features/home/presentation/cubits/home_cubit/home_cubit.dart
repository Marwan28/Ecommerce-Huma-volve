import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecases/get_products_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUsecase getCategoriesUsecase;
  final GetProductsUsecase getProductsUsecase;

  HomeCubit({
    required this.getCategoriesUsecase,
    required this.getProductsUsecase,
  }) : super(HomeInitial()) {
    getCategories();
  }

  // List<CategoryModel> categories = [];
  // List<ProductModel> products = [];

  void getCategories() async {
    emit(HomeCategoriesLoading());
    final result = await getCategoriesUsecase.call();
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(HomeCategoriesFailure(errorMessage: failure.failureMessage)),
      (categories) {
        emit(HomeCategoriesSuccess(categories: categories));
        getProducts(categoryId: categories[0].id!.toString());
      },
    );
  }

  void getProducts({required String categoryId}) async {
    emit(HomeProductsLoading());
    final result = await getProductsUsecase.call(categoryId: categoryId);
    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(HomeProductsFailure(errorMessage: failure.failureMessage)),
      (products) => emit(HomeProductsSuccess(products: products)),
    );

  }
}
