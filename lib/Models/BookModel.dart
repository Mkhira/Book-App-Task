
import 'package:hive/hive.dart';
part 'BookModel.g.dart';
@HiveType(typeId: 1)
class BookModel{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final int amount;
  @HiveField(4)
  final String brief;


   BookModel({this.amount,this.author,this.brief,this.image,this.name});
}