import 'package:flutter/cupertino.dart';

class Note {
  String _name = '';
  String _description = '';

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  Note(this._name, this._description);

  String get name => _name;

  String get description => _description;

  TextEditingController get nameController => _nameController;

  TextEditingController get descriptionController => _descriptionController;

  void changeDescription() {
    _description = _descriptionController.text;
  }

  void changeName() {
    _name = _nameController.text;
  }
}
