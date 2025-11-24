import 'package:flutter/material.dart';
import 'package:laba_4_resume/data/repositories/profile_repository.dart';
import 'package:laba_4_resume/domain/models/profile_model.dart';

class AddResumeViewModel extends ChangeNotifier {
  final ProfileRepository _repository;
  final bool isDuplicating;

  late TextEditingController fullNameController;
  late TextEditingController positionController;
  late TextEditingController summaryController;

  AddResumeViewModel(this._repository, {ProfileModel? initialProfile})
      : isDuplicating = initialProfile != null {

    final ProfileModel profileToEdit = initialProfile ?? ProfileModel.empty();

    fullNameController = TextEditingController(text: profileToEdit.fullName);
    positionController = TextEditingController(text: profileToEdit.position);
    summaryController = TextEditingController(text: profileToEdit.summary);
  }

  String get title => isDuplicating ? 'Дублювання резюме' : 'Створення резюме';

  Future<void> saveProfile(BuildContext context) async {
    final newProfile = ProfileModel.empty().copyWith(
      fullName: fullNameController.text.trim(),
      position: positionController.text.trim(),
      summary: summaryController.text.trim(),
    );

    await _repository.addProfile(newProfile);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    positionController.dispose();
    summaryController.dispose();
    super.dispose();
  }
}