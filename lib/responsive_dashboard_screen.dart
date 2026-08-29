import 'package:flutter/material.dart';

class ResponsiveDashboardScreen extends StatefulWidget {
  const ResponsiveDashboardScreen({super.key});

  @override
  State<ResponsiveDashboardScreen> createState() =>
      _ResponsiveDashboardScreenState();
}

class _ResponsiveDashboardScreenState
    extends State<ResponsiveDashboardScreen> {
  final List<Map<String, dynamic>> _metrics = [
    {
      'title': 'Total Revenue',
      'value': '\$48,250',
      'change': '+14.2%',
      'isPositive': true,
      'icon': Icons.attach_money,
      'color': const Color(0xFF10B981),
    },
    {
      'title': 'Active Users',
      'value': '14,890',
      'change': '+8.5%',
      'isPositive': true,
      'icon': Icons.people_outline,
      'color': const Color(0xFF3B82F6),
    },
    {
      'title': 'New Orders',
      'value': '1,420',
      'change': '-2.4%',
      'isPositive': false,
      'icon': Icons.shopping_bag_outlined,
      'color': const Color(0xFFF59E0B),
    },
    {
      'title': 'System Load',
      'value': '24.8%',
      'change': '-5.1%',
      'isPositive': true,
      'icon': Icons.speed,
      'color': const Color(0xFF8B5CF6),
    },
  ];

  final List<Map<String, String>> _recentActivities = [
    {
      'title': 'Subscription Renewal',
      'subtitle': 'Alice Smith renewed Pro Plan',
      'time': '2 mins ago',
      'amount': '+\$299.00',
    },
    {
      'title': 'New Order #4892',
      'subtitle': 'Bob Johnson purchased 3 items',
      'time': '15 mins ago',
      'amount': '+\$145.50',
    },
    {
      'title': 'Server Backup',
      'subtitle': 'Automated database backup completed',
      'time': '1 hour ago',
      'amount': 'System',
    },
    {
      'title': 'Refund Processed',
      'subtitle': 'Order #4810 refunded',
      'time': '3 hours ago',
      'amount': '-\$49.00',
    },
    {
      'title': 'New User Registration',
      'subtitle': 'Charlie Davis created an account',
      'time': '5 hours ago',
      'amount': 'User',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;
    final isTablet = screenWidth >= 600 && screenWidth < 900;

    final gridCrossAxisCount = isDesktop ? 4 : (isTablet ? 2 : 2);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), 
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        elevation: 1,
        title: Row(
          children: [
            const Icon(Icons.dashboard_rounded, color: Color(0xFF38BDF8)),
            const SizedBox(width: 10),
            const Text(
              'Analytics Dashboard',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF38BDF8).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF38BDF8)),
              ),
              child: Text(
                isDesktop
                    ? 'Desktop View'
                    : (isTablet ? 'Tablet View' : 'Mobile View'),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF38BDF8),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back, Aayush 👋',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Here is what is happening with your system today.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  _buildMetricsGrid(gridCrossAxisCount),
                                  const SizedBox(height: 16),
                                  _buildChartSection(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          Expanded(
                            flex: 2,
                            child: _buildRecentActivitySection(),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildMetricsGrid(gridCrossAxisCount),
                            const SizedBox(height: 16),

                            _buildChartSection(),
                            const SizedBox(height: 16),

                            SizedBox(
                              height: 380,
                              child: _buildRecentActivitySection(),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemCount: _metrics.length,
      itemBuilder: (context, index) {
        final item = _metrics[index];
        final Color itemColor = item['color'] as Color;

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: itemColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: itemColor,
                      size: 20,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: (item['isPositive'] as bool)
                          ? const Color(0xFF10B981).withValues(alpha: 0.15)
                          : const Color(0xFFEF4444).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item['change'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: (item['isPositive'] as bool)
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['value'] as String,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChartSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Performance & Revenue Growth',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(Icons.more_horiz, color: Colors.white54),
            ],
          ),
          const SizedBox(height: 16),
          _buildProgressBar('Server Uptime', 0.98, const Color(0xFF10B981)),
          const SizedBox(height: 12),
          _buildProgressBar('Database Usage', 0.65, const Color(0xFF3B82F6)),
          const SizedBox(height: 12),
          _buildProgressBar(
              'API Memory Consumption', 0.42, const Color(0xFF8B5CF6)),
        ],
      ),
    );
  }

  Widget _buildProgressBar(String title, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 8,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 8,
                  width: constraints.maxWidth * value,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecentActivitySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF38BDF8),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: _recentActivities.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.white.withValues(alpha: 0.08),
                height: 16,
              ),
              itemBuilder: (context, index) {
                final activity = _recentActivities[index];
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor:
                          const Color(0xFF38BDF8).withValues(alpha: 0.15),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: Color(0xFF38BDF8),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity['title']!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            activity['subtitle']!,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          activity['amount']!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          activity['time']!,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
