import 'package:laba_4_resume/data/services/api_service.dart';

class GitHubService {
  final ApiService _apiService;
  static const String _baseUrl = 'https://api.github.com/users/';

  GitHubService(this._apiService);

  Future<Map<String, dynamic>> fetchUserStats(String username) {
    final url = '$_baseUrl$username';
    return _apiService.get(url);
  }
}