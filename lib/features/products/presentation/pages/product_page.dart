import 'package:e_commerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../widgets/products_widget.dart';
import '../../../basket/presentation/widgets/basket_badge.dart';
import '../bloc/product_event.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  void _logout(BuildContext context) {
    context.read<AuthBloc>().add(LogOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    productBloc.add(LoadProductsEvent());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text(
          'E-Commerce App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          const BasketBadge(),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsLoaded) {
            final products = state.products;
            if (products.isEmpty) {
              return const Center(child: Text('No products found.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductsWidget(product: product);
              },
            );
          } else if (state is ProductOperationFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
