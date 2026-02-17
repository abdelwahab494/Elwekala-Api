import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_api/core/manager/app_colors.dart';
import 'package:products_api/core/manager/app_sizes.dart';
import 'package:products_api/core/shared/data/models/product_model.dart';
import 'package:products_api/features/favorite/favorite_screen.dart';
import 'package:products_api/core/shared/components/product_card.dart';
import 'package:products_api/core/shared/cubit/products_cubit.dart';
import 'package:products_api/core/shared/cubit/products_state.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<ProductsCubit>().loadProducts();
        },
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                "Products",
                style: TextStyle(color: AppColors.primary2),
              ),
              centerTitle: true,
              backgroundColor: AppColors.bg,
              pinned: true,
              scrolledUnderElevation: 0,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (c) => FavoriteScreen()));
                  },
                  icon: Icon(Icons.favorite, color: AppColors.primary2),
                ),
              ],
            ),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary2,
                      ),
                    ),
                  );
                }

                if (state is ProductsError) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text(state.message)),
                  );
                }

                if (state is ProductsLoaded) {
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.w8,
                      vertical: AppSizes.h16,
                    ),
                    sliver: SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: AppSizes.h8,
                        crossAxisSpacing: AppSizes.w8,
                        childAspectRatio: 0.53.h,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final ProductModel product = state.products[index];
                        final bool isFav = state.favorites.any(
                          (fav) => fav.id == product.id,
                        );
                        return ProductCard(product: product, isFav: isFav);
                      },
                    ),
                  );
                }
                return SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }
}
