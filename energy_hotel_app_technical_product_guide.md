# Energy Hotel App – Super Detailed Technical & Product Guide

> **Purpose of this document**\
> This guide defines, in a single source of truth, how the **Energy Hotel mobile app** must be designed, structured, and implemented.\
> It is intended to be used as **input for AI-assisted development (Claude Sonnet via Windsurf)** and by human developers.

The app is a **cross-platform Flutter application (iOS & Android)**, built with **Clean Architecture**, designed as a **fully functional demo (local-first)** and **ready for future Supabase backend integration**.

---

## 1. High-Level Product Vision

### 1.1 App Goals

- Provide a **premium, modern, Airbnb-style experience** for hotel guests
- Improve guest experience during their stay
- Promote hotel services and activities
- Act as a **scalable foundation** for a real production app

### 1.2 Key Product Principles

- Clean, modern, intuitive UI
- Subtle, elegant animations
- Offline / local-first demo
- Backend-ready (Supabase in future)
- English default, Spanish optional

---

## 2. Technology Stack

### 2.1 Frontend

- **Flutter / Dart**
- Platforms: iOS & Android
- State Management: **Riverpod** (recommended)
- Architecture: **Clean Architecture (Feature-based)**

### 2.2 Maps

- **flutter\_map**
- Tile provider: OpenStreetMap
- No Google Maps

### 2.3 Storage & Security (Local)

- flutter\_secure\_storage
- SharedPreferences (non-sensitive settings)

### 2.4 Biometrics

- local\_auth

### 2.5 Payments (Demo)

- Local fake wallet
- No real validation
- No external payment gateway

---

## 3. Architecture – Clean Architecture

### 3.1 Core Rule

> Presentation depends on Domain\
> Domain depends on nothing\
> Data depends on Domain

### 3.2 Folder Structure

```text
lib/
 ├── core/
 │   ├── theme/
 │   ├── widgets/
 │   ├── services/
 │   ├── utils/
 │   └── constants/
 │
 ├── features/
 │   ├── auth/
 │   ├── profile/
 │   ├── map/
 │   ├── explore/
 │   ├── activities/
 │   ├── payments/
 │   └── home/
 │
 ├── l10n/
 └── main.dart
```

Each feature contains:

```text
feature/
 ├── presentation/
 ├── domain/
 └── data/
```

---

## 4. Authentication & Session Management

### 4.1 Login Requirements

- Email + password (mocked)
- Session persists after closing app
- Stored securely

### 4.2 Auth Flow

1. App launches
2. Check active session
3. If session exists → go to Home
4. Else → show Login screen

### 4.3 Biometric Authentication

- Optional
- Enabled from Profile → Settings
- Only available after successful login

#### Biometric Logic

- If biometrics enabled AND session exists:
  - Prompt Face ID / Fingerprint on app launch
  - Fallback to normal login if it fails

---

## 5. Navigation Structure

### 5.1 Bottom Navigation Bar

- Home
- Explore
- Map

No more than 3 main tabs.

---

## 6. Screens & Detailed Behavior

### 6.1 Login Screen

**Purpose:** Authenticate user

**UI Characteristics:**

- Minimal
- Clean
- Focused

**Animations:**

- Fade-in form
- Subtle button press animation

---

### 6.2 Home Screen (Airbnb-style)

**Purpose:** Central hub and monetization entry point

**Layout:**

- Greeting header
- Quick action cards
- Recommended sections

**Content:**

- Hotel services
- Featured activities
- Promotions

**Animations:**

- Staggered card appearance
- Smooth scroll behavior

---

### 6.3 Explore Screen

**Purpose:** Discover experiences and places

**Content:**

- Categories (chips)
- Cards with images
- Hotel-curated recommendations

**Animations:**

- Chip selection animation
- Card tap feedback

---

### 6.4 Map Screen

**Purpose:** Interactive nearby guide

**Features:**

- Centered on hotel
- Pins by category
- Filters
- Bottom sheet on marker tap

**UX Rules:**

- Map always visible
- Content slides over map

**Animations:**

- Bottom sheet slide
- Marker tap feedback

---

### 6.5 Activity Detail Screen

**Purpose:** Conversion screen

**Content:**

- Images
- Description
- Price
- Book / Pay CTA

**Animations:**

- Hero animation from card

---

### 6.6 Wallet & Payments (Demo)

**Features:**

- Add fake card
- Save locally
- Select default card

**Payment Flow:**

1. Select service
2. Select card
3. Simulated payment
4. Success confirmation

---

### 6.7 Profile & Settings

**Sections:**

- User info
- Language selection
- Biometric toggle
- Logout

---

## 7. Data & Mock Data Strategy

### 7.1 Local Mock Data

- Activities
- Restaurants
- Amenities
- Places

Stored in local data sources.

### 7.2 Backend-Ready Strategy

All data access must go through repositories.

