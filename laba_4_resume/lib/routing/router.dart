import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:laba_4_resume/data/repositories/profile_repository.dart';
import 'package:laba_4_resume/data/repositories/contact_repository.dart';
import 'package:laba_4_resume/domain/models/profile_model.dart';
import 'package:laba_4_resume/ui/home/widgets/home_page.dart';
import 'package:laba_4_resume/ui/details/view_models/detail_view_model.dart';
import 'package:laba_4_resume/ui/details/widgets/detail_page.dart';
import 'package:laba_4_resume/ui/github/widgets/github_page.dart';
import 'package:laba_4_resume/ui/add_resume/widgets/add_resume_page.dart';
import 'package:laba_4_resume/ui/add_resume/view_models/add_resume_view_model.dart';
import 'routes.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: AppRoutes.detailsPath,
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 1;

              final viewModel = DetailViewModel(
                context.read<ContactRepository>(),
                profileId: id,
                profileRepository: context.read<ProfileRepository>(),
              );

              return DetailPage(viewModel: viewModel);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.github,
        builder: (context, state) => const GitHubPage(),
      ),
      GoRoute(
        path: AppRoutes.addResume,
        builder: (context, state) {
          final ProfileModel? initialProfile = state.extra as ProfileModel?;

          final viewModel = AddResumeViewModel(
            context.read<ProfileRepository>(),
            initialProfile: initialProfile,
          );

          return AddResumePage(viewModel: viewModel);
        },
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(child: Text('404')),
    ),
  );
}