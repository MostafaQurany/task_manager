import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/models/comment_model.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'task_comment_tile.dart';

class TaskCommentsSection extends StatefulWidget {
  final List<CommentModel> initialComments;
  final ValueChanged<CommentModel>? onCommentAdded;

  const TaskCommentsSection({
    super.key,
    required this.initialComments,
    this.onCommentAdded,
  });

  @override
  State<TaskCommentsSection> createState() => _TaskCommentsSectionState();
}

class _TaskCommentsSectionState extends State<TaskCommentsSection> {
  int _selectedTabIndex = 0; // 0 = Internal, 1 = Client
  late List<CommentModel> _comments;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _comments = List.from(widget.initialComments);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _handleAddComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final isClient = _selectedTabIndex == 1;
    final newComment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorName: 'You',
      body: text,
      createdAt: DateTime.now(),
      isClientVisible: isClient,
    );

    setState(() {
      _comments.insert(0, newComment);
      _commentController.clear();
    });

    widget.onCommentAdded?.call(newComment);
  }

  @override
  Widget build(BuildContext context) {
    final filteredComments = _comments.where((c) {
      if (_selectedTabIndex == 0) return !c.isClientVisible;
      return c.isClientVisible;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab Selector Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Comments',
              style: AppTextStyle.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
              ),
            ),
            Container(
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              child: Row(
                children: [
                  _buildTabButton(0, 'Internal'),
                  _buildTabButton(1, 'Client'),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Comments List
        if (filteredComments.isEmpty)
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            alignment: Alignment.center,
            child: Text(
              _selectedTabIndex == 0
                  ? 'No internal comments yet'
                  : 'No client comments yet',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          )
        else
          ...filteredComments.map((comment) => TaskCommentTile(comment: comment)),

        SizedBox(height: 8.h),

        // Comment Input Field
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  style: AppTextStyle.bodyMedium.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: _selectedTabIndex == 0
                        ? 'Add internal note...'
                        : 'Reply to client...',
                    hintStyle: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.textMuted,
                    ),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _handleAddComment(),
                ),
              ),
              GestureDetector(
                onTap: _handleAddComment,
                child: Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    color: AppColors.textDark,
                    size: 18.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(int index, String label) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          label,
          style: AppTextStyle.chip.copyWith(
            color: isSelected ? AppColors.textDark : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 10.sp,
          ),
        ),
      ),
    );
  }
}
