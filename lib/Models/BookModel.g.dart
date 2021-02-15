// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final typeId = 0;

  @override
  BookModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookModel(
      amount: fields[3] as int,
      author: fields[1] as String,
      brief: fields[4] as String,
      image: fields[2] as String,
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.brief);
  }
}
