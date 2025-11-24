import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../data/repositories/profile_repository.dart';
import '../data/repositories/contact_repository.dart';
import '../data/repositories/github_repository.dart';
import '../data/services/api_service.dart';
import '../data/services/github_service.dart';
import '../data/services/local_storage_service.dart';
import '../data/services/theme_service.dart';
import '../ui/home/view_models/home_view_model.dart';
import '../ui/github/view_models/github_view_model.dart';
import '../ui/theme/theme_view_model.dart';

List<SingleChildWidget> get repositoryProviders {
  return [
    Provider(create: (_) => LocalStorageService()),
    Provider(create: (context) => ProfileRepository(context.read<LocalStorageService>())),
    Provider(create: (context) => ThemeService(context.read<LocalStorageService>())),
    Provider(create: (_) => ContactRepository()),
    Provider(create: (_) => ApiService()),
    Provider(create: (context) => GitHubService(context.read<ApiService>())),
    Provider(create: (context) => GitHubRepository(context.read<GitHubService>())),
  ];
}

List<SingleChildWidget> get viewModelProviders {
  return [
    ChangeNotifierProvider(create: (context) => HomeViewModel(context.read<ProfileRepository>())),
    ChangeNotifierProvider(create: (context) => GitHubViewModel(context.read<GitHubRepository>())),
    ChangeNotifierProvider(create: (context) => ThemeViewModel(context.read<ThemeService>())),
  ];
}

List<SingleChildWidget> get allProviders {
  return [
    ...repositoryProviders,
    ...viewModelProviders,
  ];
}

Future<void> initializeData() async {
  final ProfileRepository profileRepo = ProfileRepository(LocalStorageService());
  await profileRepo.loadProfiles();
}

void setupDependencies() {}