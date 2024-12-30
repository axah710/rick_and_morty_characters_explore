# **Rick and Morty Characters Explorer**

A Flutter app that explores the world of Rick and Morty by fetching character details using the [Rick and Morty API](https://rickandmortyapi.com/). This project demonstrates clean architecture, efficient state management, API integration, and polished UI/UX.

---

## **App Screenshots**

| Native Splash      | App Splash         | Home Page         |
|---------------------|--------------------|-------------------|
| ![Native Splash](./screenshots/native_splash.png) | ![Splash](./screenshots/splash.png) | ![Home](./screenshots/home.png) |

| Favorites          | No Favorites       | No Internet       |
|---------------------|--------------------|-------------------|
| ![Favorites](./screenshots/favorites.png) | ![No Favorites](./screenshots/no_favorites.png) | ![No Internet](./screenshots/no_internet.png) |

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
