import 'package:flutter/cupertino.dart';

class Note {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  late DateTime _lastEditDate;

  Note({required String name, required String description}) {
    _nameController.text = name;
    _descriptionController.text = description;
    _lastEditDate = DateTime.now();
  }

  TextEditingController get nameController => _nameController;

  TextEditingController get descriptionController => _descriptionController;

  String get name => nameController.text;

  String get description => descriptionController.text;

  DateTime get lastEditDate => _lastEditDate;

  set lastEditDate(DateTime value) {
    _lastEditDate = value;
  }
}
