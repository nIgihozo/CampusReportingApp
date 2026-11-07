#  Campus Incident Reporting App

A secure, real-time cross-platform mobile application built with **Flutter** and **Firebase** designed to empower students, faculty, and administrators to report, track, and manage campus safety issues efficiently.

---

##  Key Features

* **Role-Based Access Control (RBAC):** Distinct user roles (**Student**, **Faculty**, and **Admin**) with custom interface views and security privileges.
* **Real-Time Incident Tracking:** Live updates on reported issues using Cloud Firestore streams, tracking progress from *Submitted* to *In Progress* and *Resolved*.
* **Secure Authentication & Onboarding:** Firebase Authentication integration with local frontend validation and secure environment configurations via `flutter_dotenv`.
* **Administrative Management Dashboard:** Authorized staff accounts can instantly review and update incident statuses across the campus network.
* **Dynamic Media Support:** Base64 image encoding and processing for visual incident attachments.

---

##  Tech Stack

* **Frontend:** Flutter & Dart (Cross-platform mobile framework)
* **Backend & Database:** Firebase Authentication & Cloud Firestore (Real-time NoSQL database)
* **State & Data Flow:** Reactive streams (`StreamBuilder`) and asynchronous data handlers
* **Configuration:** `flutter_dotenv` for secure environment variable management

---

##  Installation & Setup

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

## Cloning Process

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/your-username/campus-reporting-app.git](https://github.com/your-username/campus-reporting-app.git)
   cd campus-reporting-app

----
2. **Install Dependency**
```bash
flutter pub get
```
----
3. **Configure Environment Variables:**

- Create a .env file in the root directory.

- Add your secure  access key and.

----
4. **Run Application**
```bash
flutter run
```

----

## PROJECT STRUCTURE
lib/
│
├── service/          # Authentication & database backend handlers (auth_service.dart)
├── screens/          # Core application views
│   ├── login_screen.dart        # Secure login with frontend validation
│   ├── signup_screen.dart       # Role selection & signup logic
│   ├── home_screen.dart         # Dynamic dashboard & role-based header check
│   ├── report_screen.dart       # New incident creation workflow
│   ├── reports_screen.dart      # Full user report listings
│   ├── incident_details_screen.dart # Detailed incident view
│   ├── profile_screen.dart      # User profile management
│   └── staff_screen.dart        # Authorized staff/admin management dashboard
│
└── main.dart         # App entry point & initialization

---

## Security & Validation Highlights
**Client-Side Validation:** Immediate local checks for empty fields, proper email formatting (@), and strict password length requirements (>= 6 characters) before triggering network requests.
**Secret Provisioning:** Administrative registration requires a verified access code loaded securely via environment variables (flutter_dotenv), preventing hardcoded credentials in source control.
**Conditional UI Routing:** Secure server-side and client-side checks ensure administrative features and dashboard links are hidden from regular student accounts.

----

## License
Developed for academic submission and campus safety enhancement.
