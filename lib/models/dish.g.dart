// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DishAdapter extends TypeAdapter<Dish> {
  @override
  final int typeId = 0;

  @override
  Dish read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dish(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as double,
      imageUrl: fields[4] as String,
      category: fields[5] as DishCategory,
      likes: fields[6] as int,
      dislikes: fields[7] as int,
      comments: (fields[8] as List).cast<String>(),
      isFavorite: fields[9] as bool,
      isAvailable: fields[10] as bool,
      ingredients: (fields[11] as List).cast<String>(),
      nutritionalInfo: (fields[12] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Dish obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.likes)
      ..writeByte(7)
      ..write(obj.dislikes)
      ..writeByte(8)
      ..write(obj.comments)
      ..writeByte(9)
      ..write(obj.isFavorite)
      ..writeByte(10)
      ..write(obj.isAvailable)
      ..writeByte(11)
      ..write(obj.ingredients)
      ..writeByte(12)
      ..write(obj.nutritionalInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DishAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DishCategoryAdapter extends TypeAdapter<DishCategory> {
  @override
  final int typeId = 1;

  @override
  DishCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DishCategory.protein;
      case 1:
        return DishCategory.carbs;
      case 2:
        return DishCategory.healthy_fats;
      case 3:
        return DishCategory.supplements;
      default:
        return DishCategory.protein;
    }
  }

  @override
  void write(BinaryWriter writer, DishCategory obj) {
    switch (obj) {
      case DishCategory.protein:
        writer.writeByte(0);
        break;
      case DishCategory.carbs:
        writer.writeByte(1);
        break;
      case DishCategory.healthy_fats:
        writer.writeByte(2);
        break;
      case DishCategory.supplements:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DishCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
