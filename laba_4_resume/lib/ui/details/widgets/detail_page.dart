import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/detail_view_model.dart';

class DetailPage extends StatelessWidget {
  final DetailViewModel viewModel;

  const DetailPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<DetailViewModel>(
            builder: (context, vm, child) {
              return Text(vm.profileInfo?.position ?? 'Деталі');
            },
          ),
        ),
        body: Consumer<DetailViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.profileInfo == null) {
              return const Center(
                child: Text('Профіль не знайдено!'),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vm.profileInfo!.fullName,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          vm.profileInfo!.summary,
                          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                        const Divider(height: 40),
                        const Text(
                          'Навички та Контакти:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final item = vm.skills[index];
                      final isSkill = item.level > 0;

                      return ListTile(
                        leading: isSkill
                            ? const Icon(Icons.code, color: Colors.blueAccent)
                            : const Icon(Icons.contact_mail, color: Colors.green),
                        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(item.value),
                        trailing: isSkill
                            ? SizedBox(
                          width: 80,
                          child: LinearProgressIndicator(
                            value: item.level / 10,
                            color: Colors.blueAccent,
                          ),
                        )
                            : null,
                      );
                    },
                    childCount: vm.skills.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}