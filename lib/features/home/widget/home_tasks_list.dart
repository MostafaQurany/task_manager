import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/models/comment_model.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/models/task_version_model.dart';
import 'package:task_manager/core/models/waiting_on.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/features/all_tasks/model/user_task_model.dart';
import 'package:task_manager/features/home/widget/home_task_card.dart';
import 'package:task_manager/features/home/widget/home_task_tag.dart';

class HomeTasksList extends StatefulWidget {
  const HomeTasksList({super.key});

  @override
  State<HomeTasksList> createState() => _HomeTasksListState();
}

class _HomeTasksListState extends State<HomeTasksList>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimationsLeft;
  late Animation<Offset> _slideAnimationsRight;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _slideAnimationsLeft = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubicEmphasized,
      ),
    );
    _slideAnimationsRight = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubicEmphasized,
      ),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubicEmphasized,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Widget> _buildTaskCards(BuildContext context) {
    return [
      TaskCard(
        backgroundColor: AppColors.lightCardBg,
        borderColor: Colors.white,
        titleColor: Colors.black,
        descriptionColor: AppColors.cardDescLight,
        checkButtonColor: Colors.black,
        checkIconColor: Colors.white,
        dateColor: AppColors.cardDateLight,
        title: 'Complete Landing Page',
        description: 'Nacho Brand landing page',
        date: '15 Sept',
        moreText: '+1 More',
        status: TaskStatus.inProgress,
        tags: const [
          TaskTag(
            text: 'Landing',
            backgroundColor: Colors.white,
            textColor: Colors.black,
          ),
          TaskTag(
            text: 'Website',
            backgroundColor: AppColors.orangeTag,
            textColor: Colors.black,
          ),
        ],
        onTap: () {
          context.push(
            RoutesName.taskDetailScreen,
            extra: UserTaskModel(
              id: 'h1',
              title: 'Complete Landing Page',
              category: 'Website',
              dueDate: 'Today, 5:00 PM',
              isDone: false,
              isUrgent: false,
              priorityColor: AppColors.primary,
              status: TaskStatus.inProgress,
              clientName: 'Nacho Brand',
              serviceName: 'Website (62%)',
              description: 'Nacho Brand responsive landing page with conversion flow.',
              comments: [
                CommentModel(
                  id: 'c1',
                  authorName: 'Lead Designer',
                  body: 'Hero section mockups approved. Proceed with pricing section.',
                  createdAt: DateTime.now().subtract(const Duration(hours: 2)),
                  isClientVisible: false,
                ),
              ],
              versions: [
                TaskVersionModel(
                  versionNumber: 1,
                  uploadedBy: 'Designer',
                  uploadedAt: DateTime.now().subtract(const Duration(days: 1)),
                  revisionNote: 'Initial wireframes and visual design.',
                  approved: false,
                ),
              ],
            ),
          );
        },
      ),

      TaskCard(
        backgroundColor: AppColors.darkCardBg,
        borderColor: AppColors.darkCardBorder,
        titleColor: Colors.white,
        descriptionColor: AppColors.cardDescDark,
        checkButtonColor: Colors.white,
        checkIconColor: Colors.black,
        dateColor: AppColors.cardDateDark,
        title: 'Create prototype for shop app',
        description:
            'Shop app has over 50 screens that\nneeds a prototype for the client.',
        date: '15 Sept',
        moreText: '+3 More',
        status: TaskStatus.clientReview,
        waitingOn: WaitingOn.client,
        tags: const [
          TaskTag(
            text: 'Mobile app',
            backgroundColor: AppColors.orangeTag,
            textColor: Colors.black,
          ),
          TaskTag(
            text: 'Prototype',
            backgroundColor: AppColors.lightBlueTag,
            textColor: Colors.black,
          ),
        ],
        onTap: () {
          context.push(
            RoutesName.taskDetailScreen,
            extra: UserTaskModel(
              id: 'h2',
              title: 'Create prototype for shop app',
              category: 'Mobile app',
              dueDate: '15 Sept',
              isDone: false,
              isUrgent: true,
              priorityColor: AppColors.warning,
              status: TaskStatus.clientReview,
              waitingOn: WaitingOn.client,
              clientName: 'Shop App Client',
              serviceName: 'Mobile App (40%)',
              description: 'Shop app has over 50 screens that needs interactive prototype.',
              comments: [
                CommentModel(
                  id: 'c2',
                  authorName: 'Account Manager',
                  body: 'Shared prototype link with client. Waiting for client review.',
                  createdAt: DateTime.now().subtract(const Duration(hours: 5)),
                  isClientVisible: false,
                ),
                CommentModel(
                  id: 'c3',
                  authorName: 'Client Product Owner',
                  body: 'Reviewing screens today. Will send feedback by 4 PM.',
                  createdAt: DateTime.now().subtract(const Duration(hours: 1)),
                  isClientVisible: true,
                ),
              ],
              versions: [
                TaskVersionModel(
                  versionNumber: 1,
                  uploadedBy: 'Mobile Lead',
                  uploadedAt: DateTime.now().subtract(const Duration(days: 3)),
                  revisionNote: 'Initial click-through prototype.',
                  approved: false,
                ),
                TaskVersionModel(
                  versionNumber: 2,
                  uploadedBy: 'Mobile Lead',
                  uploadedAt: DateTime.now().subtract(const Duration(days: 1)),
                  revisionNote: 'Added checkout and order history flows.',
                  approved: false,
                ),
              ],
            ),
          );
        },
      ),

      TaskCard(
        backgroundColor: AppColors.darkCardBg,
        borderColor: AppColors.darkCardBorder,
        titleColor: Colors.white,
        descriptionColor: AppColors.cardDescDark,
        checkButtonColor: Colors.white,
        checkIconColor: Colors.black,
        dateColor: AppColors.cardDateDark,
        title: 'Ramadan Campaign Social Posts',
        description: 'Prepare 5 promotional posts for the client campaign.',
        date: '18 Sept',
        moreText: '+2 More',
        status: TaskStatus.readyToStart,
        blockedByTaskTitle: 'Content Approval',
        tags: const [
          TaskTag(
            text: 'Social Media',
            backgroundColor: AppColors.orangeTag,
            textColor: Colors.black,
          ),
          TaskTag(
            text: 'Design',
            backgroundColor: AppColors.lightBlueTag,
            textColor: Colors.black,
          ),
        ],
        onTap: () {
          context.push(
            RoutesName.taskDetailScreen,
            extra: UserTaskModel(
              id: 'h3',
              title: 'Ramadan Campaign Social Posts',
              category: 'Social Media',
              dueDate: '18 Sept',
              isDone: false,
              isUrgent: false,
              priorityColor: AppColors.danger,
              status: TaskStatus.readyToStart,
              blockedByTaskTitle: 'Content Approval',
              clientName: 'Al-Noor Retail',
              serviceName: 'Posts (8/12)',
              description: 'Design Ramadan promotional posts once copy is approved.',
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final cards = _buildTaskCards(context);

    return SliverList.separated(
      itemCount: cards.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return SlideTransition(
              position: _slideAnimationsLeft,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: cards[index],
              ),
            );
          case 1:
            return SlideTransition(
              position: _slideAnimationsRight,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: cards[index],
              ),
            );
          default:
            return FadeTransition(
              opacity: _fadeAnimation,
              child: cards[index],
            );
        }
      },
    );
  }
}
