import 'package:flutter/material.dart';
import 'package:task_manager/core/models/comment_model.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/models/task_version_model.dart';
import 'package:task_manager/core/models/waiting_on.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/features/timeline/model/timeline_item_model.dart';

class TimelineScheduleData {
  TimelineScheduleData._();

  static List<TimelineItemModel> getInitialItems() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));
    final dayAfter = today.add(const Duration(days: 2));

    return [
      // --- TODAY'S EVENTS ---
      TimelineItemModel(
        id: 'tl-1',
        date: today,
        time: '09:00 AM',
        endTime: '09:30 AM',
        title: 'Morning Standup & Sprint Sync',
        category: 'Meetings',
        duration: '30 mins',
        isCompleted: true,
        tagColor: AppColors.primary,
        status: TaskStatus.completed,
        clientName: 'Internal Team',
        serviceName: 'Scrum',
        description: 'Review daily blockers, deployment goals, and team availability.',
      ),
      TimelineItemModel(
        id: 'tl-2',
        date: today,
        time: '10:00 AM',
        endTime: '11:15 AM',
        title: 'Mobile App Wireframes Review',
        category: 'Design Sprint',
        duration: '1 hr 15 mins',
        isCompleted: true,
        tagColor: AppColors.activeDot,
        status: TaskStatus.completed,
        clientName: 'Nacho Brand',
        serviceName: 'Design (3/5)',
        description: 'Completed responsive layout wireframes for checkout and cart.',
        versions: [
          TaskVersionModel(
            versionNumber: 1,
            uploadedBy: 'Lead Designer',
            uploadedAt: DateTime.now().subtract(const Duration(days: 2)),
            revisionNote: 'Initial wireframe draft.',
            approved: true,
          ),
        ],
      ),
      TimelineItemModel(
        id: 'tl-3',
        date: today,
        time: '01:30 PM',
        endTime: '03:30 PM',
        title: 'Landing Page Hero & 3D Interactive Carousel',
        category: 'Development',
        duration: '2 hrs',
        isCompleted: false,
        tagColor: AppColors.primaryLight,
        status: TaskStatus.inProgress,
        clientName: 'Nacho Brand',
        serviceName: 'Website (62%)',
        description: 'Implement smooth flutter web animations for the product showcase carousel.',
        comments: [
          CommentModel(
            id: 'c-tl1',
            authorName: 'Sarah Tech Lead',
            body: 'Ensure frame rate remains 60fps on mobile Safari.',
            createdAt: DateTime.now().subtract(const Duration(hours: 3)),
            isClientVisible: false,
          ),
        ],
      ),
      TimelineItemModel(
        id: 'tl-4',
        date: today,
        time: '04:00 PM',
        endTime: '05:00 PM',
        title: 'User Authentication API Integration',
        category: 'Backend',
        duration: '1 hr',
        isCompleted: false,
        tagColor: const Color(0xFF8CE8FF),
        status: TaskStatus.readyToStart,
        clientName: 'Fintech Hub',
        serviceName: 'Mobile App (40%)',
        blockedByTaskTitle: 'Backend OAuth Endpoint Deployment',
        waitingOn: WaitingOn.team,
        description: 'Connect login, OTP validation, and biometric authentication with backend service.',
      ),
      TimelineItemModel(
        id: 'tl-5',
        date: today,
        time: '05:30 PM',
        endTime: '06:30 PM',
        title: 'Logo Pack Revisions for Client Sign-off',
        category: 'Branding',
        duration: '1 hr',
        isCompleted: false,
        tagColor: AppColors.danger,
        status: TaskStatus.revisionRequestedClient,
        clientName: 'Apex Health',
        serviceName: 'Design (4/5)',
        waitingOn: WaitingOn.client,
        description: 'Adjust monochrome typography and high-res vector exports requested by client.',
        comments: [
          CommentModel(
            id: 'c-tl2',
            authorName: 'Apex Brand Manager',
            body: 'Please provide EPS and high-res SVG formats.',
            createdAt: DateTime.now().subtract(const Duration(hours: 5)),
            isClientVisible: true,
          ),
        ],
      ),
      TimelineItemModel(
        id: 'tl-6',
        date: today,
        time: '07:00 PM',
        endTime: '07:30 PM',
        title: 'Daily Wrap-up & Tomorrow Task Planning',
        category: 'Review',
        duration: '30 mins',
        isCompleted: false,
        tagColor: AppColors.warning,
        status: TaskStatus.toDo,
        clientName: 'Internal Team',
        serviceName: 'Management',
        description: 'Sync with team leads on deliverable deadlines and update sprint board.',
      ),

      // --- TOMORROW'S EVENTS ---
      TimelineItemModel(
        id: 'tl-7',
        date: tomorrow,
        time: '09:30 AM',
        endTime: '10:30 AM',
        title: 'Ramadan Campaign Creative Deliverables',
        category: 'Design Sprint',
        duration: '1 hr',
        isCompleted: false,
        tagColor: AppColors.warning,
        status: TaskStatus.internalReview,
        clientName: 'Al-Noor Retail',
        serviceName: 'Posts (8/12)',
        description: 'Review holiday social media banner batch with Creative Director.',
      ),
      TimelineItemModel(
        id: 'tl-8',
        date: tomorrow,
        time: '11:00 AM',
        endTime: '01:00 PM',
        title: 'Flutter Riverpod 3 State Management Refactor',
        category: 'Development',
        duration: '2 hrs',
        isCompleted: false,
        tagColor: const Color(0xFF8CE8FF),
        status: TaskStatus.readyToStart,
        clientName: 'Fintech Hub',
        serviceName: 'Mobile App (40%)',
        description: 'Migrate legacy StateNotifiers to code-generated riverpod providers.',
      ),
      TimelineItemModel(
        id: 'tl-9',
        date: tomorrow,
        time: '03:00 PM',
        endTime: '04:30 PM',
        title: 'Client Stakeholder Demo Presentation',
        category: 'Meetings',
        duration: '1 hr 30 mins',
        isCompleted: false,
        tagColor: AppColors.primary,
        status: TaskStatus.readyForClientReview,
        clientName: 'Shop App Client',
        serviceName: 'Mobile App (40%)',
        description: 'Live interactive walkthrough of the checkout and order tracking flow.',
      ),

      // --- YESTERDAY'S EVENTS ---
      TimelineItemModel(
        id: 'tl-10',
        date: yesterday,
        time: '10:00 AM',
        endTime: '11:30 AM',
        title: 'Brand Guidelines Complete Sign-off',
        category: 'Branding',
        duration: '1 hr 30 mins',
        isCompleted: true,
        tagColor: AppColors.activeDot,
        status: TaskStatus.completed,
        clientName: 'Solaria Energy',
        serviceName: 'Design (5/5)',
        description: 'All color specifications and export assets approved by client.',
      ),
      TimelineItemModel(
        id: 'tl-11',
        date: yesterday,
        time: '02:00 PM',
        endTime: '04:00 PM',
        title: 'Database Schema Optimization',
        category: 'Backend',
        duration: '2 hrs',
        isCompleted: true,
        tagColor: const Color(0xFF8CE8FF),
        status: TaskStatus.completed,
        clientName: 'Internal Team',
        serviceName: 'Infrastructure',
        description: 'Indexed high-traffic tables and reduced query latency by 45%.',
      ),

      // --- DAY AFTER TOMORROW ---
      TimelineItemModel(
        id: 'tl-12',
        date: dayAfter,
        time: '10:00 AM',
        endTime: '12:00 PM',
        title: 'Payment Gateway Integration & Webhooks',
        category: 'Development',
        duration: '2 hrs',
        isCompleted: false,
        tagColor: const Color(0xFF8CE8FF),
        status: TaskStatus.toDo,
        clientName: 'Fintech Hub',
        serviceName: 'Mobile App (40%)',
        description: 'Integrate Stripe and Apple Pay with server-side validation webhooks.',
      ),
    ];
  }
}
