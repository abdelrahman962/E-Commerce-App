
# 🛍️ E-Commerce App

This is a Flutter mobile application designed to simulate a simple offline shopping experience. The app uses **SQLite** for local data storage, **Bloc** for state management, and **Dependency Injection (DI)** for a clean and maintainable architecture. All features work completely offline, so no backend is required.

## Features

- 🔐 **Authentication**  
  Users can log in and log out locally. The authentication flow is handled with Bloc to manage state and transitions effectively.

- 🛍️ **Products**  
  Browse through a list of products and view detailed information for each item. All product data is stored locally in SQLite, enabling offline access.

- 🧺 **Basket / Cart**  
  Add items to your basket, update quantities, and remove items. The basket state is managed in real-time using Bloc, ensuring smooth updates across the app.

## Architecture

The app follows a clean and modular structure to separate concerns:

- **Presentation Layer:** Flutter UI with Bloc for state management  
- **Domain Layer:** Business logic, entities, and use cases  
- **Data Layer:** Local SQLite storage for persistence  
- **Core Layer:** Contains shared utilities including **DatabaseHelper** and dependency injection setup  

## Project Structure

```

lib/
├── core/       # Dependency injection and DatabaseHelper
├── features/   # Contains all feature modules (auth, products, basket)
│   ├── auth/
│   ├── products/
│   └── basket/
└── main.dart   # App entry point

````

This structure keeps the code organized and makes it easier to maintain or expand in the future.

## Tech Stack

- **Flutter** – For building the mobile UI  
- **Bloc** – For predictable state management  
- **SQLite** – Local database for storing products, users, and basket items  
- **Dependency Injection** – To manage dependencies and improve testability  
