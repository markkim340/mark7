import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark7/product/provider/product_provider.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductTabState();
}

class _ProductTabState extends ConsumerState<ProductScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);
    return Container(
      child: Text('FOod'),
    );
  }
}
