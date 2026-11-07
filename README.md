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

