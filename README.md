# BB Sports

**BB Sports** is a role-based Flutter mobile application for managing sports matches and participant attendance. This project uses **GetX** for state management and displays static data from JSON files.

## Features

- Role-based login (Instructor / Student).
- Static data management via local JSON files.
- Instructors can:
  - View upcoming and completed matches.
  - Create new matches.
  - See student participation status.
- Students can:
  - View all matches created by instructors.
  - Mark attendance status (Attending / Declined).
- Dashboards:
  - **Instructor Dashboard**: Shows total matches created and student attendance statistics.
  - **Student Dashboard**: Displays attendance trends for the last 7 and 30 days.

## Data Sources

Data is managed locally using JSON files under `assets/data/`:
- `user_data.json`
- `match_data.json`

## Tech Stack

- Flutter
- GetX (state management, navigation)
- Local JSON for data storage (no backend yet)

## Getting Started

