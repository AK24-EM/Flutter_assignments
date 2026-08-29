# 📘 Dart Fundamentals

A comprehensive collection of **core Dart language concepts** from basics to advanced topics. Each file is self-contained with runnable examples.

---

## 📁 Directory Structure

```
dart_fundamentals/
├── 01_variables.dart              # Variables, Data Types & Runes
├── 02_collections.dart            # Lists, Sets, Maps & Type Casting
├── 03_operators.dart              # Arithmetic, Logical & Cascade Operators
├── 04_control_flow.dart           # If/Else, Loops & Switch-Case
├── 05_functions.dart              # Positional/Named Params & Closures
├── 06_null_safety.dart            # Nullable Types & Null-aware Operators
├── 07_advanced_control_flow.dart  # Labeled Breaks, Iterable methods
├── 08_advanced_functions.dart     # Higher-Order Functions & Typedefs
├── 09_advanced_null_safety.dart   # Late Final, Generics Null Safety
├── file.dart                      # Dart File I/O Operations
├── main.dart                      # Demo Entry Point
└── README.md                      # Documentation
```

---

## 📚 Topics Covered

### Part 1: Basics
1. **`01_variables.dart`**: `var`, `Object`, `dynamic`, `final` vs `const`, primitive types (`int`, `double`, `String`, `bool`), string interpolation, runes.
2. **`02_collections.dart`**: `List<T>`, `Set<T>`, `Map<K, V>`, indexing, deduplication, type conversions (`int.parse`, `toStringAsFixed`).
3. **`03_operators.dart`**: Arithmetic, relational, equality, logical, ternary (`? :`), null-aware (`??`), cascade (`..`).
4. **`04_control_flow.dart`**: `if`/`else if`/`else`, `for`, `while`, `do-while`, `switch`/`case`, `break`, `continue`.
5. **`05_functions.dart`**: Named vs positional parameters, default values, arrow syntax (`=>`), first-class functions, lexical closures.
6. **`06_null_safety.dart`**: Nullable (`?`), non-nullable, null assertion (`!`), null-coalescing (`??`), `late` variables.

### Part 2: Advanced Concepts
7. **`07_advanced_control_flow.dart`**: Labeled loops, higher-order collection processing (`.where()`, `.map()`, `.forEach()`).
8. **`08_advanced_functions.dart`**: Function callbacks, higher-order functions, `typedef` signatures, recursion.
9. **`09_advanced_null_safety.dart`**: Nullable generics, `late final` initialization patterns, defensive null checks.

---

## 🏃 How to Run Any Topic

You can execute any individual Dart script directly from terminal:

```bash
dart run lib/dart_fundamentals/01_variables.dart
dart run lib/dart_fundamentals/02_collections.dart
dart run lib/dart_fundamentals/05_functions.dart
# ...and so on
```
