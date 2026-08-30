import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class CreateTaskAssignPeopleBottomSheet extends StatefulWidget {
  final List<String> initiallySelected;
  const CreateTaskAssignPeopleBottomSheet({
    super.key,
    required this.initiallySelected,
  });

  static Future<List<String>?> show(
      BuildContext context, List<String> initiallySelected) {
    return showModalBottomSheet<List<String>>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateTaskAssignPeopleBottomSheet(
        initiallySelected: initiallySelected,
      ),
    );
  }

  @override
  State<CreateTaskAssignPeopleBottomSheet> createState() =>
      _CreateTaskAssignPeopleBottomSheetState();
}

class _CreateTaskAssignPeopleBottomSheetState
    extends State<CreateTaskAssignPeopleBottomSheet> {
  final List<String> _allPeople = [
    'John',
    'Sara',
    'Alex',
    'Ali',
    'Omar',
    'Emma',
    'Liam',
  ];
  late List<String> _selectedPeople;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedPeople = List.from(widget.initiallySelected);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _togglePerson(String person) {
    setState(() {
      if (_selectedPeople.contains(person)) {
        _selectedPeople.remove(person);
      } else {
        _selectedPeople.add(person);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredPeople = _allPeople
        .where((person) => person.toLowerCase().contains(_searchQuery))
        .toList();

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Drag handle
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Assign People',
                    style: AppTextStyle.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(_selectedPeople);
                    },
                    child: Text(
                      'Done',
                      style: AppTextStyle.button.copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: TextField(
                controller: _searchController,
                style: AppTextStyle.bodyLarge.copyWith(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search people...',
                  hintStyle: AppTextStyle.bodyMedium.copyWith(color: AppColors.textSecondary),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surfaceSoft,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Divider(color: AppColors.borderLight.withValues(alpha: 0.1)),
            // List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: filteredPeople.length,
                itemBuilder: (context, index) {
                  final person = filteredPeople[index];
                  final isSelected = _selectedPeople.contains(person);
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.surfaceLight,
                      child: Text(
                        person[0],
                        style: AppTextStyle.bodyLarge.copyWith(color: AppColors.textPrimary),
                      ),
                    ),
                    title: Text(
                      person,
                      style: AppTextStyle.bodyLarge,
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: AppColors.primary)
                        : const Icon(Icons.circle_outlined, color: AppColors.border),
                    onTap: () => _togglePerson(person),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
