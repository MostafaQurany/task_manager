class TaskVersionModel {
  final int versionNumber;
  final String uploadedBy;
  final DateTime uploadedAt;
  final String? revisionNote;
  final bool approved;

  const TaskVersionModel({
    required this.versionNumber,
    required this.uploadedBy,
    required this.uploadedAt,
    this.revisionNote,
    this.approved = false,
  });
}
