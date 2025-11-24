import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:laba_4_resume/ui/home/widgets/home_page.dart';
import 'package:laba_4_resume/ui/home/view_models/home_view_model.dart';
import 'package:laba_4_resume/ui/theme/theme_view_model.dart';
import 'package:laba_4_resume/data/repositories/profile_repository.dart';
import 'package:laba_4_resume/domain/models/profile_model.dart';
import 'package:laba_4_resume/data/services/theme_service.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}
class MockThemeService extends Mock implements ThemeService {}

void main() {
  group('HomePage Widget Tests', () {
    late MockProfileRepository mockProfileRepo;
    late MockThemeService mockThemeService;

    setUp(() {
      mockProfileRepo = MockProfileRepository();
      mockThemeService = MockThemeService();
      
      when(() => mockThemeService.loadThemeMode()).thenAnswer((_) async => false);
    });

    testWidgets('Application starts and shows title', (WidgetTester tester) async {
      when(() => mockProfileRepo.getAllProfiles())
          .thenAnswer((_) async {
            await Future.delayed(const Duration(milliseconds: 1)); 
            return <ProfileModel>[]; 
          });

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => HomeViewModel(mockProfileRepo),
            ),
            ChangeNotifierProvider(
              create: (_) => ThemeViewModel(mockThemeService),
            ),
          ],
          child: const MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      expect(find.text('Варіанти Резюме'), findsOneWidget);

      await tester.pumpAndSettle();
    });
  });
}