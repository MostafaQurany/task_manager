# Project Use Cases

## 1. End-to-End Social Media Workflow
1. Account Manager creates Deliverable: "Ramadan Campaign Design".
2. Internal Tasks are generated: Brief Prep → Copywriting → Content Review → Design → Design Review.
3. Content Team prepares the copy. The Design Task is marked as `Blocked by: Content Approval`.
4. Copy is approved internally; Design Task becomes `Ready to Start`.
5. Designer executes and submits to Design Lead for `Internal Review`.
6. Once internally approved, it moves to `Client Review`.
7. Client views the preview, caption, and publishing date in their portal.
8. Client selects "Request Changes" (e.g., "Make logo smaller").
9. Task reverts to Designer as `Revision Requested`. Designer uploads Version 2.
10. Client approves Version 2. Status becomes `Completed`. Contract usage updates to `1/5 Designs`.

## 2. Software Project Workflow
1. Client contracts for a "Mobile Application".
2. The Project is broken into **Modules** (e.g., Authentication, Profile, Orders).
3. Modules are broken into **Features** (e.g., User Registration).
4. Features are broken into **Tasks** (Requirements → UI/UX → Backend API → Mobile Integration → Testing).
5. Dependencies dictate the flow: Mobile Dev is `Blocked by: Backend API`.
6. The Client Portal shows the Project at `62% Progress`, with Registration `Under Review` and Notifications `Not Started`. Client reviews the completed Feature demo and approves.

## 3. Extra Requests & Out of Contract
- When a client exhausts their 5 Designs/month and requests a 6th.
- The system flags it as `Extra Request`.
- The Account Manager decides to: Approve as Free Extra, Paid Extra, Add to Next Month, or Reject.

## 4. Delay & Bottleneck Tracking
- Deliverable is paused because the client hasn't sent the required logo.
- Task is placed in `Waiting on Client: Waiting for Files`.
- Reporting dashboards show management that the timeline delay is the client's responsibility, not the team's.

## 5. Automated Notifications
- System dispatches notifications for: Task Assignment, Task Unblocked, Internal/Client Revision Requested, Approvals, New Comments, Approaching Deadlines, and Late Tasks.
