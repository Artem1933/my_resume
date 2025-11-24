import 'package:laba_4_resume/domain/models/contact_model.dart';

class ContactRepository {
  Future<List<ContactModel>> getSkillsAndContacts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      ContactModel(title: 'Email', value: 'artem.dev@gmail.com', level: 0),
      ContactModel(title: 'Телефон', value: '+380 XXX XX XX XXX', level: 0),
      ContactModel(title: 'Dart & Flutter', value: '8/10', level: 8),
      ContactModel(title: 'MVVM', value: '7/10', level: 7),
    ];
  }
}