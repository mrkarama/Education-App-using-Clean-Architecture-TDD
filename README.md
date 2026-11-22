# Education App — Flutter Clean Architecture & TDD

A cross-platform educational mobile application built with **Flutter (Dart)** following strict **3-Layer Clean Architecture**, **SOLID principles**, and **Test-Driven Development (TDD)**. Designed so business logic remains completely decoupled from UI frameworks, state management, and external backend data sources.

---

## 🛠️ Tech Stack & Engineering Practices

- **Framework & Language:** Flutter, Dart
- **Architecture:** 3-Layer Clean Architecture (`Domain`, `Data`, `Presentation`) & SOLID Principles
- **State Management:** BLoC / Cubit
- **Testing & Quality:** Test-Driven Development (TDD), Unit Testing with Mocks (`mocktail` / `mockito`), `bloc_test`
- **Backend & Data:** RESTful API Integration, Functional Error Handling (`dartz` / `Either<Failure, Success>`)
- **Dependency Injection:** Service Locator (`get_it`)

---

## 🏗️ 3-Layer Clean Architecture

The codebase enforces strict unidirectional dependencies (`Presentation` ➔ `Domain`  `Data`):

```text
lib/
├── core/                         # Shared failures/exceptions, network checks, dependency injection, utilities
└── features/
    └── <feature_name>/           # e.g., auth, course, quiz, profile
        ├── domain/               # Innermost layer — pure Dart, zero external framework dependencies
        │   ├── entities/         # Core business objects
        │   ├── repositories/     # Abstract repository contracts/interfaces
        │   └── usecases/         # Single-responsibility application business rules
        ├── data/                 # Data retrieval & persistence implementation
        │   ├── datasources/      # Remote (REST API) & local data sources
        │   ├── models/           # Data Transfer Objects (DTOs) with JSON serialization extending Entities
        │   └── repositories/     # Concrete implementations of Domain repository contracts
        └── presentation/         # UI & reactive state management
            ├── bloc/ (or cubit/) # State management depending strictly on Domain UseCases
            ├── views/            # Screens & pages
            └── widgets/          # Reusable UI components
```

### Why This Architecture Matters
- **Framework & Backend Independence:** Swapping REST endpoints or local storage requires updates only inside the `Data` layer without touching `Domain` rules or `Presentation` screens.
- **High Testability:** Because every layer communicates through abstract interfaces, each `UseCase`, `Repository`, `DataSource`, and `BLoC/Cubit` is tested in complete isolation using mocks.

---

## 🧪 Testing Strategy (TDD)

Every feature follows the **Red ➔ Green ➔ Refactor** cycle with comprehensive unit tests mirroring the `lib/` folder structure:

```text
test/
└── features/
    └── <feature_name>/
        ├── domain/usecases/          # Verifies business rules & repository delegation
        ├── data/models/              # Verifies JSON serialization & deserialization (fromJson / toJson)
        ├── data/repositories/        # Verifies success mapping & exception-to-failure handling
        ├── data/datasources/         # Verifies HTTP status codes, endpoints & payload parsing
        └── presentation/bloc/        # Verifies state emissions for success & failure flows
```

### Run All Unit Tests
```bash
flutter test
```

---

## 🚀 Getting Started

### 1. Prerequisites
- **Flutter SDK** (3.x+)
- **Dart SDK**

### 2. Installation & Execution
```bash
git clone https://github.com/mrkarama/Education-App-using-Clean-Architecture-TDD
cd Education-App-using-Clean-Architecture-TDD
flutter pub get
flutter run
```

---

## 👨‍💻 Author

**Abdoul-Rahmane Bande**  
Mobile & Backend Application Developer | Ouagadougou, Burkina Faso  
