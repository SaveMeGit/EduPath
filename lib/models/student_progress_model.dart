// Student Progress Model: lib/models/student_progress_model.dart

class StudentProgressModel {
  final String subjectId;
  final double progress;
  final double hoursSpent;

  StudentProgressModel({
    required this.subjectId,
    required this.progress,
    required this.hoursSpent,
  });
}