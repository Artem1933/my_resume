import 'package:flutter/foundation.dart';
import 'package:laba_4_resume/data/repositories/profile_repository.dart';
import 'package:laba_4_resume/domain/models/profile_model.dart';

class HomeViewModel extends ChangeNotifier {
  final ProfileRepository _repository;
  List<ProfileModel> _allProfiles = [];
  bool _isLoading = false;

  HomeViewModel(this._repository) {
    fetchAllProfiles();
  }

  List<ProfileModel> get allProfiles => _allProfiles;
  bool get isLoading => _isLoading;

  Future<void> fetchAllProfiles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allProfiles = await _repository.getAllProfiles();
    } catch (e) {
      if (kDebugMode) print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProfile(int id) async {
    try {
      await _repository.deleteProfile(id);
      await fetchAllProfiles();
    } catch (e) {
      if (kDebugMode) print('Error deleting profile: $e');
    }
  }
}