import 'package:flutter/material.dart';


class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final IconData icon;
  final Color themeColor;
  final bool inStock;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.icon,
    required this.themeColor,
    this.inStock = true,
  });
}

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  final List<Product> _allProducts = [
    Product(
      id: 'P01',
      name: 'Wireless Noise-Canceling Headphones',
      category: 'Audio',
      price: 249.99,
      rating: 4.8,
      icon: Icons.headphones_rounded,
      themeColor: const Color(0xFF8B5CF6),
    ),
    Product(
      id: 'P02',
      name: 'Smartwatch Series 7',
      category: 'Wearables',
      price: 329.50,
      rating: 4.6,
      icon: Icons.watch_rounded,
      themeColor: const Color(0xFF3B82F6),
    ),
    Product(
      id: 'P03',
      name: 'Mechanical Gaming Keyboard',
      category: 'Electronics',
      price: 119.00,
      rating: 4.9,
      icon: Icons.keyboard_rounded,
      themeColor: const Color(0xFF10B981),
    ),
    Product(
      id: 'P04',
      name: 'Ergonomic Wireless Mouse',
      category: 'Electronics',
      price: 69.99,
      rating: 4.5,
      icon: Icons.mouse_rounded,
      themeColor: const Color(0xFFF59E0B),
    ),
    Product(
      id: 'P05',
      name: 'Portable Bluetooth Speaker',
      category: 'Audio',
      price: 89.00,
      rating: 4.7,
      icon: Icons.speaker_rounded,
      themeColor: const Color(0xFFEC4899),
    ),
    Product(
      id: 'P06',
      name: '4K Ultra HD Monitor 27"',
      category: 'Electronics',
      price: 449.00,
      rating: 4.9,
      icon: Icons.desktop_windows_rounded,
      themeColor: const Color(0xFF06B6D4),
    ),
    Product(
      id: 'P07',
      name: 'Fast Wireless Charging Pad',
      category: 'Accessories',
      price: 34.99,
      rating: 4.3,
      icon: Icons.electric_bolt_rounded,
      themeColor: const Color(0xFFEAB308),
    ),
    Product(
      id: 'P08',
      name: 'Noise Isolating Earbuds',
      category: 'Audio',
      price: 129.99,
      rating: 4.4,
      icon: Icons.earbuds_rounded,
      themeColor: const Color(0xFF6366F1),
    ),
  ];

  String _searchQuery = '';
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = ['All', 'Audio', 'Electronics', 'Wearables', 'Accessories'];

  List<Product> get _filteredProducts {
    return _allProducts.where((product) {
      bool matchesCategory = _selectedCategory == 'All' || product.category == _selectedCategory;

      bool matchesSearch = searchQueryIsEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.category.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  bool get searchQueryIsEmpty => _searchQuery.trim().isEmpty;

  @override
  Widget build(BuildContext context) {
    List<Product> displayedList = _filteredProducts;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), 
      appBar: AppBar(
        title: const Text(
          'Tech Product Store',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search products by name or category...',
                    hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF38BDF8)),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white54),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(category),
                      labelStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.black : Colors.white70,
                      ),
                      selectedColor: const Color(0xFF38BDF8),
                      backgroundColor: Colors.white.withValues(alpha: 0.06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xFF38BDF8)
                              : Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                children: [
                  Text(
                    'Showing ${displayedList.length} of ${_allProducts.length} items',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                  const Spacer(),
                  if (_selectedCategory != 'All' || _searchQuery.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() {
                          _selectedCategory = 'All';
                          _searchQuery = '';
                        });
                      },
                      child: const Text(
                        'Reset Filters',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF38BDF8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Expanded(
              child: displayedList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 64,
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No products found matching your search',
                            style: TextStyle(fontSize: 15, color: Colors.white54),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: displayedList.length,
                      itemBuilder: (context, index) {
                        final product = displayedList[index];
                        return _buildProductCard(product);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color(0xFF1E293B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: product.themeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                product.icon,
                color: product.themeColor,
                size: 32,
              ),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: product.themeColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: product.themeColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                      const SizedBox(width: 2),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF38BDF8),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added "${product.name}" to cart!'),
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF38BDF8),
                          foregroundColor: Colors.black,
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Add to Cart', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
