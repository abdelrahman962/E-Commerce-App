import '../../domain/entities/basket_item.dart';

abstract class BasketState {}

class BasketInitial extends BasketState {}

class BasketLoading extends BasketState {}

class BasketLoaded extends BasketState {
  final List<BasketItem> items;
  BasketLoaded(this.items);
}

class BasketOperationSuccess extends BasketState {
  final String? message;
  BasketOperationSuccess([this.message]);
}

class BasketError extends BasketState {
  final String message;
  BasketError(this.message);
}
