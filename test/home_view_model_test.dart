import 'package:flutter_test/flutter_test.dart';
import 'package:laba_4_resume/data/repositories/profile_repository.dart';
import 'package:laba_4_resume/domain/models/profile_model.dart';
import 'package:laba_4_resume/ui/home/view_models/home_view_model.dart';

class MockProfileRepository implements ProfileRepository {
  static final mockProfiles = [
    const ProfileModel(id: 10, fullName: 'Test 1', position: 'Pos 1', summary: 'Sum 1'),
    const ProfileModel(id: 20, fullName: 'Test 2', position: 'Pos 2', summary: 'Sum 2'),
  ];
  
  @override
  Future<List<ProfileModel>> getAllProfiles() async {
    return mockProfiles;
  }

  @override
  Future<ProfileModel?> getProfileById(int id) async => null;
  
  @override
  Future<void> addProfile(ProfileModel newProfile) async {}

  @override
  Future<void> deleteProfile(int id) async {}

  @override
  Future<List<ProfileModel>> loadProfiles() async => mockProfiles;
}

void main() {
  group('HomeViewModel Tests', () {
    late MockProfileRepository mockRepository;
    late HomeViewModel viewModel;

    setUp(() {
      mockRepository = MockProfileRepository();
      viewModel = HomeViewModel(mockRepository); 
    });

    test('Initial loading state and data fetching', () async {
      await Future.microtask(() => null);

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.allProfiles.length, 2);
      expect(viewModel.allProfiles.first.fullName, 'Test 1');
    });
  });
}