import 'package:flutter_bloc/flutter_bloc.dart';
import 'basket_event.dart';
import 'basket_state.dart';
import '../../domain/usecases/get_basket.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final GetBasketItems getBasketItems;
  final AddBasketItem addBasketItem;
  final UpdateBasketItem updateBasketItem;
  final RemoveBasketItem removeBasketItem;
  final ClearBasket clearBasket;

  BasketBloc({
    required this.getBasketItems,
    required this.addBasketItem,
    required this.updateBasketItem,
    required this.removeBasketItem,
    required this.clearBasket,
  }) : super(BasketInitial()) {
    on<LoadBasketEvent>(_onLoadBasket);
    on<AddBasketItemEvent>(_onAddItem);
    on<UpdateBasketItemEvent>(_onUpdateItem);
    on<RemoveBasketItemEvent>(_onRemoveItem);
    on<ClearBasketEvent>(_onClearBasket);
  }

  Future<void> _onLoadBasket(
    LoadBasketEvent event,
    Emitter<BasketState> emit,
  ) async {
    emit(BasketLoading());
    try {
      final items = await getBasketItems();
      emit(BasketLoaded(items));
    } catch (e) {
      emit(BasketError('Failed to load basket: $e'));
    }
  }

  Future<void> _onAddItem(
    AddBasketItemEvent event,
    Emitter<BasketState> emit,
  ) async {
    try {
      await addBasketItem(event.item);
      add(LoadBasketEvent());
      emit(BasketOperationSuccess('Item added successfully'));
    } catch (e) {
      emit(BasketError('Failed to add item: $e'));
    }
  }

  Future<void> _onUpdateItem(
    UpdateBasketItemEvent event,
    Emitter<BasketState> emit,
  ) async {
    try {
      int previousQuantity = 0;
      if (state is BasketLoaded) {
        final items = (state as BasketLoaded).items;
        final existingItem = items.firstWhere(
          (i) => i.id == event.item.id,
          orElse: () => event.item,
        );
        previousQuantity = existingItem.quantity;
      }

      await updateBasketItem(event.item, previousQuantity: previousQuantity);
      add(LoadBasketEvent());
      emit(BasketOperationSuccess('Item updated successfully'));
    } catch (e) {
      emit(BasketError('Failed to update item: $e'));
    }
  }

  Future<void> _onRemoveItem(
    RemoveBasketItemEvent event,
    Emitter<BasketState> emit,
  ) async {
    try {
      if (state is BasketLoaded) {
        final items = (state as BasketLoaded).items;
        final item = items.firstWhere((i) => i.id == event.id);
        await removeBasketItem(item);
        add(LoadBasketEvent());
        emit(BasketOperationSuccess('Item removed successfully'));
      }
    } catch (e) {
      emit(BasketError('Failed to remove item: $e'));
    }
  }

  Future<void> _onClearBasket(
    ClearBasketEvent event,
    Emitter<BasketState> emit,
  ) async {
    try {
      if (state is BasketLoaded) {
        final items = (state as BasketLoaded).items;
        await clearBasket(items);
        emit(BasketOperationSuccess('Basket cleared successfully'));
      }
    } catch (e) {
      emit(BasketError('Failed to clear basket: $e'));
    }
  }
}
