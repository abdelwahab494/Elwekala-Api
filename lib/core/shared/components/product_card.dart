import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:products_api/core/manager/app_colors.dart';
import 'package:products_api/core/manager/app_sizes.dart';
import 'package:products_api/core/shared/data/models/product_model.dart';
import 'package:products_api/core/shared/cubit/products_cubit.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product, required this.isFav});
  final ProductModel product;
  final bool isFav;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late final PageController _controller = PageController(initialPage: 1);
  int _currentPage = 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: AppSizes.h350),
      padding: EdgeInsets.all(AppSizes.w8),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(AppSizes.r20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 7,
            offset: Offset(2, 2),
          ),
          BoxShadow(color: AppColors.bg, blurRadius: 7, offset: Offset(-2, -2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: AppSizes.h5,
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned.fill(
                  child: Container(
                    padding: EdgeInsets.all(AppSizes.w12),
                    decoration: BoxDecoration(
                      color: AppColors.bg2,
                      borderRadius: BorderRadius.circular(AppSizes.r20),
                    ),
                    child: PageView.builder(
                      controller: _controller,
                      onPageChanged: (value) => setState(() {
                        _currentPage = value.round();
                      }),
                      itemCount: widget.product.images.length,
                      itemBuilder: (context, index) {
                        final String image = widget.product.images[index];
                        return CachedNetworkImage(imageUrl: image);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: AppSizes.h8,
                  left: AppSizes.w8,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.h4,
                      horizontal: AppSizes.w8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(AppSizes.r500),
                    ),
                    child: Text(
                      widget.product.company,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.sp12,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: AppSizes.h5,
                  child: Row(
                    spacing: AppSizes.w3,
                    children: List.generate(widget.product.images.length, (
                      index,
                    ) {
                      return Icon(
                        Icons.circle,
                        color: _currentPage == index
                            ? AppColors.primary
                            : Color(0xffb7d2c6),
                        size: _currentPage == index
                            ? AppSizes.w10
                            : AppSizes.w7,
                      );
                    }),
                  ),
                ),
                Positioned(
                  top: AppSizes.h5,
                  right: AppSizes.w5,
                  child: GestureDetector(
                    onTap: () => context.read<ProductsCubit>().toggleFavorite(
                      widget.product,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.w4),
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.isFav
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: widget.isFav ? AppColors.red : AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w700,
                    fontSize: AppSizes.sp16,
                  ),
                ),
                Gap(AppSizes.h2),
                Text(
                  widget.product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.text2,
                    fontWeight: FontWeight.w500,
                    fontSize: AppSizes.sp12,
                  ),
                ),
                Gap(AppSizes.h8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: AppSizes.w16,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            color: AppColors.text2,
                            fontWeight: FontWeight.w400,
                            fontSize: AppSizes.sp12,
                          ),
                        ),
                        Text(
                          "\$${widget.product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.sp18,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary2,
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          "Buy",
                          style: TextStyle(
                            color: AppColors.bg,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
