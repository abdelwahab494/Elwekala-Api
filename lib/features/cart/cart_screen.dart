import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:products_api/core/manager/app_colors.dart';
import 'package:products_api/core/manager/app_sizes.dart';
import 'package:products_api/core/shared/components/cart_card.dart';
import 'package:products_api/core/shared/cubit/products_cubit.dart';
import 'package:products_api/core/shared/cubit/products_state.dart';
import 'package:products_api/core/shared/data/models/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     context.read<ProductsCubit>().loadCart();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.primary2,
        backgroundColor: AppColors.bg,
        onRefresh: () async {
          await context.read<ProductsCubit>().loadCart();
        },
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              title: Text("Cart", style: TextStyle(color: AppColors.primary2)),
              centerTitle: true,
              backgroundColor: AppColors.bg,
              pinned: true,
              scrolledUnderElevation: 0,
              elevation: 0,
              automaticallyImplyLeading: true,
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
                  if (state.cart.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          "No Cart Products Yet",
                          style: TextStyle(
                            color: AppColors.primary2,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.w16,
                      vertical: AppSizes.h16,
                    ),
                    sliver: SliverList.separated(
                      separatorBuilder: (context, index) => Gap(16),
                      itemCount: state.cart.length,
                      itemBuilder: (context, index) {
                        final ProductModel product = state.cart[index];
                        final bool isFav = state.favorites.any(
                          (fav) => fav.id == product.id,
                        );
                        return CartCard(product: product, isFav: isFav);
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
