import 'package:ecommerce_app_huma_volve/features/home/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/service/home_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService homeService;

  HomeCubit({required this.homeService}) : super(HomeInitial()) {
    getCategories();
  }

  // List<CategoryModel> categories = [];
  // List<ProductModel> products = [];

  void getCategories() async {
    try {
      emit(HomeCategoriesLoading());
      List<CategoryModel> categories = await homeService.getCategories();
      emit(HomeCategoriesSuccess(categories: categories));
      getProducts(categoryId: categories[0].id.toString());
    } catch (e) {
      emit(HomeCategoriesFailure(errorMessage: e.toString()));
    }
  }

  void getProducts({required String categoryId}) async {
    try {
      emit(HomeProductsLoading());
      List<ProductModel> products = await homeService.getProducts(
        categoryId: categoryId,
      );
      emit(HomeProductsSuccess(products: products));
    } catch (e) {
      emit(HomeProductsFailure(errorMessage: e.toString()));
    }
  }
}
