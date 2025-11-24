import 'package:flutter/foundation.dart';
import 'package:laba_4_resume/data/repositories/contact_repository.dart';
import 'package:laba_4_resume/data/repositories/profile_repository.dart';
import 'package:laba_4_resume/domain/models/contact_model.dart';
import 'package:laba_4_resume/domain/models/profile_model.dart';

class DetailViewModel extends ChangeNotifier {
  final ContactRepository _contactRepository;
  final ProfileRepository _profileRepository;
  final int profileId;

  ProfileModel? _profileInfo;
  List<ContactModel> _skills = [];
  bool _isLoading = false;

  DetailViewModel(this._contactRepository, {required this.profileId, required ProfileRepository profileRepository})
      : _profileRepository = profileRepository {
    loadDetails();
  }

  ProfileModel? get profileInfo => _profileInfo;
  List<ContactModel> get skills => _skills;
  bool get isLoading => _isLoading;

  Future<void> loadDetails() async {
    _isLoading = true;
    notifyListeners();

    try {
      _profileInfo = await _profileRepository.getProfileById(profileId);
      _skills = await _contactRepository.getSkillsAndContacts();

    } catch (e) {
      if (kDebugMode) print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}