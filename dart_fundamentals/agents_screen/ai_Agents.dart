import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// ======================================================
// RIVERPOD 3.x — StateNotifier/StateNotifierProvider removed.
// Use Notifier + NotifierProvider instead.
// ======================================================

// 1. Notifier holds the user/agent name state
class UserNotifier extends Notifier<String> {
  @override
  String build() => 'Agent 007'; // initial state

  void set(String name) => state = name;
}

// 2. Provider using NotifierProvider
final userProvider = NotifierProvider<UserNotifier, String>(
  UserNotifier.new,
);

// ======================================================
// GO ROUTER SETUP
// ShellRoute requires a navigatorKey in go_router 14.x
// ======================================================

final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/shell/details/TargetAcquired',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('AI Agents'),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          body: child,
        );
      },
      routes: [
        GoRoute(
          path: '/shell/details/:name',
          name: 'details',
          builder: (context, state) {
            final name = state.pathParameters['name']!;
            return DetailScreen(name: name);
          },
        ),
      ],
    ),
  ],
);

// ======================================================
// APP ENTRY
// ======================================================

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'AI Agents',
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

// ======================================================
// DETAIL SCREEN — ConsumerWidget reads Riverpod state
// ======================================================

class DetailScreen extends ConsumerWidget {
  final String name;
  const DetailScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch() rebuilds when userProvider state changes
    final agentName = ref.watch(userProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.smart_toy_rounded, size: 72, color: Colors.deepPurple),
          const SizedBox(height: 16),
          Text(
            '$agentName: $name',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Status: Active',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 32),
          // Triggers state change via notifier
          ElevatedButton.icon(
            onPressed: () => ref.read(userProvider.notifier).set('Supreme Ninja'),
            icon: const Icon(Icons.flash_on_rounded),
            label: const Text('Activate Alias'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
          ),
          const SizedBox(height: 12),
          // Reset back to original
          OutlinedButton.icon(
            onPressed: () => ref.read(userProvider.notifier).set('Agent 007'),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Reset Agent'),
          ),
        ],
      ),
    );
  }
}
