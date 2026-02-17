import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:products_api/core/manager/app_colors.dart';
import 'package:products_api/core/manager/app_sizes.dart';
import 'package:products_api/core/shared/components/product_card.dart';
import 'package:products_api/core/shared/data/models/product_model.dart';
import 'package:products_api/core/shared/cubit/products_cubit.dart';
import 'package:products_api/core/shared/cubit/products_state.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Fav Products"),
            centerTitle: true,
            backgroundColor: AppColors.bg,
            automaticallyImplyLeading: true,
          ),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
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
                    horizontal:  AppSizes.w16,
                    vertical:  AppSizes.h16,
                  ),
                  sliver: SliverList.separated(
                    separatorBuilder: (context, index) => Gap(16),
                    itemCount: state.favorites.length,
                    itemBuilder: (context, index) {
                      final ProductModel product = state.favorites.toList()[index];
                      final bool isFav = state.favorites.contains(product);
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
    );
  }
}
