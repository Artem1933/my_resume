class ContactModel {
  final String title;
  final String value;
  final int level;

  const ContactModel({
    required this.title,
    required this.value,
    this.level = 0,
  });
}