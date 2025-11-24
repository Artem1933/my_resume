class GitHubUserModel {
  final String login;
  final String name;
  final String avatarUrl;
  final int publicRepos;
  final int followers;

  const GitHubUserModel({
    required this.login,
    required this.name,
    required this.avatarUrl,
    required this.publicRepos,
    required this.followers,
  });

  factory GitHubUserModel.fromJson(Map<String, dynamic> json) {
    return GitHubUserModel(
      login: json['login'] as String,
      name: json['name'] as String? ?? 'N/A',
      avatarUrl: json['avatar_url'] as String,
      publicRepos: json['public_repos'] as int,
      followers: json['followers'] as int,
    );
  }
}