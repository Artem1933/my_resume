import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/dependencies.dart';
import 'routing/router.dart';
import 'ui/theme/theme_view_model.dart';
import 'ui/theme/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProviders,
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Резюме-білдер',
            routerConfig: AppRouter.router,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeViewModel.themeMode,
          );
        },
      ),
    );
  }
}