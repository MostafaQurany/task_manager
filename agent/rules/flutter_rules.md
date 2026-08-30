# Flutter & Widget Composition Rules

## 1. Widget Modularity & Clean View Standard
- **No Private Build Helpers**: Do NOT write `Widget _buildSomething()` methods inside any View or Widget class. Instead, create a separate public/standalone Widget class in `widget/`.
- **Clean View Pattern**: Every `<feature>_view.dart` file should be concise (like `home_view.dart`), importing modular widgets:
  ```dart
  class FeatureView extends StatelessWidget {
    const FeatureView({super.key});

    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: const BoxDecoration(gradient: AppColors.softPeachGradient),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: CustomScrollView(
              slivers: const [
                SliverToBoxAdapter(child: FeatureHeader()),
                SliverToBoxAdapter(child: FeatureFilterBar()),
                FeatureContentList(),
              ],
            ),
          ),
        ),
      );
    }
  }
  ```

## 2. State Management & Controllers
- Exclusively use `flutter_riverpod`.
- Use `@riverpod` or `@Riverpod(keepAlive: true)` annotations.
- Keep UI widgets lightweight; delegate business logic to Riverpod notifiers.

## 3. Data Models
- Separate all data models into `model/` folders.
- Use `@freezed` for immutable models and `@JsonSerializable()` for serialization.

## 4. UI Responsiveness & Theming
- Use `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`) for all dimensions.
- Use `AppColors` and `AppTextStyle` from `lib/core/theme/` rather than hardcoding styles.

## 5. Widget Testing with ScreenUtil
- When testing widgets utilizing `flutter_screenutil`, always configure the test viewport in `testWidgets`:
  ```dart
  tester.view.physicalSize = const Size(1125, 2436);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  ```
- Always wrap the test widget in `ScreenUtilInit(designSize: const Size(375, 812), minTextAdapt: true, ...)` to ensure responsive scaling matches design layout without `RenderFlex` overflows.

## 6. Localization Synchronization
- Whenever keys are added or updated in `lib/l10n/intl_en.arb` or `lib/l10n/intl_ar.arb`, maintain matching accessor getters and message maps in `lib/generated/l10n.dart`, `messages_en.dart`, and `messages_ar.dart`.
