import 'dart:async';

// ==========================================
// 1. DATA MODEL USING NULL SAFETY
// ==========================================
class UserProfile {
  final int id;
  final String name;
  final String email;
  final String? bio; // Nullable variable (can be null)

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.bio, // Optional parameter
  });

  @override
  String toString() {
    // Using Null-Coalescing Operator (??) to handle null values safely
    String safeBio = bio ?? 'No bio provided';
    return 'ID: $id | Name: $name | Email: $email | Bio: "$safeBio"';
  }
}

// ==========================================
// 2. MOCK API SERVICE (Future, async/await)
// ==========================================
class ApiService {
  /// Simulates an asynchronous API request fetching user data.
  /// Returns a nullable Future<UserProfile?>.
  Future<UserProfile?> fetchUserProfile(int userId) async {
    print('\n🌐 [API Request] Fetching data for User ID: $userId...');

    // Simulate 1 second network latency using Future.delayed
    await Future.delayed(const Duration(seconds: 1));

    // Case 1: Error handling for invalid IDs (Throws FormatException)
    if (userId <= 0) {
      throw FormatException('Invalid User ID: $userId. ID must be greater than 0.');
    }

    // Case 2: Server error scenario (Throws TimeoutException)
    if (userId == 500) {
      throw TimeoutException('Server Error 500: Server response timed out.');
    }

    // Case 3: Null response scenario (User not found)
    if (userId == 404) {
      print('⚠️ [API Response] 404 Not Found.');
      return null;
    }

    // Case 4: Success - User with full data
    if (userId == 1) {
      return UserProfile(
        id: 1,
        name: 'Alice Smith',
        email: 'alice@example.com',
        bio: 'Software developer loving Dart & Flutter.',
      );
    }

    // Case 5: Success - User with null bio field
    return UserProfile(
      id: userId,
      name: 'Bob Johnson',
      email: 'bob@example.com',
      bio: null, // Null value assigned safely
    );
  }
}

// ==========================================
// 3. HELPER FUNCTION WITH TRY-CATCH & NULL CHECKS
// ==========================================
Future<void> processUserFetch(ApiService apiService, int userId) async {
  try {
    // Await asynchronous Future call
    UserProfile? profile = await apiService.fetchUserProfile(userId);

    // Null Safety Check using null-aware syntax
    if (profile == null) {
      print('❌ [Result] User profile is NULL.');
    } else {
      // Safe access to properties
      print('✅ [Result] Successfully fetched user profile:');
      print('   👉 ${profile.toString()}');
    }
  } catch (e) {
    // Catching and handling runtime errors/exceptions
    print('💥 [Error Handled] Caught Exception: $e');
  }
}

// ==========================================
// 4. MAIN ENTRY POINT
// ==========================================
Future<void> main() async {
  final apiService = ApiService();

  print('==============================================');
  print('   🚀 DART ASYNC, FUTURE & NULL SAFETY DEMO   ');
  print('==============================================');

  // 1. Fetching valid user (with non-null bio)
  await processUserFetch(apiService, 1);

  // 2. Fetching valid user (with null bio)
  await processUserFetch(apiService, 2);

  // 3. Fetching non-existent user (Returns NULL)
  await processUserFetch(apiService, 404);

  // 4. Fetching with invalid ID (Handles FormatException error)
  await processUserFetch(apiService, -1);

  // 5. Fetching with server error ID (Handles TimeoutException error)
  await processUserFetch(apiService, 500);

  print('\n==============================================');
  print('   🎉 All async operations completed safely.  ');
  print('==============================================');
}
