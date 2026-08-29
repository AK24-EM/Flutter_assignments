# 🌐 Dart Asynchronous API Service & Null Safety

A console-based Dart program demonstrating **Asynchronous Programming** (`Future`, `async`/`await`), comprehensive **Error Handling** (`try`/`catch`/`rethrow`), and Dart's **Sound Null Safety** (`?`, `??`, `late`, `!`).

---

## 📁 File Structure

```
async_api_service/
├── README.md                 # Documentation
└── async_api_service.dart    # Async service with simulated network latency & error cases
```

---

## 🚀 Key Concepts Covered

### 1. Sound Null Safety
- **Nullable Types (`String?`)**: Variables that can explicitly hold `null`.
- **Null-Coalescing Operator (`??`)**: Fallback values for nullable variables.
- **Null-Aware Assignment (`??=`)**: Assign value only if the variable is currently null.
- **Null-Aware Access (`?.`)**: Safely invoke methods on nullable objects.

### 2. Asynchronous Operations
- `Future<T>` and `Future<T?>` return types.
- `async` / `await` syntax for clean asynchronous code.
- Simulated network latency using `Future.delayed()`.

### 3. Error Handling
- Structured `try-catch-on-finally` blocks.
- Catching specific exceptions (`FormatException`, `TimeoutException`).
- Using `rethrow` for propagating critical errors.

---

## 🧪 Test Scenarios Covered in `main()`

1. **User ID 1 (Full Data)**: Returns user with complete name, email, and bio.
2. **User ID 2 (Null Safety Test)**: Returns user with `null` bio; handles gracefully via `??`.
3. **User ID 404 (Not Found)**: Returns `null` response; verified with null-aware check.
4. **User ID -5 (Invalid ID)**: Throws `FormatException`; caught and logged cleanly.
5. **User ID 500 (Server Timeout)**: Throws `TimeoutException`; handled as server error.

---

## 🏃 How to Run

```bash
dart run lib/async_api_service/async_api_service.dart
```
