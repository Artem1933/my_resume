import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../routing/routes.dart';
import '../../../domain/models/profile_model.dart';
import '../view_models/home_view_model.dart';
import '../../theme/theme_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateToAddResume(BuildContext context, {ProfileModel? profile}) async {
    await context.push(AppRoutes.addResume, extra: profile);

    final viewModel = context.read<HomeViewModel>();
    viewModel.fetchAllProfiles();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final themeViewModel = context.read<ThemeViewModel>();
    final isDarkMode = themeViewModel.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Варіанти Резюме'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: themeViewModel.toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: viewModel.allProfiles.length,
              itemBuilder: (context, index) {
                final profile = viewModel.allProfiles[index];
                return ListTile(
                  onTap: () {
                    context.go('/${AppRoutes.detailsBase}/${profile.id}');
                  },
                  title: Text(profile.position, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(profile.summary),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.copy, color: Colors.blue),
                        onPressed: () {
                          navigateToAddResume(context, profile: profile);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          viewModel.deleteProfile(profile.id);
                        },
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => context.go(AppRoutes.github),
              child: const Text('Переглянути статистику GitHub'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddResume(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}