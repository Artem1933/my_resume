import 'dart:convert';
import 'package:laba_4_resume/domain/models/profile_model.dart';
import 'package:laba_4_resume/data/services/local_storage_service.dart';

class ProfileRepository {
  static const String _profileKey = 'saved_profiles';

  final List<ProfileModel> _allProfiles = [];
  final LocalStorageService _localStorage;

  int _nextId = 1;

  ProfileRepository(this._localStorage);

  Future<void> loadProfiles() async {
    final List<String>? storedData = await _localStorage.getList(_profileKey);

    if (storedData != null && storedData.isNotEmpty) {
      _allProfiles.clear();
      for (var jsonString in storedData) {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        _allProfiles.add(ProfileModel.fromJson(jsonMap));
      }
      _nextId = (_allProfiles.map((p) => p.id).fold(0, (a, b) => a > b ? a : b) ?? 0) + 1;
    } else {
      _addInitialMockData();
      await _saveToDevice();
    }
  }

  void _addInitialMockData() {
    _allProfiles.add(const ProfileModel(id: 1, fullName: 'Артем Голубенко', position: 'Flutter Developer', summary: 'Досвід у розробці мобільних додатків на Flutter.'));
    _allProfiles.add(const ProfileModel(id: 2, fullName: 'Артем Голубенко', position: 'Dart Engineer', summary: 'Сильний бекенд-досвід, знання Dart та SQL. Фокус на продуктивності.'));
    _allProfiles.add(const ProfileModel(id: 3, fullName: 'Артем Голубенко', position: 'Lead Mobile Developer', summary: 'Лідерство та наставництво команд.'));
    _nextId = 4;
  }

  Future<void> _saveToDevice() async {
    final List<String> jsonList = _allProfiles.map((p) => jsonEncode(p.toJson())).toList();
    await _localStorage.saveList(_profileKey, jsonList);
  }

  Future<List<ProfileModel>> getAllProfiles() async {
    if (_allProfiles.isEmpty) {
      await loadProfiles();
    }
    return List.of(_allProfiles);
  }

  Future<ProfileModel?> getProfileById(int id) async {
    if (_allProfiles.isEmpty) {
      await loadProfiles();
    }
    return _allProfiles.where((p) => p.id == id).firstOrNull;
  }

  Future<void> addProfile(ProfileModel newProfile) async {
    final profileToSave = newProfile.copyWith(id: _nextId);
    _allProfiles.add(profileToSave);
    _nextId++;
    await _saveToDevice();
  }

  Future<void> deleteProfile(int id) async {
    _allProfiles.removeWhere((p) => p.id == id);
    await _saveToDevice();
  }
}

extension on List<ProfileModel> {
  ProfileModel? get firstOrNull {
    if (isEmpty) return null;
    return first;
  }
}