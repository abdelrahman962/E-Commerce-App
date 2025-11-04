import 'package:e_commerce_app/features/basket/domain/entities/basket_item.dart';
import 'package:equatable/equatable.dart';

abstract class BasketEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBasketEvent extends BasketEvent {}

class AddBasketItemEvent extends BasketEvent {
  final BasketItem item;
  AddBasketItemEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class UpdateBasketItemEvent extends BasketEvent {
  final BasketItem item;
  UpdateBasketItemEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveBasketItemEvent extends BasketEvent {
  final int id;
  RemoveBasketItemEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ClearBasketEvent extends BasketEvent {}
