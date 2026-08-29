# 📚 Library Management System

A **console-based Library Management System** written in Dart, demonstrating core **Object-Oriented Programming (OOP)** concepts.

---

## 📁 File

```
library_management/
└── assignment1_library_system.dart   # Main program (console app)
```

---

## 🧠 OOP Concepts Used

| Concept           | Where Applied                                    |
|-------------------|--------------------------------------------------|
| Abstract Class    | `LibraryItem` — base class for all library items |
| Inheritance       | `Book` and `Magazine` extend `LibraryItem`       |
| Method Overriding | `displayInfo()` overridden in both child classes |
| Encapsulation     | Fields managed via methods (`borrowItem`, etc.)  |
| Polymorphism      | `List<LibraryItem>` holds both Books & Magazines |

---

## 🏗️ Class Structure

```
LibraryItem  (abstract)
│   ├── id, title, author, isBorrowed
│   ├── borrowItem()
│   ├── returnItem()
│   └── displayInfo()  ← abstract
│
├── Book
│   ├── pageCount, genre
│   └── displayInfo()  ← overridden
│
└── Magazine
    ├── issueNumber
    └── displayInfo()  ← overridden

Library
    ├── name
    ├── items: List<LibraryItem>
    ├── addItem(item)
    ├── displayAllItems()
    └── searchByTitle(query)
```

---

## ⚙️ Features

- ➕ **Add** books and magazines to the catalog
- 📋 **Display** all catalog items with their status
- 🔖 **Borrow** an item (marks as `Borrowed`, prevents double-borrowing)
- 🔄 **Return** a borrowed item (marks as `Available`)
- 🔍 **Search** items by title (case-insensitive)

---

## 🖥️ Sample Output

```
=== ADDING ITEMS ===
➕ Added "The Dart Programming Language" to catalog.
➕ Added "Clean Code" to catalog.
➕ Added "Tech Monthly" to catalog.

--- City Central Library Catalog ---
[BOOK] ID: B01 | Title: "The Dart Programming Language" | Author: Gilad Bracha | Genre: Computer Science | Pages: 384 | Status: Available
[BOOK] ID: B02 | Title: "Clean Code" | Author: Robert C. Martin | Genre: Software Engineering | Pages: 464 | Status: Available
[MAGAZINE] ID: M01 | Title: "Tech Monthly" | Issue: #142 | Status: Available
-----------------------

=== BORROWING & RETURNING ===
✅ Borrowed "The Dart Programming Language".
❌ "The Dart Programming Language" is already borrowed.

=== SEARCHING ===
Searching catalog for "Code"...
[BOOK] ID: B02 | Title: "Clean Code" | Author: Robert C. Martin | Genre: Software Engineering | Pages: 464 | Status: Available
```

---

## 🚀 How to Run

### Prerequisites
- [Dart SDK](https://dart.dev/get-dart) installed (≥ 3.0)

### Command
```bash
dart run lib/library_management/assignment1_library_system.dart
```

---

## 💡 Key Learnings

- **Abstract classes** define a contract without implementation
- **`@override`** ensures child classes provide their own `displayInfo()`
- **Polymorphism** lets a `List<LibraryItem>` store both `Book` and `Magazine` objects and call the correct `displayInfo()` at runtime
- **Guard clauses** in `borrowItem()` / `returnItem()` prevent invalid state

---

## 👤 Author

**Aayush Kamble** — OOP Assignment 1
