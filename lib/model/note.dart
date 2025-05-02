import 'package:flutter/cupertino.dart';

class Note {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  Note({required String name, required String description}) {
    _nameController.text = name;
    _descriptionController.text = description;
  }

  TextEditingController get nameController => _nameController;

  TextEditingController get descriptionController => _descriptionController;

  String get name => nameController.text;

  String get description => descriptionController.text;
}
