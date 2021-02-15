
import 'package:hive/hive.dart';
part 'UserModel.g.dart';
@HiveType(typeId: 1)
class UserModel{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  UserModel({this.name,this.email,this.password});

}