// Subject Model: lib/models/subject_model.dart

import 'package:flutter/material.dart';

class SubjectModel {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  SubjectModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}