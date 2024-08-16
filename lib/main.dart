import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:online_store_tk/src/screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  Intl.defaultLocale = 'es_ES';
  await initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  final userBox = await Hive.openBox('user');
  final isLogged = userBox.get('isLogged', defaultValue: false);
  await LocalStarage.init();
  runApp(MyApp(isLogged: isLogged));
}

class MyApp extends StatelessWidget {
  final bool isLogged;
  const MyApp({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProviderP()),
        ChangeNotifierProvider(lazy: false, create: (_) => LoginProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => RegisterProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => ServiceProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('es', 'ES'), Locale('en', 'US')],
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.firsh,
        routes: appRoutes,
      ),
    );
  }
}
