# 📝 Flutter Firebase Notes App

A simple notes app built using **Flutter** and **Firebase Firestore**, supporting real-time note creation, updating, and deletion.

Video of the working of the app is available in mp4 format above.

---

## 🚀 Features

- ✅ Add, edit, and delete notes
- ✅ Real-time sync with Firebase Firestore
- ✅ Clean and responsive Flutter UI
- ✅ Release build ready for Android

---

## 🔧 Tech Stack

- **Flutter** – App UI and logic
- **Firebase Firestore** – Cloud NoSQL database
- **Firebase Authentication** – Can be used for user-specific notes

---

## 🔥 Firebase Services Used

- **Firestore**: Used to store notes as documents inside a `notes` collection.
- **Firebase Core**: Required for connecting the app to Firebase.
- **Firebase Auth**: For user login if implemented.

---

## 🧩 Data Model (Firestore Schema)

**Collection**: `notes`

Each document contains:
```json
{
  "title": "Grocery List",
  "content": "Milk, Bread, Eggs",
  "timestamp": "2025-06-17T15:30:00Z"
}
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
