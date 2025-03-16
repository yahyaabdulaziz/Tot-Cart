import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tot_cart_task/domain/di/app_dependencies.dart';

import 'presentation/screens/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AppDependencies.provideCartProvider()),
      ],
      child: MaterialApp(
        title: 'Tot App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
          ),
        ),
        home: const ProductsScreen(),
      ),
    );
  }
}
