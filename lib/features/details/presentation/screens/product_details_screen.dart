import 'package:ecommerce_app_huma_volve/features/details/presentation/cubits/product_details/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_huma_volve/core/themes/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';


import '../../../../core/widgets/primary_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  //late Color _selectedColor;
  //late String _selectedSize;

  @override
  void initState() {
    super.initState();
    //_selectedColor = widget.product.colors.first;
    //_selectedSize = widget.product.sizes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailsFailure) {
            return Center(child: Text(state.message));
          } else if (state is ProductDetailsSuccess) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  pinned: true,
                  backgroundColor: AppTheme.background,
                  leading: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 16),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite_border, size: 18),
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.share, size: 18),
                      ),
                      onPressed: () async {
                        final String productLink ='https://eyego-64d8d.web.app/products/${state.product.id}';
                        final String shareMessage = 'Look at this product: $productLink';
                        await SharePlus.instance.share(
                          ShareParams(text: shareMessage,
                            subject: 'Check out this product on Huma Volve',
                          ),

                        );
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: 'product-${state.product.title}',
                      child: Image.network(
                        state.product.images![0],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.error, color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    transform: Matrix4.translationValues(0.0, -32.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  state.product.title!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(fontSize: 28, height: 1.2),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '\$${state.product.price!.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(
                                      color: AppTheme.primary,
                                      fontSize: 24,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.product.description!,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(height: 1.6, fontSize: 16),
                          ),
                          const SizedBox(height: 24),
                          // Text(
                          //   'Select Color',
                          //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // const SizedBox(height: 12),
                          // ColorSelector(
                          //   colors: widget.product.colors,
                          //   selectedColor: _selectedColor,
                          //   onColorSelected: (color) {
                          //     setState(() {
                          //       _selectedColor = color;
                          //     });
                          //   },
                          // ),
                          // const SizedBox(height: 24),
                          // Text(
                          //   'Select Size',
                          //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // const SizedBox(height: 12),
                          // SizeSelector(
                          //   sizes: widget.product.sizes,
                          //   selectedSize: _selectedSize,
                          //   onSizeSelected: (size) {
                          //     setState(() {
                          //       _selectedSize = size;
                          //     });
                          //   },
                          // ),
                          const SizedBox(height: 32),
                          PrimaryButton(
                            text: 'Add to Cart',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${state.product.title!} added to cart',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: AppTheme.primary,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
