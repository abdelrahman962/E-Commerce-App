import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../basket/presentation/bloc/basket_bloc.dart';
import '../../../basket/presentation/bloc/basket_event.dart';
import '../../../basket/domain/entities/basket_item.dart';
import '../../../basket/presentation/widgets/basket_badge.dart';
import '../../domain/entities/product.dart';
import '../widgets/product_detail_widget.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  void _addToBasket(BuildContext context) {
    final basketItem = BasketItem(product: widget.product, quantity: _quantity);
    context.read<BasketBloc>().add(AddBasketItemEvent(basketItem));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Added to basket')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(
          widget.product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [BasketBadge()],
      ),
      body: Column(
        children: [
          Expanded(
            child: ProductDetailWidget(
              product: widget.product,
              quantity: _quantity,
              onQuantityChanged: (newQty) => setState(() {
                _quantity = newQty;
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.black,
                ),
                onPressed: () => _addToBasket(context),
                child: const Text(
                  'Add to Basket',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
