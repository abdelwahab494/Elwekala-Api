import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_api/core/shared/cubit/products_cubit.dart';
import 'package:products_api/core/shared/data/repos/api/api_repo.dart';
import 'package:products_api/features/products/products_screen.dart';

final ApiRepo apiRepo = ApiRepo();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => ProductsCubit(apiRepo)..loadProducts(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(scaffoldBackgroundColor: Color(0xfff6f6f6)),
            home: const ProductsScreen(),
          ),
        );
      },
    );
  }
}
