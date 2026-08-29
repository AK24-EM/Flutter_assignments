import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// 1. Post Data Model Class
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'title': title,
        'body': body,
      };
}

// Result wrapper holding Post list and cache status
class FetchResult {
  final List<Post> posts;
  final bool isFromCache;

  FetchResult({required this.posts, required this.isFromCache});
}

// 2. ApiCacheScreen Widget (StatefulWidget)
class ApiCacheScreen extends StatefulWidget {
  const ApiCacheScreen({super.key});

  @override
  State<ApiCacheScreen> createState() => _ApiCacheScreenState();
}

class _ApiCacheScreenState extends State<ApiCacheScreen> {
  late Future<FetchResult> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = fetchPostsWithCache();
  }

  // 3. REST API Fetch & SharedPreferences Caching Logic
  Future<FetchResult> fetchPostsWithCache() async {
    const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      // Attempt HTTP GET request to JSONPlaceholder API
      final response = await http.get(Uri.parse(apiUrl)).timeout(
            const Duration(seconds: 5),
          );

      if (response.statusCode == 200) {
        // Successful API Response: Cache the raw JSON string locally
        await prefs.setString('cached_posts_json', response.body);
        await prefs.setString('last_updated_time', DateTime.now().toString());

        final List<dynamic> jsonList = jsonDecode(response.body);
        final posts = jsonList.map((json) => Post.fromJson(json)).toList();

        return FetchResult(posts: posts, isFromCache: false);
      } else {
        throw Exception('API returned status code: ${response.statusCode}');
      }
    } catch (e) {
      // Network/API Error fallback: Retrieve from SharedPreferences cache
      final String? cachedJson = prefs.getString('cached_posts_json');

      if (cachedJson != null && cachedJson.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(cachedJson);
        final posts = jsonList.map((json) => Post.fromJson(json)).toList();

        return FetchResult(posts: posts, isFromCache: true);
      } else {
        // Rethrow error if neither API nor local cache is available
        throw Exception('Network error and no cached data available: $e');
      }
    }
  }

  void _refreshData() {
    setState(() {
      _postsFuture = fetchPostsWithCache();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('REST API & SharedPreferences'),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<FetchResult>(
          future: _postsFuture,
          builder: (context, snapshot) {
            // Case 1: Waiting / Loading State
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Color(0xFF38BDF8)),
                    SizedBox(height: 16),
                    Text(
                      'Fetching API data...',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              );
            }

            // Case 2: Error State
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_off, size: 64, color: Color(0xFFF43F5E)),
                      const SizedBox(height: 16),
                      const Text(
                        'Failed to load data',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, color: Colors.white54),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _refreshData,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF38BDF8),
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Case 3: Data Successfully Loaded (From API or SharedPreferences Cache)
            if (snapshot.hasData) {
              final result = snapshot.data!;
              final posts = result.posts;

              return Column(
                children: [
                  // Cache Status Indicator Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: result.isFromCache
                        ? const Color(0xFFF59E0B).withValues(alpha: 0.15)
                        : const Color(0xFF10B981).withValues(alpha: 0.15),
                    child: Row(
                      children: [
                        Icon(
                          result.isFromCache ? Icons.sd_storage : Icons.wifi,
                          color: result.isFromCache
                              ? const Color(0xFFF59E0B)
                              : const Color(0xFF10B981),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          result.isFromCache
                              ? 'Offline Mode: Displaying data cached from SharedPreferences'
                              : 'Online Mode: Live data from JSONPlaceholder API',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: result.isFromCache
                                ? const Color(0xFFF59E0B)
                                : const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Posts ListView with Pull-to-Refresh
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: fetchPostsWithCache,
                      color: const Color(0xFF38BDF8),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            color: const Color(0xFF1E293B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.08),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundColor:
                                            const Color(0xFF38BDF8).withValues(alpha: 0.2),
                                        child: Text(
                                          '${post.id}',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF38BDF8),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          post.title,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    post.body,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white.withValues(alpha: 0.7),
                                      height: 1.3,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text('No data found.', style: TextStyle(color: Colors.white)));
          },
        ),
      ),
    );
  }
}
