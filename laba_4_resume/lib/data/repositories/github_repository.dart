import 'package:laba_4_resume/data/services/github_service.dart';
import 'package:laba_4_resume/domain/models/github_user_model.dart';

class GitHubRepository {
  final GitHubService _service;

  GitHubRepository(this._service);

  Future<GitHubUserModel> getUserStats(String username) async {
    final json = await _service.fetchUserStats(username);
    return GitHubUserModel.fromJson(json);
  }
}