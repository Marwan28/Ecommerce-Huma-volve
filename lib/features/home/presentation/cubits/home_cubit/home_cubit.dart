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
  int offset = 0;
  int limit = 6;
  num currentCategoryId = 0;

  HomeCubit({
    required this.getCategoriesUsecase,
    required this.getProductsUsecase,
  }) : super(HomeInitial()) {
    getCategories();
  }


  void getCategories() async {
    emit(HomeCategoriesLoading());
    final result = await getCategoriesUsecase.call();
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(HomeCategoriesFailure(errorMessage: failure.failureMessage)),
      (categories) {
        emit(HomeCategoriesSuccess(categories: categories));
        currentCategoryId = categories.first.id!;
        getProducts(categoryId: currentCategoryId);
      },
    );
  }

  void getProducts({required num categoryId}) async {
    if (state is HomeProductsLoading) return;
    offset = 0;
    currentCategoryId = categoryId;
    emit(HomeProductsLoading());
    final result = await getProductsUsecase.call(
      categoryId: categoryId.toString(),
      limit: limit,
      offset: offset,
    );
    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(HomeProductsFailure(errorMessage: failure.failureMessage)),
      (products) => emit(HomeProductsSuccess(products: products)),
    );
  }

  void loadMoreProducts() async {
    if (state is HomeProductsLoading) return;
    final currentState = state as HomeProductsSuccess;
    offset += limit;
    final result = await getProductsUsecase.call(
      categoryId: currentCategoryId.toString(),
      limit: limit,
      offset: offset,
    );
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(HomeProductsFailure(errorMessage: failure.failureMessage)),
      (newProducts) {
        emit(
          HomeProductsSuccess(
            products: [...currentState.products, ...newProducts],
          ),
        );
      },
    );
  }
}