Example:

```dart
abstract class ActivitiesRepository {
  Future<List<Activity>> getActivities();
}
```

---

## 8. Internationalization (i18n)

- Default language: English
- Optional: Spanish

### Structure

```text
l10n/
 ├── app_en.arb
 └── app_es.arb
```

---

## 9. Design System

### 9.1 UI Style

- Airbnb-inspired
- Minimal
- Premium

### 9.2 Components

- AppCard
- PrimaryButton
- SectionHeader
- ChipFilter
- BottomSheetContainer

---

## 10. Animations System

### Principles

- Subtle
- Fast
- Consistent

### Durations

- Fast: 150ms
- Normal: 250ms
- Page transitions: 200–300ms

---

## 11. Future Backend (Supabase)

Prepared but not implemented:

- Auth
- Database
- Payments

All repositories must be easily replaceable.

---

## 12. Definition of Done (Demo)

- Login works
- Session persists
- Biometrics optional
- Map functional
- Mock data visible
- Fake payments flow works
- Clean Architecture respected
- UI polished and animated

---

## 13. Final Notes

This app must feel:

- Finished
- Professional
- Premium

This guide should be followed **strictly** by any AI or developer generating code for this project.

## 🔒 Global Rules for AI Implementation (Strict)

The following rules must be followed **at all times** throughout the development of the *Energy Hotel* mobile application.

These rules are **non-optional** and override any default assumptions.

---

### 1️⃣ Architecture & Code Structure

- The project must strictly follow **Clean Architecture**.
- Clear separation between:
  - `presentation`
  - `domain`
  - `data`
- No UI logic inside domain or data layers.
- No business logic inside UI widgets.
- Use cases must be pure and framework-agnostic.
- Dependency inversion must be respected at all times.
- Use dependency injection (constructor-based or provider-based).

---

### 2️⃣ Flutter & Dart Best Practices

- **Null safety is mandatory**.
- Follow official Flutter and Dart style guidelines.
- Avoid large widgets; prefer small, reusable components.
- Avoid deeply nested widget trees.
- Prefer composition over inheritance.
- Optimize for performance and readability.

---

### 3️⃣ Deprecated APIs (Strictly Forbidden)

- Do **NOT** use deprecated Flutter APIs under any circumstance.
- Specifically:
  - `withOpacity()` is **strictly forbidden**.
- Always use modern, officially recommended alternatives.
- If an API is marked as deprecated or discouraged, it must not be used.
- Assume the project targets **latest stable Flutter SDK**.

---

### 4️⃣ UI / UX Principles

- UI must follow a **modern, clean, Airbnb-style design**.
- Prioritize:
  - Simplicity
  - Clarity
  - Accessibility
- Avoid visual clutter.
- Use consistent spacing, typography, and colors.
- Follow a unified design system across the app.

---

### 5️⃣ Animations & Transitions

- Animations must be **subtle, smooth, and purposeful**.
- No exaggerated or distracting animations.
- Prefer:
  - `AnimatedContainer`
  - `AnimatedOpacity`
  - `AnimatedSwitcher`
  - `Hero`
- Animation durations must be short and consistent.
- Animations must live **only in the presentation layer**.
- Never place animation logic in domain or data layers.

---

### 6️⃣ State Management

- State management must be predictable and scalable.
- UI state must be separated from business logic.
- Avoid tightly coupling UI with data sources.
- Ensure state persistence where required (e.g., user session).

---

### 7️⃣ Authentication & Security (Demo Context)

- Session persistence must work even after app restart.
- Biometric authentication must be optional and user-enabled.
- Secure storage must be used for sensitive data (tokens, flags).
- Even in demo mode, simulate real-world security flows.

---

### 8️⃣ Data & Backend Readiness

- Current version uses **local mock data only**.
- Data layer must be prepared for future Supabase integration.
- Use repositories and data sources to abstract data origin.
- Switching from mock data to Supabase must not affect UI or domain layers.

---

### 9️⃣ Payments & Wallet (Simulation)

- Payment flows are **simulated only**.
- Allow saving fake/test cards.
- No real payment gateways.
- UI and logic must be designed as if it were a real-world implementation.

---

### 🔟 Code Quality & Maintainability

- Code must be clean, readable, and well-structured.
- Avoid magic numbers and hardcoded strings.
- Use constants and centralized configuration.
- Favor explicit code over clever shortcuts.
- Every implementation should be easy to understand and extend.

---

### 1️⃣1️⃣ Error Handling & UX

- Handle errors gracefully.
- Show user-friendly messages.
- Avoid app crashes under any circumstance.
- Loading, empty, and error states must be clearly defined.

---

### 1️⃣2️⃣ Consistency & Long-Term Vision

- Always think in terms of scalability and future features.
- Do not implement hacks or temporary shortcuts.
- All decisions must align with the long-term vision of the app.
