# Agent Context

This project is a highly structured **Agency / Service Delivery Management System** built with Flutter.

## Core System Philosophy
The fundamental rule of this system is the strict hierarchical separation of contracted deliverables and internal execution. The client buys a **Service**, receives a **Deliverable**, but NEVER sees the **Internal Tasks** required to produce it.

## The 7 Core Entities
1. **Clients**: The companies being served.
2. **Contracts**: The binding agreements defining time and quotas.
3. **Services**: The categories of work (Quantity-Based vs Project-Based).
4. **Deliverables (or Projects)**: The client-facing output.
5. **Internal Tasks**: Granular team assignments.
6. **Revisions/Versions**: Immutable history of file iterations and client feedback.
7. **Dependencies**: Blocking mechanisms between tasks.

## Golden Workflow Path
`Client` → `Contract` → `Service` → `Deliverable / Project` → `Internal Tasks` → `Internal Review` → `Client Review` → `Revision (if needed)` → `Client Approval` → `Completed` → `Contract Usage Updated`.

## Technical & UI Implications
- **Dashboards**: You will build distinctly different views for Clients, Employees, Team Leads, Account Managers, and Management.
- **State Management**: Using `riverpod_generator`, ensure complex state like "Blocked" vs "Ready to Start" evaluates dependencies correctly.
- **Data Models**: Using `freezed`, models must track deeply nested structures (e.g., Deliverables containing Versions, Versions containing Files and Comments).
- **History Tracking**: Never implement destructive updates (HTTP PUT/DELETE logic) for Deliverable files; always implement append-only Versioning.
- **Quota Logic**: Do not decrement or consume quotas on creation. Only consume quotas upon the specific state transition to `Client Approved`.
