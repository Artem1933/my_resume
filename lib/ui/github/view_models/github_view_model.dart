import 'package:flutter/foundation.dart';
import 'package:laba_4_resume/data/repositories/github_repository.dart';
import 'package:laba_4_resume/domain/models/github_user_model.dart';

class GitHubViewModel extends ChangeNotifier {
  final GitHubRepository _repository;
  GitHubUserModel? _userStats;
  bool _isLoading = false;
  String? _errorMessage;

  static const String username = 'Artem1933';

  GitHubViewModel(this._repository) {
    fetchStats();
  }

  GitHubUserModel? get userStats => _userStats;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchStats() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _userStats = await _repository.getUserStats(username);
    } catch (e) {
      _errorMessage = 'Не вдалося завантажити статистику GitHub.';
      if (kDebugMode) print('GitHub Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}