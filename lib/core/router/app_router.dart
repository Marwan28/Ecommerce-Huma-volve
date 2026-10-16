import 'package:ecommerce_app_huma_volve/core/network/dio_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/repos/auth_repo_imp.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecases/signup_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/screens/login_screen.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/usecases/get_product_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/screens/product_details_screen.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/main_navigation/screens/main_navigation_screen.dart';
import 'package:ecommerce_app_huma_volve/features/splash/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../../features/details/presentation/cubits/product_details/product_details_cubit.dart';
import '../../features/home/data/repos/home_repo_imp.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider(
          create: (context) {
            final AuthRepoImp authRepoImp = AuthRepoImp(
              authRemoteDataSource: AuthRemoteDataSource(
                dioClient: DioClient(),
              ),
              authLocalDataSource: AuthLocalDataSource(
                storage: FlutterSecureStorage(),
              ),
            );
            return AuthCubit(
              loginUsecase: LoginUsecase(authRepo: authRepoImp),
              signupUsecase: SignupUsecase(authRepo: authRepoImp),
            );
          },
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => BlocProvider(
          create: (context) {
            final AuthRepoImp authRepoImp = AuthRepoImp(
              authRemoteDataSource: AuthRemoteDataSource(
                dioClient: DioClient(),
              ),
              authLocalDataSource: AuthLocalDataSource(
                storage: FlutterSecureStorage(),
              ),
            );
            return AuthCubit(
              loginUsecase: LoginUsecase(authRepo: authRepoImp),
              signupUsecase: SignupUsecase(authRepo: authRepoImp),
            );
          },
          child: SignUpScreen(),
        ),
      ),
      GoRoute(
        path: '/main-navigation',
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: '/products/:productId',
        builder: (context, state) => BlocProvider(
          create: (context) => ProductDetailsCubit(
            getProductUsecase: GetProductUsecase(
              homeRepo: HomeRepoImp(
                homeRemoteDataSource: HomeRemoteDataSource(
                  dioClient: DioClient(),
                ),
              ),
            ),
            productId: state.pathParameters['productId']!,
          )..getProductDetails(),
          child: ProductDetailsScreen(),
        ),
      ),
    ],
  );
}
