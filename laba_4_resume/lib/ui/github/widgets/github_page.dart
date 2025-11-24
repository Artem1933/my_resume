import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/github_view_model.dart';

class GitHubPage extends StatelessWidget {
  const GitHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GitHubViewModel>();
    final stats = viewModel.userStats;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика GitHub'),
      ),
      body: Center(
        child: viewModel.isLoading
            ? const CircularProgressIndicator()
            : viewModel.errorMessage != null
            ? Text(viewModel.errorMessage!)
            : stats == null
            ? const Text('Немає даних.')
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(stats.avatarUrl),
            ),
            const SizedBox(height: 16),
            Text(
              stats.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('@${stats.login}'),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('Публічні репозиторії'),
              trailing: Text('${stats.publicRepos}'),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Підписники'),
              trailing: Text('${stats.followers}'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: viewModel.fetchStats,
              child: const Text('Оновити статистику'),
            ),
          ],
        ),
      ),
    );
  }
}