import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductDetailWidget extends StatefulWidget {
  final Product product;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const ProductDetailWidget({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  late int _localQuantity;

  @override
  void initState() {
    super.initState();
    _localQuantity = widget.quantity;
  }

  void _increase() {
    setState(() {
      _localQuantity++;
    });
    widget.onQuantityChanged(_localQuantity);
  }

  void _decrease() {
    if (_localQuantity > 1) {
      setState(() {
        _localQuantity--;
      });
      widget.onQuantityChanged(_localQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(widget.product.image, width: 200, height: 200),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            widget.product.name,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.product.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.5,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '\$${widget.product.price.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Quantity',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: _decrease,
                  ),
                  Text(
                    '$_localQuantity',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _increase,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
