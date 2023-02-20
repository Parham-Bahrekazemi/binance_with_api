import 'package:binance/providers/crypto_data_provider.dart';
import 'package:binance/providers/theme_provider.dart';
import 'package:binance/ui/main_wrapper.dart';
import 'package:binance/ui/sign_up_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'providers/market_view_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CryptoDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => MarketViewProvider(),
        ),
      ],
      child: const MyMaterialApp(),
    ),
  );
}

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({super.key});

  @override
  State<MyMaterialApp> createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (BuildContext context, dynamic themeProvider, Widget? child) {
      return MaterialApp(
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const Directionality(
          textDirection: TextDirection.ltr,
          child: SignUpScreen(),
        ),
      );
    });
  }
}
