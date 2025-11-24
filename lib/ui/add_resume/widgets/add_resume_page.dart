import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/add_resume_view_model.dart';

class AddResumePage extends StatelessWidget {
  final AddResumeViewModel viewModel;
  const AddResumePage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<AddResumeViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(vm.title),
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: vm.fullNameController,
                        decoration: const InputDecoration(
                          labelText: 'Повне ім\'я',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: vm.positionController,
                        decoration: const InputDecoration(
                          labelText: 'Позиція',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: vm.summaryController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Короткий опис / Резюме',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: () {
                          vm.saveProfile(context);
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Зберегти нове резюме'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}