// Homeschooling Provider: lib/providers/homeschooling_provider.dart

import 'package:flutter/material.dart';
import '../../models/subject_model.dart';
import '../../models/student_progress_model.dart';

class HomeschoolingProvider extends ChangeNotifier {
  final List<SubjectModel> _subjects = [
    SubjectModel(
      id: '1',
      name: 'Mathematics',
      icon: Icons.calculate,
      color: const Color(0xFF4DB6E2),
    ),
    SubjectModel(
      id: '2',
      name: 'Science',
      icon: Icons.science,
      color: const Color(0xFF6C63FF),
    ),
    SubjectModel(
      id: '3',
      name: 'English',
      icon: Icons.menu_book,
      color: const Color(0xFFFF6584),
    ),
    SubjectModel(
      id: '4',
      name: 'History',
      icon: Icons.history_edu,
      color: const Color(0xFFFFA726),
    ),
    SubjectModel(
      id: '5',
      name: 'Geography',
      icon: Icons.public,
      color: const Color(0xFF66BB6A),
    ),
  ];

  final Map<String, List<StudentProgressModel>> _studentProgress = {
    // Sample data for demo purposes
    'student1': [
      StudentProgressModel(
        subjectId: '1',
        progress: 78,
        hoursSpent: 12.5,
      ),
      StudentProgressModel(
        subjectId: '2',
        progress: 92,
        hoursSpent: 14.2,
      ),
    ],
    'student2': [
      StudentProgressModel(
        subjectId: '1',
        progress: 65,
        hoursSpent: 8.0,
      ),
      StudentProgressModel(
        subjectId: '2',
        progress: 70,
        hoursSpent: 9.5,
      ),
    ],
  };

  bool _isTeacherView = true;

  List<SubjectModel> get subjects => _subjects;

  Map<String, List<StudentProgressModel>> get studentProgress =>
      _studentProgress;

  bool get isTeacherView => _isTeacherView;

  void toggleView() {
    _isTeacherView = !_isTeacherView;
    notifyListeners();
  }

  List<StudentProgressModel> getStudentProgress(String studentId) {
    return _studentProgress[studentId] ?? [];
  }

  double getStudentTotalHours(String studentId) {
    final progressList = _studentProgress[studentId] ?? [];
    return progressList.fold(0, (sum, item) => sum + item.hoursSpent);
  }

  void updateStudentProgress(String studentId,
      String subjectId,
      double progress,
      double additionalHours,) {
    if (!_studentProgress.containsKey(studentId)) {
      _studentProgress[studentId] = [];
    }

    final index = _studentProgress[studentId]!.indexWhere(
          (item) => item.subjectId == subjectId,
    );

    if (index >= 0) {
      final currentItem = _studentProgress[studentId]![index];
      _studentProgress[studentId]![index] = StudentProgressModel(
        subjectId: subjectId,
        progress: progress,
        hoursSpent: currentItem.hoursSpent + additionalHours,
      );
    } else {
      _studentProgress[studentId]!.add(
        StudentProgressModel(
          subjectId: subjectId,
          progress: progress,
          hoursSpent: additionalHours,
        ),
      );
    }

    notifyListeners();
  }
}