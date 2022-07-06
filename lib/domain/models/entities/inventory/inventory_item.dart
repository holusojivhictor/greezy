import 'package:hive/hive.dart';

part 'inventory_item.g.dart';

@HiveType(typeId: 1)
class InventoryItem extends HiveObject {
  @HiveField(0)
  final int itemKey;

  @HiveField(1)
  final int type;

  InventoryItem(this.itemKey, this.type);
}