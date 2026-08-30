# Architecture & Folder Structure Rules

## 1. Project Folder Structure & Layering
The project follows a strict **Feature-Driven Layered Architecture**:

```
lib/
├── app/                        # Application configuration, initialization & entry
│   └── task_app.dart           # MaterialApp.router, theme & localization setup
├── core/                       # Shared/cross-cutting infrastructure
│   ├── constants/              # Global constants (images, strings, icons)
│   ├── routes/                 # Navigation, GoRouter configuration & route names
│   ├── theme/                  # Colors, typography, ThemeData
│   └── widgets/                # Reusable global widgets (custom bottom nav, dialogs, etc.)
├── features/                   # Business domain features
│   └── <feature_name>/
│       ├── model/              # Data models (Freezed, JSON, entity definitions)
│       ├── view/               # Top-level screen views ONLY (pure orchestration)
│       ├── widget/             # Modular, dedicated UI components for this feature
│       └── controller/         # Riverpod notifiers & business logic
└── generated/                  # Localization (intl) and code-gen output
```

## 2. Strict UI Separation & File Cleanliness Rules
- **NEVER define private widget helper methods** (e.g. `_buildTaskTile()`, `_buildHeader()`, `_buildCard()`) inside View files.
- **NEVER define internal private data models** (e.g. `_UserTaskItem`, `_NotificationItem`) inside View files.
- **EVERY UI component must be a dedicated standalone widget class** placed in `lib/features/<feature>/widget/`.
- **EVERY model must be defined in `lib/features/<feature>/model/`** or shared in `lib/core/model/`.
- **View files (`<feature>_view.dart`) must ONLY orchestrate sub-widgets** (e.g. using `CustomScrollView`, `Column`, `SafeArea`) exactly like `home_view.dart`.

## 3. Routing & Navigation
- ALWAYS use `go_router` for app routing and navigation.
- Route names and paths MUST be defined centrally in `lib/core/routes/routes_name.dart`.

## 4. Data Layer & State Management
- Use `flutter_riverpod` for state management with code generation.
- Use `hive_ce` for local caching and offline data persistence.
