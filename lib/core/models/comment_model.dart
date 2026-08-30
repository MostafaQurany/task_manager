class CommentModel {
  final String id;
  final String authorName;
  final String body;
  final DateTime createdAt;
  final bool isClientVisible; // false = Internal only, true = Client visible

  const CommentModel({
    required this.id,
    required this.authorName,
    required this.body,
    required this.createdAt,
    this.isClientVisible = false,
  });
}
