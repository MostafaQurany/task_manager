# Project Key Points & Architecture

## Core System Architecture
This is a **Service Delivery & Agency Management System** designed for B2B client management. Clients do not sign up independently; they are onboarded by the agency.

## The Hierarchy
1. **Client**: The overarching company entity.
2. **Contract**: Time-bound agreement defining quotas and services (e.g., Jan 2026 - Dec 2026).
3. **Services**:
   - *Quantity-Based*: (e.g., 5 Designs/month, 12 Posts/month).
   - *Project-Based*: (e.g., Mobile App Development, Website).
4. **Deliverables / Projects**: The actual output the client receives (e.g., "Ramadan Campaign Post" or "Mobile App Project").
5. **Modules & Features** *(For Projects)*: High-level groupings of technical work.
6. **Internal Tasks**: Granular steps (e.g., Write Copy, Review Copy, Create Design). **Hidden from the client.**

## Task & Deliverable Workflow
Tasks follow a strict, linear workflow:
`To Do` → `Ready to Start` → `In Progress` → `Internal Review` → `Revision Requested` (Internal) → `Ready for Client Review` → `Client Review` → `Revision Requested` (Client) → `Approved` → `Completed`.

## Critical System Rules
1. **Quota Consumption**: A Deliverable is ONLY counted towards the contract quota (e.g., 1 of 5 Designs) when it reaches **Client Approved** status. Simply creating a task does not consume the quota.
2. **Separation of Comments**:
   - *Internal Comments*: Visible only to the agency team.
   - *Client Comments*: Visible to the client and the team.
3. **Version History**: Every revision request generates a new version (Version 1, Version 2, etc.). Older versions are NEVER deleted. An Activity Log tracks every micro-action across the deliverable's lifecycle.
4. **Delay Accountability**: The system tracks exact delay attribution through statuses like `Waiting on Client` (Waiting for files, approval, info) and `Waiting on Our Team` (Waiting for Design, Development). Dependencies block tasks and pause accountability timers for blocked employees.
