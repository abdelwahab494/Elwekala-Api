import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_api/core/shared/cubit/products_cubit.dart';
import 'package:products_api/core/shared/data/local/pref_helper.dart';
import 'package:products_api/core/shared/data/repos/api/api_repo.dart';
import 'package:products_api/features/login/cubit/login_cubit.dart';
import 'package:products_api/features/login/login_screen.dart';
import 'package:products_api/features/products/products_screen.dart';

final ApiRepo apiRepo = ApiRepo();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsCubit(apiRepo)..loadProducts(),
        ),
        BlocProvider(create: (context) => LoginCubit(apiRepo)),
      ],
      child: const MyApp(),
    ),
  );
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(scaffoldBackgroundColor: Color(0xfff6f6f6)),
          home: PrefHelper.getToken() != null
              ? ProductsScreen()
              : LoginScreen(),
        );
      },
    );
  }
}
