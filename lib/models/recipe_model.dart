import 'package:hive/hive.dart';
part 'recipe_model.g.dart';

@HiveType(typeId: 2)
class RecipeModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String category;

  @HiveField(2)
  String description;

  @HiveField(3)
  String imagePath;

  @HiveField(4)
  String username; 

  RecipeModel({
    required this.name,
    required this.category,
    required this.description,
    required this.imagePath,
    required this.username, 
  });
}
