import 'package:flutter/material.dart';
import 'package:flutter_market/views/product_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 200 && !_showFloatingButton) {
      setState(() {
        _showFloatingButton = true;
      });
    } else if (_scrollController.offset <= 200 && _showFloatingButton) {
      setState(() {
        _showFloatingButton = false;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _showNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('알림을 확인하세요!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showDeleteDialog(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('상품 삭제'),
          content: const Text('정말로 이 상품을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(productListProvider.notifier)
                    .deleteProduct(product.id);
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);
    final formatter = NumberFormat('#,###');

    return Scaffold(
      appBar: AppBar(
        title: const Text('르탄동'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: _showNotification,
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
              thickness: 0.5,
              height: 20,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(product: product),
                    ),
                  );
                },
                onLongPress: () => _showDeleteDialog(product),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${product.location} • ${product.timeAgo}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${formatter.format(product.price)} 원',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.remove_red_eye_outlined,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${product.chats}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(
                                  product.isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 16,
                                  color: product.isLiked
                                      ? Colors.red
                                      : Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${product.likeCount}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
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
            },
          ),
          // Floating Action Button
          AnimatedOpacity(
            opacity: _showFloatingButton ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: _showFloatingButton
                ? Positioned(
                    bottom: 20,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: _scrollToTop,
                      backgroundColor: Colors.orange,
                      child: const Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
