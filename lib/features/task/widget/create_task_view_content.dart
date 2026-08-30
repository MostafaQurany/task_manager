import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_it/talk_it.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import 'create_task_content_bottom_sheet.dart';

class ChecklistItem {
  final String id;
  String title;
  bool isDone;

  ChecklistItem({required this.id, required this.title, this.isDone = false});
}

class CreateTaskViewContent extends StatefulWidget {
  const CreateTaskViewContent({
    super.key,
    this.initialContent = '',
    this.onConfirmed,
    this.onChanged,
  });

  final String initialContent;
  final ValueChanged<String>? onConfirmed;
  final void Function(String description, List<ChecklistItem> checklist)?
  onChanged;

  @override
  State<CreateTaskViewContent> createState() => CreateTaskViewContentState();
}

class CreateTaskViewContentState extends State<CreateTaskViewContent> {
  late final TextEditingController _descController;
  late final TextEditingController _checklistInputController;
  late final TalkIt _talkIt;

  final List<ChecklistItem> _checklist = [];
  bool _isListeningDesc = false;
  bool _isListeningChecklist = false;

  String get description => _descController.text.trim();
  List<ChecklistItem> get checklist => List.from(_checklist);

  bool validate() {
    if (description.isEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8.w),
              const Expanded(
                child: Text('Please add a task description before saving.'),
              ),
            ],
          ),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _descController = TextEditingController(text: widget.initialContent);
    _checklistInputController = TextEditingController();
    _talkIt = TalkIt();
    _initTalkIt();

    _descController.addListener(_notifyParent);
  }

  Future<void> _initTalkIt() async {
    try {
      await _talkIt.initialize();
    } catch (_) {
      // Native speech service initialization
    }
  }

  @override
  void didUpdateWidget(covariant CreateTaskViewContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialContent != oldWidget.initialContent &&
        widget.initialContent != _descController.text) {
      _descController.text = widget.initialContent;
    }
  }

  @override
  void dispose() {
    _talkIt.stop();
    _descController.removeListener(_notifyParent);
    _descController.dispose();
    _checklistInputController.dispose();
    super.dispose();
  }

  void _notifyParent() {
    setState(() {});
    widget.onChanged?.call(_descController.text, List.from(_checklist));
  }

  Future<void> _openEditor() async {
    FocusScope.of(context).unfocus();

    final result = await CreateTaskContentBottomSheet.show(
      context,
      _descController.text,
    );

    if (result == null) return;

    _descController.value = TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: result.length),
    );
    _notifyParent();
  }

  Future<void> _toggleVoiceDesc() async {
    if (_isListeningDesc) {
      await _talkIt.stop();
      if (mounted) {
        setState(() {
          _isListeningDesc = false;
        });
      }
      return;
    }

    if (_isListeningChecklist) {
      await _talkIt.stop();
      if (mounted) {
        setState(() {
          _isListeningChecklist = false;
        });
      }
    }

    if (!mounted) return;

    setState(() {
      _isListeningDesc = true;
    });

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      const SnackBar(
        content: Text('Listening... Speak your task description'),
        duration: Duration(seconds: 3),
        backgroundColor: AppColors.surfaceLight,
      ),
    );

    try {
      await _talkIt.listen(
        onResult: (result) {
          if (mounted) {
            setState(() {
              if (result.recognizedWords.isNotEmpty) {
                _descController.text = result.recognizedWords;
              }
              if (result.isFinal) {
                _isListeningDesc = false;
              }
            });
            _notifyParent();
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isListeningDesc = false;
        });
      }
    }
  }

  Future<void> _toggleVoiceChecklist() async {
    if (_isListeningChecklist) {
      await _talkIt.stop();
      if (mounted) {
        setState(() {
          _isListeningChecklist = false;
        });
      }
      return;
    }

    if (_isListeningDesc) {
      await _talkIt.stop();
      if (mounted) {
        setState(() {
          _isListeningDesc = false;
        });
      }
    }

    if (!mounted) return;

    setState(() {
      _isListeningChecklist = true;
    });

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      const SnackBar(
        content: Text('Listening... Speak checklist item'),
        duration: Duration(seconds: 3),
        backgroundColor: AppColors.surfaceLight,
      ),
    );

    try {
      await _talkIt.listen(
        onResult: (result) {
          if (mounted) {
            setState(() {
              if (result.recognizedWords.isNotEmpty) {
                _checklistInputController.text = result.recognizedWords;
              }
              if (result.isFinal) {
                _isListeningChecklist = false;
              }
            });
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isListeningChecklist = false;
        });
      }
    }
  }

  void _addChecklistItem() {
    final title = _checklistInputController.text.trim();
    if (title.isEmpty) return;

    setState(() {
      _checklist.add(
        ChecklistItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
        ),
      );
      _checklistInputController.clear();
    });
    _notifyParent();
  }

  void _removeChecklistItem(String id) {
    setState(() {
      _checklist.removeWhere((item) => item.id == id);
    });
    _notifyParent();
  }

  void _toggleChecklistItem(ChecklistItem item) {
    setState(() {
      item.isDone = !item.isDone;
    });
    _notifyParent();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TaskContentHeader(onExpand: _openEditor),
          SizedBox(height: 10.h),
          _TaskDescriptionField(
            controller: _descController,
            isListening: _isListeningDesc,
            onVoiceTap: _toggleVoiceDesc,
          ),
          SizedBox(height: 16.h),
          _ChecklistHeader(
            totalCount: _checklist.length,
            completedCount: _checklist.where((e) => e.isDone).length,
          ),
          SizedBox(height: 8.h),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_checklist.isNotEmpty) ...[
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _checklist.length,
                    separatorBuilder: (context, index) => SizedBox(height: 6.h),
                    itemBuilder: (context, index) {
                      final item = _checklist[index];
                      return _ChecklistRow(
                        item: item,
                        onToggle: () => _toggleChecklistItem(item),
                        onRemove: () => _removeChecklistItem(item.id),
                      );
                    },
                  ),
                  SizedBox(height: 8.h),
                ],
                _AddChecklistField(
                  controller: _checklistInputController,
                  isListening: _isListeningChecklist,
                  onVoiceTap: _toggleVoiceChecklist,
                  onAdd: _addChecklistItem,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskContentHeader extends StatelessWidget {
  final VoidCallback onExpand;
  const _TaskContentHeader({required this.onExpand});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.description_outlined,
              size: 18.sp,
              color: AppColors.primary,
            ),
            SizedBox(width: 8.w),
            Text(
              'Task Content',
              style: AppTextStyle.titleSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        InkWell(
          onTap: onExpand,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Icon(
              Icons.open_in_full_rounded,
              size: 16.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _TaskDescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final bool isListening;
  final VoidCallback onVoiceTap;

  const _TaskDescriptionField({
    required this.controller,
    required this.isListening,
    required this.onVoiceTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      constraints: BoxConstraints(minHeight: 54.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isListening
              ? AppColors.primary
              : AppColors.borderLight.withValues(alpha: 0.08),
          width: isListening ? 1.5 : 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 3,
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Add task description...',
                hintStyle: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                ),
                filled: true,
                fillColor: AppColors.surface,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onVoiceTap,
            tooltip: 'Voice Input',
            icon: Icon(
              isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
              color: isListening ? AppColors.primary : AppColors.textSecondary,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChecklistHeader extends StatelessWidget {
  final int totalCount;
  final int completedCount;

  const _ChecklistHeader({
    required this.totalCount,
    required this.completedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Checklist',
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (totalCount > 0)
          Text(
            '$completedCount/$totalCount',
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  final ChecklistItem item;
  final VoidCallback onToggle;
  final VoidCallback onRemove;

  const _ChecklistRow({
    required this.item,
    required this.onToggle,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Icon(
              item.isDone
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              color: item.isDone ? AppColors.primary : AppColors.textSecondary,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.bodyMedium.copyWith(
                color: item.isDone
                    ? AppColors.textMuted
                    : AppColors.textPrimary,
                decoration: item.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
          IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.all(4.w),
            icon: Icon(
              Icons.close_rounded,
              size: 16.sp,
              color: AppColors.textMuted,
            ),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class _AddChecklistField extends StatefulWidget {
  final TextEditingController controller;
  final bool isListening;
  final VoidCallback onVoiceTap;
  final VoidCallback onAdd;

  const _AddChecklistField({
    required this.controller,
    required this.isListening,
    required this.onVoiceTap,
    required this.onAdd,
  });

  @override
  State<_AddChecklistField> createState() => _AddChecklistFieldState();
}

class _AddChecklistFieldState extends State<_AddChecklistField> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _hasText = widget.controller.text.trim().isNotEmpty;
    widget.controller.addListener(_updateTextState);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateTextState);
    super.dispose();
  }

  void _updateTextState() {
    final hasTextNow = widget.controller.text.trim().isNotEmpty;
    if (hasTextNow != _hasText) {
      setState(() {
        _hasText = hasTextNow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      height: 44.h,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: widget.isListening
              ? AppColors.primary
              : AppColors.borderLight.withValues(alpha: 0.08),
          width: widget.isListening ? 1.5 : 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),

      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,

              textInputAction: TextInputAction.done,
              onSubmitted: (_) => widget.onAdd(),
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: '+ Add checklist item...',
                hintStyle: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                ),
                border: InputBorder.none,
                filled: true,
                fillColor: AppColors.surface,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 10.h,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onVoiceTap,
            tooltip: 'Voice Input Item',
            icon: Icon(
              widget.isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
              color: widget.isListening
                  ? AppColors.primary
                  : AppColors.textSecondary,
              size: 18.sp,
            ),
          ),
          if (_hasText)
            IconButton(
              onPressed: widget.onAdd,
              tooltip: 'Add Item',
              icon: Icon(
                Icons.add_circle_rounded,
                color: AppColors.primary,
                size: 20.sp,
              ),
            ),
        ],
      ),
    );
  }
}
