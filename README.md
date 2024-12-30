# **Rick and Morty Characters Explorer**

A Flutter app that explores the world of Rick and Morty by fetching character details using the [Rick and Morty API](https://rickandmortyapi.com/). This project demonstrates clean architecture, efficient state management, API integration, and polished UI/UX.

---

## **App Screenshots**

| Native Splash      | App Splash         | Home Page         |
|---------------------|--------------------|-------------------|
| ![Native Splash](https://github.com/user-attachments/assets/32db2767-5a23-4574-9aea-475c30dc9306) | ![Splash](https://github.com/user-attachments/assets/89a9cfd1-8d16-452b-bbc8-8cc37a940194) | ![Home](https://github.com/user-attachments/assets/1d7d1e41-1ed0-47d5-b8b1-99b25a56ac96) |

| Favorites          | No Favorites       | No Internet       |
|---------------------|--------------------|-------------------|
| ![Favorites](https://github.com/user-attachments/assets/3f171d21-ec0f-4e9e-846f-9e3b002725ca) | ![No Favorites](https://github.com/user-attachments/assets/bae9e06a-ec66-427b-8a19-7459c05a2cf3) | ![No Internet](https://github.com/user-attachments/assets/7b8b764d-7901-4506-80e1-b41cb61c27c2) |

---

## **Features**

1. **Character List:**
   - Display character avatars, names, species, and statuses.
   - Infinite scrolling to fetch more characters as you scroll.
2. **Search and Filter:**
   - Search for characters by name.
   - Filter characters by status (Alive, Dead, Unknown) and species (e.g., Human, Alien).
3. **Favorite Characters:**
   - Mark characters as favorites.
   - View favorites in a separate tab.
4. **Character Details:**
   - View detailed information about a character, including:
     - Name, status, species, type, gender.
     - Origin and current location.
     - Episodes they appear in.
5. **Offline Mode:**
   - Detect and handle no internet connectivity.
6. **Error Handling:**
   - Display appropriate error messages for issues like network errors or no search results.

---

## **Packages Used**

| **Category**         | **Package**                            | **Purpose**                                                                 |
|-----------------------|----------------------------------------|-----------------------------------------------------------------------------|
| **Networking**        | `dio`                                 | For making API requests.                                                   |
| **State Management**  | `flutter_bloc`                        | For managing app state efficiently.                                        |
| **Persistence**       | `shared_preferences`                  | To save favorite characters locally.                                       |
| **UI/UX**             | `flutter_screenutil`, `flutter_svg`   | For responsive UI and SVG handling.                                        |
| **Offline Mode**      | `connectivity_plus`, `flutter_offline`| To handle offline scenarios and connectivity status.                        |
| **Utilities**         | `infinite_scroll_pagination`, `fluttertoast` | For pagination and user notifications.                                   |
| **Other**             | `get_it`, `flutter_native_splash`     | Dependency injection and custom splash screen.                             |

---

## **Clean Architecture**

The app follows **Clean Architecture** principles, separating responsibilities across layers for better scalability, testability, and maintainability.

### **Core:**
Contains shared functionality used across the app.

- **Constants:** App-wide constant values.
- **Helpers:** Utility functions and extensions.
- **Local Storage:** Local persistence using `shared_preferences`.
- **Models:** Core data models.
- **Network:** API client setup with `dio`.
- **Routes:** App navigation routes.
- **Utils:** Common utilities.
- **Widgets:** Reusable UI components.

### **Features:**
Each feature is implemented in a modular folder structure.

- **Data Layer:**
  - Remote Data Source: Handles API calls via `dio`.
  - Repository Implementation: Implements repository interfaces.
- **Domain Layer:**
  - Repository Interface: Defines contracts for the data layer.
  - Use Case: Encapsulates application-specific business logic.
- **Presentation Layer:**
  - UI screens and state management using `flutter_bloc`.

---

## **Focus Areas**

While building this app, I emphasized the following software development principles and best practices:

- **Performance Bottlenecks:** Ensured smooth scrolling, fast data loading, and efficient API calls.
- **Maintainability Concerns:** Structured the project for long-term maintainability with clean architecture.
- **Readability Challenges:** Used clear naming conventions and concise code for better readability.
- **Object-Oriented Programming (OOP):** Followed OOP principles to create modular, reusable components.
- **Data Structures & Algorithms (DSA):** Applied efficient data structures and algorithms for features like searching and filtering.
- **SOLID Principles:** Ensured the app adheres to SOLID principles for robust and flexible design.
- **Design Patterns:** Utilized design patterns like Singleton (e.g., `GetIt` for dependency injection).
- **Clean Code:** Wrote well-documented, readable, and maintainable code.
- **Code Smells:** Regularly refactored code to eliminate code smells and improve quality.

---

## **System Design**

```plaintext
lib/
├── core/
│   ├── constants/
│   ├── helpers/
│   ├── local_storage/
│   ├── models/
│   ├── network/
│   ├── routes/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── feature_name/
│   │   ├── data/
│   │   │   ├── remote_data_source.dart
│   │   │   ├── repository_implementation.dart
│   │   └── domain/
│   │       ├── repository.dart
│   │       ├── use_cases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── screens/
│   │       └── widgets/
│   └── ...
├── main.dart
